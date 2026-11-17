import 'dart:ui';

import 'package:flutter/cupertino.dart';

class StatCardData {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String count;
  final String title;
  final String subtitle;

  const StatCardData({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.count,
    required this.title,
    required this.subtitle,
  });
}