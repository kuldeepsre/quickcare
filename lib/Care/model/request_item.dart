import 'package:flutter/material.dart';

class RequestItem {
  final String number;
  final String title;
  final String route;
  final String distanceTime;
  final String badgeText;
  final Color badgeBgColor;
  final Color badgeTextColor;
  final Color numberBgColor;
  final Color numberTextColor;

  RequestItem({
    required this.number,
    required this.title,
    required this.route,
    required this.distanceTime,
    required this.badgeText,
    required this.badgeBgColor,
    required this.badgeTextColor,
    required this.numberBgColor,
    required this.numberTextColor,
  });
}