import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/provider/LanguageProvider.dart';
import 'package:provider/provider.dart';

class BookAmbulance extends StatefulWidget {
  const BookAmbulance({super.key});

  @override
  State<BookAmbulance> createState() => _BookAmbulanceState();
}

class _BookAmbulanceState extends State<BookAmbulance> {
  @override
  Widget build(BuildContext context) {
    final langProvider=context.watch<LanguageProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(langProvider.translate('bookAmbulance'),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
