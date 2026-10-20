import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:patientapp/Care/provider/notification_provider.dart';
import 'package:patientapp/main.dart';


import '../firebase_options.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';




import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:patientapp/firebase_options.dart';
import 'package:patientapp/Care/provider/notification_provider.dart';

// Use the same key that is configured in MaterialApp.

import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:patientapp/firebase_options.dart';
import 'package:patientapp/Care/provider/notification_provider.dart';

const String notificationStorageKey = 'saved_notifications';

const AndroidNotificationChannel notificationChannel =
AndroidNotificationChannel(
  'general_notifications',
  'General Notifications',
  description: 'General push notifications',
  importance: Importance.max,
);

/// Shared navigator key. Prefer passing your app's existing key
/// to PushNotificationService instead of creating another key.
final GlobalKey<NavigatorState> globalsNavigatorKey =
GlobalKey<NavigatorState>();

/// Background FCM handler.
///
/// This function must be top-level, not inside a class.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
    ) async {


  const storage = FlutterSecureStorage();

  try {
    final String? data = await storage.read(
      key: notificationStorageKey,
    );

    final List<dynamic> saved =
    data != null && data.isNotEmpty
        ? jsonDecode(data) as List<dynamic>
        : <dynamic>[];

    final notification = message.notification;

    final String title = notification?.title ??
        message.data['title']?.toString() ??
        'Notification';

    final String body = notification?.body ??
        message.data['body']?.toString() ??
        '';

    final String id = message.messageId ??
        message.data['id']?.toString() ??
        '${title}_${body}_${message.sentTime?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch}';

    final bool exists = saved.any(
          (item) =>
      item is Map &&
          item['id']?.toString() == id,
    );

    if (!exists) {
      saved.insert(0, {
        'id': id,
        'title': title,
        'body': body,
        'createdAt': DateTime.now().toIso8601String(),
        'isRead': false,
      });

      await storage.write(
        key: notificationStorageKey,
        value: jsonEncode(saved),
      );
    }

    debugPrint('Background notification saved: $id');
  } catch (e, stackTrace) {
    debugPrint('Background notification error: $e');
    debugPrintStack(stackTrace: stackTrace);
  }
}

class PushNotificationService {
  PushNotificationService({
    GlobalKey<NavigatorState>? navigatorKey,
  }) : _navigatorKey =
      navigatorKey ?? globalsNavigatorKey;

  final GlobalKey<NavigatorState> _navigatorKey;

  final FirebaseMessaging _messaging =
      FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  NotificationProvider? _provider;

  bool _initialized = false;

  Future<void> initialize(
      NotificationProvider provider,
      ) async {
    if (_initialized) return;

    _provider = provider;

    // Restore local notification history.
    await provider.loadNotifications();

    // Request notification permissions on iOS and Android.
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    debugPrint(
      'FCM authorization: ${settings.authorizationStatus}',
    );

    // We display foreground notifications ourselves below.
    // This avoids duplicate foreground alerts.
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );

    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      ),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        _openNotificationScreen();
      },
    );

    // Android notification channel.
    final androidPlugin = _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(
      notificationChannel,
    );

    await androidPlugin?.requestNotificationsPermission();

    // Print current FCM token.
    await getToken();

    _messaging.onTokenRefresh.listen((token) {
      debugPrint('FCM token refreshed: $token');
    });

    // Foreground message.
    FirebaseMessaging.onMessage.listen((message) async {
      await _saveMessage(message);
      await _showLocalNotification(message);
    });

    // FCM notification tapped while app is in background.
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      await _saveMessage(message);
      _openNotificationScreen();
    });

    // FCM notification tapped when app was terminated.
    final initialMessage = await _messaging.getInitialMessage();

    if (initialMessage != null) {
      await _saveMessage(initialMessage);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _openNotificationScreen();
      });
    }

    // Local notification tapped when app was terminated.
    final launchDetails =
    await _localNotifications.getNotificationAppLaunchDetails();

    if (launchDetails?.didNotificationLaunchApp ?? false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _openNotificationScreen();
      });
    }

    _initialized = true;
  }

  void _openNotificationScreen() {
    _navigatorKey.currentState?.pushNamed('/notifications');
  }

  Future<String?> getToken() async {
    try {
      final token = await _messaging.getToken();

      if (token == null || token.isEmpty) {
        debugPrint('FCM token not available yet.');
      } else {
        debugPrint('FCM token: $token');
      }

      return token;
    } catch (error, stackTrace) {
      debugPrint('Error getting FCM token: $error');
      debugPrintStack(stackTrace: stackTrace);
      return null;
    }
  }

  Future<void> _saveMessage(RemoteMessage message) async {
    final provider = _provider;
    if (provider == null) return;

    final notification = message.notification;

    final String title = notification?.title ??
        message.data['title']?.toString() ??
        'Notification';

    final String body = notification?.body ??
        message.data['body']?.toString() ??
        '';

    final String id = message.messageId ??
        message.data['id']?.toString() ??
        '${title}_${body}_${message.sentTime?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch}';

    await provider.addNotification(
      id: id,
      title: title,
      body: body,
    );
  }

  Future<void> _showLocalNotification(
      RemoteMessage message,
      ) async {
    final notification = message.notification;

    final String? title = notification?.title ??
        message.data['title']?.toString();

    final String? body = notification?.body ??
        message.data['body']?.toString();

    if (title == null && body == null) return;

    final int id = message.messageId?.hashCode ??
        DateTime.now().millisecondsSinceEpoch.remainder(
          2147483647,
        );

    await _localNotifications.show(
      id,
      title ?? 'Notification',
      body ?? '',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'general_notifications',
          'General Notifications',
          channelDescription: 'General push notifications',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }
}
