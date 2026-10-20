import 'dart:developer' as developer;

class CustomLogger {
  CustomLogger._();

// true = Show logs
// false = Hide logs
  static const bool isEnabled = true;

  static const String _tag = 'PatientApp';
  /* CustomLogger.debug('Button clicked'); */
  static void debug(String message) {
    if (!isEnabled) return;
    _printLog('DEBUG', message, 500);
  }

  static void info(String message) {
    if (!isEnabled) return;
    _printLog('INFO', message, 800);
  }

  static void warning(String message) {
    if (!isEnabled) return;
    _printLog('WARNING', message, 900);
  }

  static void error(String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!isEnabled) return;

    developer.log(
      '[ERROR] $message',
      name: _tag,
      error: error,
      stackTrace: stackTrace,
      level: 1000,
    );
  }

  static void _printLog(String type,
      String message,
      int level,) {
    developer.log(
      '[$type] $message',
      name: _tag,
      level: level,
    );
  }
}
