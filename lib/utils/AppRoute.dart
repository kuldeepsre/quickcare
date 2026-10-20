import 'package:flutter/cupertino.dart';

class AppRoute {
  // Push a new screen onto the stack
  static Future<T?> to<T>(BuildContext context, Widget page) {
    return Navigator.push<T>(context, _customRoute(page));
  }

  // Replace current screen (e.g., login to home)
  static Future<T?> replace<T, TO>(BuildContext context, Widget page, {TO? result}) {
    return Navigator.pushReplacement<T, TO>(context, _customRoute(page), result: result);
  }

  // Push screen and remove all previous routes (e.g., Logout)
  static Future<T?> toAndRemoveUntil<T>(BuildContext context, Widget page) {
    return Navigator.pushAndRemoveUntil<T>(
      context,
      _customRoute(page),
          (route) => false,
    );
  }

  // Internal custom page route builder
  static Route<T> _customRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.05);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var fadeTween = Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(
            opacity: animation.drive(fadeTween),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}