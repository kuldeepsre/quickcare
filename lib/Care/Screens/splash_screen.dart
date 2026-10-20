import 'package:flutter/material.dart';
import 'package:patientapp/Care/Screens/MainNavigationScreen.dart';
import 'package:patientapp/Care/Screens/auth/PhoneLoginScreen.dart';
import 'package:patientapp/Care/dialog/app_loader.dart';
import 'package:patientapp/Care/provider/LanguageProvider.dart';
import 'package:patientapp/utils/AppRoute.dart';
import 'package:patientapp/utils/SessionManager.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    // Go to Home after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PhoneLoginScreen()),
        );
      }
    });

    _checkSession();
  }
  Future<void> _checkSession() async {
    await Future.delayed(const Duration(seconds: 2));
    bool loggedIn = await SessionManager.isLoggedIn();
    Map<String, String?> user = await SessionManager.getUser();
    debugPrint("Session Check: loggedIn=$loggedIn, user=$user");
    if (!mounted) return;
    if (loggedIn) {
     AppRoute.replace(context, MainNavigationScreen());
    } else {
      AppRoute.replace(context, PhoneLoginScreen());
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final langProvider=context.watch<LanguageProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ambulance Logo Animation
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.red.shade600, Colors.red.shade800],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.local_hospital, size: 70, color: Colors.white),
                ),
                const SizedBox(height: 24),
                Text(langProvider.translate('appName'),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0D47A1),
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(langProvider.translate('BookAmbulanceAnytime')
                 ,
                  style: TextStyle(fontSize: 14, color: Colors.grey, letterSpacing: 0.5),
                ),
                const SizedBox(height: 60),
                AppLoader(
                  size: 40,
                  strokeWidth: 4,
                  color: Colors.green,
                ),
                const SizedBox(height: 12),
                Text(langProvider.translate('LoadingEmergencyServices'), style: TextStyle(fontSize: 11, color: Colors.grey.shade400)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.verified_user, size: 14, color: Colors.grey.shade400),
            const SizedBox(width: 6),
            Text(langProvider.translate('safeSecure'), style: TextStyle(fontSize: 11, color: Colors.grey.shade400)),
          ],
        ),
      ),
    );
  }
}