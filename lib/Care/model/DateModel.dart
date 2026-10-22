class DateModel {
  final String label;
  final String day;
  final int value;
  final String fullDate; // 2026-06-18 - use this for real API

  DateModel({
    required this.label,
    required this.day,
    required this.value,
    required this.fullDate,
  });

  factory DateModel.fromJson(Map<String, dynamic> json) {
    return DateModel(
      label: json['label'],
      day: json['day'],
      value: json['value'],
      fullDate: json['full_date'],
    );
  }
}

class TimeModel {
  final String label; // "9:00 AM"
  final String value; // "09:00" - for API
  final bool isAvailable;

  TimeModel({
    required this.label,
    required this.value,
    this.isAvailable = true,
  });

  factory TimeModel.fromJson(Map<String, dynamic> json) {
    return TimeModel(
      label: json['label'],
      value: json['value'],
      isAvailable: json['is_available'] ?? true,
    );
  }
}