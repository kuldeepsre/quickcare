import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/provider/LanguageProvider.dart';
import 'package:patientapp/Care/widget/ProfileField.dart';
import 'package:patientapp/Care/widget/VerifiedBadge.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    
    final langProvider=context.watch<LanguageProvider>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(langProvider.translate('MyProfile'),
               
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F2D26),
                ),
              ),
              const SizedBox(height: 4),
               Text(langProvider.translate('PersonalDetails'),
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B7F7A),
                ),
              ),
              const SizedBox(height: 24),
              // Main Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE8EFEC)),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0E4A3E),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'AK',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Arjun Kapor',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F2D26),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Patient ID : QC-2048',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF8A9E98),
                                ),
                              ),
                              SizedBox(height: 8),
                              VerifiedBadge(),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFE0E8E5)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          child:  Text(langProvider.translate('EditProfile'),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0E4A3E),
                            ),
                          ),
                        ),
                      ],
                    ),
                     const SizedBox(height: 20),
                     const Divider(color: Color(0xFFEFF4F1), height: 1),
                     const SizedBox(height: 20),
                     ProfileField(
                      label: langProvider.translate('PhoneNumber'),
                      value: '+91 98765 43210',
                    ),
                     const SizedBox(height: 18),
                     ProfileField(
                      label: langProvider.translate('Email'),
                      value: 'arjun.k@example.com',
                    ),
                     const SizedBox(height: 18),
                     ProfileField(
                      label:langProvider.translate('dob'),
                      value: '14 September 1990',
                    ),
                     const SizedBox(height: 18),
                     ProfileField(
                      label: langProvider.translate('BD'),
                      value: 'O positive',
                    ),
                     const SizedBox(height: 18),
                     ProfileField(
                      label:  langProvider.translate('address'),
                      value:
                      '42, 12th Main Road, Indiranagar, Bengaluru 560038',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Privacy Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9F2EF),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFD6E8E0)),
                ),
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0E4A3E).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified_user_outlined,
                        size: 16,
                        color: Color(0xFF0E4A3E),
                      ),
                    ),
                    const SizedBox(width: 10),
                     Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            langProvider.translate('privacy'),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0E4A3E),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            langProvider.translate('medicalInformation'),
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF5F7A73),
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

