import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/provider/LanguageProvider.dart';
import 'package:provider/provider.dart';

class EarningsScreen extends StatelessWidget {

  const EarningsScreen({super.key});

  @override
  Widget fileBuild(BuildContext context) => build(context);
  @override
  Widget build(BuildContext context) {
    final langProvider = context.watch<LanguageProvider>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(langProvider.translate( 'earnings'), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Earnings', style: TextStyle(color: Colors.white70)),
                SizedBox(height: 8),
                Text('₹14,850', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}