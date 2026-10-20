import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/Screens/MainNavigationScreen.dart';
import 'package:patientapp/Care/provider/LanguageProvider.dart';
import 'package:patientapp/Care/provider/otp_provider.dart';
import 'package:patientapp/utils/AppRoute.dart';
import 'package:patientapp/utils/SessionManager.dart';
import 'package:patientapp/utils/constants.dart';
import 'package:patientapp/utils/custom_logger.dart';
import 'package:provider/provider.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Replace these with your actual project imports.
// import '../providers/otp_provider.dart';
// import '../providers/language_provider.dart';
// import '../constants/constants.dart';
// import '../routes/app_route.dart';
// import 'main_navigation_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState
    extends State<OtpVerificationScreen> {
  static const Color primaryColor = Color(0xFF007A55);

  final List<TextEditingController> _controllers =
  List.generate(4, (_) => TextEditingController());

  final List<FocusNode> _focusNodes =
  List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNodes.first.requestFocus();
      }
    });
  }

  void _onDigitChanged(
      String value,
      int index,
      OtpProvider provider,
      ) {
    provider.updateDigit(index, value);

    if (value.isNotEmpty) {
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else if (index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> _verifyOtp(OtpProvider provider) async {
    final success = await provider.verifyOtp(
      phoneNumber: Constants.phoneNo,
    );

    if (!mounted) return;

    if (success) {


      AppRoute.toAndRemoveUntil(
        context,
        MainNavigationScreen(),
      );
    } else if (provider.errorMessage != null) {

      await SessionManager.saveSession(
        userId: "0",
        userName: "Patient",
        phone: Constants.phoneNo,
        token: "test_token_12345", // don't leave empty
      );
      bool logged = await SessionManager.isLoggedIn();
      CustomLogger.error("isLogin: $logged"); // Will be true now ✅e
      AppRoute.toAndRemoveUntil(
        context,
        MainNavigationScreen(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.errorMessage!)),
      );
    }
  }

  Future<void> _resendOtp(OtpProvider provider) async {
    final success = await provider.resendOtp(
      phoneNumber: Constants.phoneNo,
    );

    if (!mounted) return;

    if (success) {
      provider.startResendTimer();

      for (final controller in _controllers) {
        controller.clear();
      }

      provider.clearOtp();
      _focusNodes.first.requestFocus();
    } else if (provider.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.errorMessage!)),
      );
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }

    for (final node in _focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = context.watch<LanguageProvider>();
    final otpProvider = context.watch<OtpProvider>();

    // Keep text controllers synchronized with provider state.
    for (var i = 0; i < 4; i++) {
      final digit = otpProvider.digits[i];

      if (_controllers[i].text != digit) {
        _controllers[i].value = TextEditingValue(
          text: digit,
          selection: TextSelection.collapsed(
            offset: digit.length,
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: primaryColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
            
                Text(
                  langProvider.translate('otpTitle'),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
            
                const SizedBox(height: 8),
            
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${langProvider.translate('otpSubtitle')} +91 ${Constants.phoneNo}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.edit,
                        size: 18,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
            
                const SizedBox(height: 36),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 60,
                      height: 60,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: primaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (value) =>
                            _onDigitChanged(value, index, otpProvider),
                        onSubmitted: (_) {
                          if (index == 3) {
                            _verifyOtp(otpProvider);
                          }
                        },
                      ),
                    );
                  }),
                ),
            
                const SizedBox(height: 24),
            
                Center(
                  child: TextButton(
                    onPressed: otpProvider.remainingSeconds == 0 &&
                        !otpProvider.isResending
                        ? () => _resendOtp(otpProvider)
                        : null,
                    child: Text(
                      otpProvider.remainingSeconds > 0
                          ? 'Resend OTP in ${otpProvider.remainingSeconds}s'
                          : langProvider.translate('resendOtp'),
                      style: TextStyle(
                        color: otpProvider.remainingSeconds == 0
                            ? primaryColor
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: otpProvider.isVerifying
                        ? null
                        : () => _verifyOtp(otpProvider),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                      primaryColor.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: otpProvider.isVerifying
                        ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : Text(
                      langProvider.translate('verifyBtn'),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            
            
            
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}