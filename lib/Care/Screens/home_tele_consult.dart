import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/provider/LanguageProvider.dart';
import 'package:provider/provider.dart';

class TeleConsult extends StatefulWidget {
  const TeleConsult({super.key});

  @override
  State<TeleConsult> createState() => _TeleConsultState();
}

class _TeleConsultState extends State<TeleConsult> {
  @override
  Widget build(BuildContext context) {

    final langProvider=context.watch<LanguageProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(langProvider.translate('teleConsult'),style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF007A55),
        elevation: 0,
      ),
    );
  }
}
