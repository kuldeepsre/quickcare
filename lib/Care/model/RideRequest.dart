import 'dart:ui';

class RideRequest {
  final String indexTag;
  final String title;
  final String location;
  final String distanceAndEta;
  final String badgeText;
  final Color badgeColor;
  final Color textColor;

  RideRequest({
    required this.indexTag,
    required this.title,
    required this.location,
    required this.distanceAndEta,
    required this.badgeText,
    required this.badgeColor,
    required this.textColor,
  });
}