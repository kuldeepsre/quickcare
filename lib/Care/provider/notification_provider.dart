import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:patientapp/Care/model/app_notification.dart';

class NotificationProvider extends ChangeNotifier {
  static const String _storageKey = 'saved_notifications';

  final FlutterSecureStorage _storage =
  const FlutterSecureStorage();

  List<AppNotification> _notifications = [];
  bool _isLoading = false;
  bool _isLoaded = false;

  List<AppNotification> get notifications =>
      List.unmodifiable(_notifications);

  bool get isLoading => _isLoading;

  int get unreadCount =>
      _notifications.where((item) => !item.isRead).length;

  // Load saved notifications once when the app starts.
  Future<void> loadNotifications() async {
    if (_isLoading || _isLoaded) return;

    _isLoading = true;
    notifyListeners();

    try {
      final data = await _storage.read(key: _storageKey);

      if (data != null && data.isNotEmpty) {
        final decoded = jsonDecode(data) as List<dynamic>;

        _notifications = decoded.map((item) {
          return AppNotification.fromJson(
            Map<String, dynamic>.from(item as Map),
          );
        }).toList();
      } else {
        _notifications = [];
      }

      _isLoaded = true;
    } catch (e) {
      debugPrint('Loading notifications failed: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addNotification({
    required String id,
    required String title,
    required String body,
  }) async {
    await loadNotifications();

    if (_notifications.any((item) => item.id == id)) {
      return;
    }

    _notifications.insert(
      0,
      AppNotification(
        id: id,
        title: title,
        body: body,
        createdAt: DateTime.now(),
      ),
    );

    await _save();
  }

  Future<void> markAsRead(String id) async {
    final index =
    _notifications.indexWhere((item) => item.id == id);

    if (index == -1 || _notifications[index].isRead) return;

    _notifications[index] =
        _notifications[index].copyWith(isRead: true);

    await _save();
  }

  Future<void> markAllAsRead() async {
    _notifications = _notifications
        .map((item) => item.copyWith(isRead: true))
        .toList();

    await _save();
  }

  Future<void> deleteNotification(String id) async {
    _notifications.removeWhere((item) => item.id == id);
    await _save();
  }

  Future<void> clearAll() async {
    _notifications.clear();
    await _save();
  }

  Future<void> _save() async {
    try {
      final notificationList = _notifications
          .map((item) => item.toJson())
          .toList();

      await _storage.write(
        key: _storageKey,
        value: jsonEncode(notificationList),
      );
    } catch (e) {
      debugPrint('Saving notifications failed: $e');
      rethrow;
    } finally {
      notifyListeners();
    }
  }
}