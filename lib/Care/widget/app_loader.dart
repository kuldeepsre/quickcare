import 'package:flutter/material.dart';

class AppLoader {
  AppLoader._();

  static bool _isShowing = false;

  static void show({
    required BuildContext context,
    String message = 'Please wait...',
  }) {
    if (_isShowing) return;

    _isShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (dialogContext) {
        return PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Color(0xFF007A55),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(() {
      _isShowing = false;
    });
  }

  static void hide(BuildContext context) {
    if (!_isShowing) return;

    final navigator = Navigator.of(
      context,
      rootNavigator: true,
    );

    if (navigator.canPop()) {
      navigator.pop();
    }
  }
}