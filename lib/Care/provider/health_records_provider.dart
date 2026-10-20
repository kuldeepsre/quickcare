import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:patientapp/Care/model/health_record.dart';


class HealthRecordsProvider extends ChangeNotifier {
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  final List<HealthRecord> _records = const [
    HealthRecord(
      title: 'Complete Blood Count',
      sub: 'Lab report · 12 Jun 2025',
      icon: HealthRecordType.lab,
    ),
    HealthRecord(
      title: 'Home Nursing Summary',
      sub: 'Visit notes · 08 Jun 2025',
      icon: HealthRecordType.visit,
    ),
    HealthRecord(
      title: 'Ambulance Trip Summary',
      sub: 'Transport · 21 May 2025',
      icon: HealthRecordType.transport,
    ),
  ];

  List<HealthRecord> get records => List.unmodifiable(_records);

  List<HealthRecord> get filteredRecords {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return records;
    }

    return _records.where((record) {
      return record.title.toLowerCase().contains(query) ||
          record.sub.toLowerCase().contains(query);
    }).toList();
  }

  int get totalRecords => _records.length;

  int get labReports =>
      _records.where((r) => r.icon == HealthRecordType.lab).length;

  int get careVisits =>
      _records.where((r) => r.icon == HealthRecordType.visit).length;

  void searchRecords(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }
}