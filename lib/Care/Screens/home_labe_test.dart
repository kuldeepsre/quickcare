import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/provider/LanguageProvider.dart';
import 'package:provider/provider.dart';

class HomeLabeTest extends StatefulWidget {
  const HomeLabeTest({super.key});

  @override
  State<HomeLabeTest> createState() => _HomeLabeTestState();
}

class _HomeLabeTestState extends State<HomeLabeTest> {

  @override
  Widget build(BuildContext context) {
    final langProvider = context.watch<LanguageProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(langProvider.translate('HomeLabeTest'),style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF007A55),
        elevation: 0,
      ),
    );
  }
}
