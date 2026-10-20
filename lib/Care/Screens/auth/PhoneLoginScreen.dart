import 'package:flutter/material.dart';
import 'package:patientapp/Care/Screens/auth/otp_verification_screen.dart';
import 'package:patientapp/utils/AppColors.dart';
import 'package:patientapp/utils/constants.dart';

import 'package:provider/provider.dart';

import '../../../utils/AppRoute.dart';
import '../../provider/LanguageProvider.dart';


class PhoneLoginScreen extends StatelessWidget {
  const PhoneLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langProvider = context.watch<LanguageProvider>();
    final phoneController = TextEditingController();

    return Scaffold(
   /*   appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          langProvider.translate('appName'),
          style: const TextStyle(
            color: Color(0xFF007A55),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          // Language selector pill
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: ['English', 'हिन्दी', 'भोजपुरी'].map((lang) {
                  bool isSelected = langProvider.currentLanguage == lang;
                  return GestureDetector(
                    onTap: () => langProvider.setLanguage(lang),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF007A55) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        lang,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.white : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),*/
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              langProvider.translate('loginTitle'),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              langProvider.translate('loginSubtitle'),
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: phoneController,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('🇮🇳 +91', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      SizedBox(width: 8),
                      Text('|', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                hintText: langProvider.translate('phoneHint'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF007A55), width: 2),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Constants.phoneNo=phoneController.text.trim();
                  AppRoute.to(context, const OtpVerificationScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: Text(
                  langProvider.translate('continueBtn'),
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

