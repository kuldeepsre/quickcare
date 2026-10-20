import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/provider/LanguageProvider.dart';
import 'package:provider/provider.dart';

class HomeNurse extends StatelessWidget {
  const HomeNurse({super.key});

  @override
  Widget build(BuildContext context) {

    final langProvider=context.watch<LanguageProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(langProvider.translate('homeNurse'),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF007A55),
        elevation: 0,
      ),
    );
  }
}
