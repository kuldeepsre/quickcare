import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/model/StatCardData.dart';

class StatProvider extends ChangeNotifier {
  final List<StatCardData> _statCards = [
    const StatCardData(
      icon: Icons.monitor_heart_outlined,
      iconColor: Color(0xFF0A5C36),
      iconBgColor: Color(0xFFE6F2EC),
      count: '12',
      title: 'Incoming patients',
      subtitle: '3 arriving soon',
    ),
    const StatCardData(
      icon: Icons.access_time_rounded,
      iconColor: Color(0xFF0284C7),
      iconBgColor: Color(0xFFE0F2FE),
      count: '18',
      title: 'Beds available',
      subtitle: '6 ICU beds',
    ),
    const StatCardData(
      icon: Icons.verified_user_outlined,
      iconColor: Color(0xFF7C3AED),
      iconBgColor: Color(0xFFF3E8FF),
      count: '7',
      title: 'Active transfers',
      subtitle: '2 high priority',
    ),
    const StatCardData(
      icon: Icons.description_outlined,
      iconColor: Color(0xFFD97706),
      iconBgColor: Color(0xFFFEF3C7),
      count: '14 min',
      title: 'Avg. handover',
      subtitle: 'Within target',
    ),
  ];

  List<StatCardData> get statCards => _statCards;
}