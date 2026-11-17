import 'dart:ui';

class ArrivalItemData {
  final String indexNumber;
  final Color indexBgColor;
  final Color indexTextColor;
  final String title;
  final String subtitle;
  final String etaText;
  final String statusLabel;
  final Color statusBgColor;
  final Color statusTextColor;

  const ArrivalItemData({
    required this.indexNumber,
    required this.indexBgColor,
    required this.indexTextColor,
    required this.title,
    required this.subtitle,
    required this.etaText,
    required this.statusLabel,
    required this.statusBgColor,
    required this.statusTextColor,
  });
}