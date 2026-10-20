import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/provider/LanguageProvider.dart';
import 'package:patientapp/utils/AppColors.dart';
import 'package:provider/provider.dart';

class MyRecords extends StatefulWidget {
  const MyRecords({super.key});
  @override
  State<MyRecords> createState() => _MyRecordsState();
}
class _MyRecordsState extends State<MyRecords> {
  @override
  Widget build(BuildContext context) {
    final langProvider=context.watch<LanguageProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(langProvider.translate('MyRecords'),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        foregroundColor:AppColors.primary,
        elevation: 0,
      ),

    );
  }
}
