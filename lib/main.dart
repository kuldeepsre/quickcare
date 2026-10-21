import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/Screens/MainNavigationScreen.dart';
import 'package:patientapp/Care/Screens/notification_screen.dart';
import 'package:patientapp/Care/Screens/splash_screen.dart';
import 'package:patientapp/Care/provider/FamilyProvider.dart';
import 'package:patientapp/Care/provider/booking_provider.dart';
import 'package:patientapp/Care/provider/health_records_provider.dart';
import 'package:patientapp/Care/provider/location_provider.dart';
import 'package:patientapp/Care/provider/navigation_provider.dart';
import 'package:patientapp/Care/provider/notification_provider.dart';
import 'package:patientapp/Care/provider/otp_provider.dart';
import 'package:patientapp/Crew/crew_main_navigation.dart';
import 'package:patientapp/firebase_options.dart';
import 'package:patientapp/utils/push_notification_service.dart';
import 'package:provider/provider.dart';import 'Care/Screens/auth/PhoneLoginScreen.dart';
import 'Care/provider/LanguageProvider.dart';
import 'Care/widget/network_status_widget.dart';

final GlobalKey<NavigatorState> appNavigatorKey =
GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(
    RemoteMessage message,
    ) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

final GlobalKey<NavigatorState> navigatorKey =
GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(
    firebaseBackgroundHandler,
  );

  final notificationProvider = NotificationProvider();

  // Restore notification history before starting the app.
  await notificationProvider.loadNotifications();

  final pushService = PushNotificationService();
  await pushService.initialize(notificationProvider);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NavigationProvider(),
        ),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider.value(value: notificationProvider,),
        ChangeNotifierProvider(create: (_) => OtpProvider(),),
        ChangeNotifierProvider(create: (_) => HealthRecordsProvider(),),
        ChangeNotifierProvider(create: (_) => BookingProvider(),),
        ChangeNotifierProvider(create: (_) => LocationProvider()), // ADD THIS
        ChangeNotifierProvider(create: (_) => FamilyProvider()), // ADD THIS

      ],
      child: const CareApp(),
    ),
  );
}
class CareApp extends StatelessWidget {
  const CareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'क्विककेयर',

        navigatorKey: appNavigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF007A55), // Primary medical green
          primary: const Color(0xFF007A55),
          surface: const Color(0xFFF8F9FA),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        useMaterial3: true,
      ),

      initialRoute: '/',
      routes: {
        '/': (context) =>  SplashScreen(),
        '/notifications': (context) =>
        const NotificationScreen(),
      },
        builder: (context, child) {
          return Column(
            children: [
              const NetworkStatusWidget(),
              Expanded(
                child: child ?? const SizedBox.shrink(),
              ),
            ],
          );
        }
    );
  }
}


