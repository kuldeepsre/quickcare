import 'dart:async';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';



class NetworkService {
  NetworkService._();

  static final NetworkService instance = NetworkService._();

  StreamSubscription<InternetStatus>? _subscription;

  final StreamController<bool> _controller =
  StreamController<bool>.broadcast();

  bool _isConnected = false;
  bool _isChecking = false;

  bool get isConnected => _isConnected;

  bool get isChecking => _isChecking;

  Stream<bool> get connectionStream => _controller.stream;

  // Start automatic connection monitoring
  void startListening() {
    if (_subscription != null) return;

    _subscription =
        InternetConnection().onStatusChange.listen(
              (InternetStatus status) {
            _updateConnection(
              status == InternetStatus.connected,
            );
          },
          onError: (_) {
            _updateConnection(false);
          },
        );
  }

  // Check actual internet access manually
  Future<bool> checkConnection() async {
    if (_isChecking) return _isConnected;

    _isChecking = true;

    try {
      final connected =
      await InternetConnection().hasInternetAccess;

      _updateConnection(connected);
      return connected;
    } catch (_) {
      _updateConnection(false);
      return false;
    } finally {
      _isChecking = false;
    }
  }

  // Update status and notify listeners
  void _updateConnection(bool connected) {
    _isConnected = connected;

    if (!_controller.isClosed) {
      _controller.add(connected);
    }
  }

  // Clean up when monitoring is permanently stopped
  Future<void> dispose() async {
    await _subscription?.cancel();
    _subscription = null;

    if (!_controller.isClosed) {
      await _controller.close();
    }
  }
}