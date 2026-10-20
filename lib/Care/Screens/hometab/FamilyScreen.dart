import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/widget/family_card.dart';
import 'package:provider/provider.dart';

import '../../provider/LanguageProvider.dart';

class FamilyScreen extends StatelessWidget {
  const FamilyScreen({super.key});
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
               Text(
                langProvider.translate('Family'),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F2D26),
                ),
              ),
              const SizedBox(height: 4),
               Text(langProvider.translate('ManageCare'),
                style: TextStyle(fontSize: 13, color: Color(0xFF6B7F7A)),
              ),
              const SizedBox(height: 16),
              // Add button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E4A3E),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                ),
                child:  Text("+"+""+langProvider.translate('Addfamilymember'),

                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),
              // Card 1 - You
              const FamilyCard(
                initials: 'AK',
                name: 'Arjun Kapor',
                subtitle: 'You',
                bookings: '2',
                records: '8',
                bgColor: Color(0xFF0E4A3E),
              ),
              const SizedBox(height: 16),
              // Card 2 - Mother
              const FamilyCard(
                initials: 'SK',
                name: 'Sunita Kapor',
                subtitle: 'Mother · 62 years',
                bookings: '2',
                records: '8',
                bgColor: Color(0xFFC07A6F),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
