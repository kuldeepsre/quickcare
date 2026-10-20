class HealthRecord {
  final String title;
  final String sub;
  final HealthRecordType icon;
  const HealthRecord({
    required this.title,
    required this.sub,
    required this.icon,
  });
}
enum HealthRecordType {
  lab,
  visit,
  transport,
}