
import 'dart:async';

import 'package:flutter/material.dart';

class OtpProvider extends ChangeNotifier {
  static const int otpLength = 4;
  static const int resendSeconds = 30;

  final List<String> _digits = List.filled(otpLength, '');
  Timer? _timer;

  int _remainingSeconds = resendSeconds;
  bool _isVerifying = false;
  bool _isResending = false;
  String? _errorMessage;

  String get otp => _digits.join();
  List<String> get digits => List.unmodifiable(_digits);

  int get remainingSeconds => _remainingSeconds;
  bool get isVerifying => _isVerifying;
  bool get isResending => _isResending;
  String? get errorMessage => _errorMessage;

  bool get isOtpComplete =>
      _digits.every((digit) => digit.isNotEmpty);

  OtpProvider() {
    startResendTimer();
  }

  void updateDigit(int index, String value) {
    if (index < 0 || index >= otpLength) return;

    final filtered = value.replaceAll(RegExp(r'[^0-9]'), '');

    _digits[index] =
    filtered.isEmpty ? '' : filtered.substring(filtered.length - 1);

    _errorMessage = null;
    notifyListeners();
  }

  void clearOtp() {
    for (var i = 0; i < otpLength; i++) {
      _digits[i] = '';
    }

    _errorMessage = null;
    notifyListeners();
  }

  void startResendTimer() {
    _timer?.cancel();
    _remainingSeconds = resendSeconds;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 1) {
        _remainingSeconds = 0;
        timer.cancel();
      } else {
        _remainingSeconds--;
      }

      notifyListeners();
    });
  }

  Future<bool> verifyOtp({
    required String phoneNumber,
  }) async {
    if (!isOtpComplete) {
      _errorMessage = 'Please enter the complete 4-digit OTP.';
      notifyListeners();
      return false;
    }

    _isVerifying = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Call your actual OTP verification API here.
      // Send phoneNumber and otp to your backend.
      //
      // Return true only when the server confirms the OTP.

      await Future<void>.delayed(const Duration(milliseconds: 300));

      // Demo only: this does NOT verify the OTP with a server.
      _errorMessage = 'Connect your OTP verification API.';
      return false;
    } catch (e) {
      _errorMessage = 'OTP verification failed. Please try again.';
      return false;
    } finally {
      _isVerifying = false;
      notifyListeners();
    }
  }

  Future<bool> resendOtp({
    required String phoneNumber,
  }) async {
    if (_remainingSeconds > 0 || _isResending) return false;

    _isResending = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Call your resend OTP API here.
      // Restart the countdown only after a successful API response.

      _errorMessage = 'Connect your resend OTP API.';
      return false;
    } catch (e) {
      _errorMessage = 'Could not resend OTP. Please try again.';
      return false;
    } finally {
      _isResending = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}