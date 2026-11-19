import 'package:flutter/cupertino.dart';

class MetricModel {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String caption;

  MetricModel({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.caption,
  });
}