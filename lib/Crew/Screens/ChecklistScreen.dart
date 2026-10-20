import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/provider/LanguageProvider.dart';
import 'package:provider/provider.dart';

class ChecklistScreen extends StatelessWidget {

  const ChecklistScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    final langProvider = context.watch<LanguageProvider>();
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(langProvider.translate( 'checklist'), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 16),
        CheckboxListTile(
          title: Text(langProvider.translate( 'equipCheck')),
          value: true,
          activeColor: Colors.teal,
          onChanged: (val) {},
        ),
      ],
    );
  }
}