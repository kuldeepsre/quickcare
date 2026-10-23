
import 'package:flutter/material.dart';

enum SnackbarType {
  success,
  error,
  warning,
  info,
}

class CustomSnackbar {
  CustomSnackbar._();

  static void show(
      BuildContext context, {
        required String message,
        SnackbarType type = SnackbarType.info,
        Duration duration = const Duration(seconds: 3),
      }) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.hideCurrentSnackBar();

    final Color backgroundColor;
    final IconData icon;

    switch (type) {
      case SnackbarType.success:
        backgroundColor = const Color(0xFF007A55);
        icon = Icons.check_circle_outline;
        break;

      case SnackbarType.error:
        backgroundColor = const Color(0xFFD32F2F);
        icon = Icons.error_outline;
        break;

      case SnackbarType.warning:
        backgroundColor = const Color(0xFFF57C00);
        icon = Icons.warning_amber_rounded;
        break;

      case SnackbarType.info:
        backgroundColor = const Color(0xFF1976D2);
        icon = Icons.info_outline;
        break;
    }

    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}
