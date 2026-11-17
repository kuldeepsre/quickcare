import 'package:flutter/material.dart';
import 'package:patientapp/Care/model/request_item.dart';

class RequestProvider extends ChangeNotifier {
  final List<RequestItem> _requests = [
    RequestItem(
      number: '01',
      title: 'Emergency pickup',
      route: '100 Feet Road, Indiranagar',
      distanceTime: '1.2 km away · 3 min',
      badgeText: 'Critical',
      badgeBgColor: const Color(0xFFFEECEB),
      badgeTextColor: const Color(0xFFB42318),
      numberBgColor: const Color(0xFFFEECEB),
      numberTextColor: const Color(0xFFB42318),
    ),
    RequestItem(
      number: '02',
      title: 'Hospital transfer',
      route: 'Manipal Hospital → CityCare',
      distanceTime: '4.8 km away · 12 min',
      badgeText: 'Scheduled',
      badgeBgColor: const Color(0xFFEBF3FE),
      badgeTextColor: const Color(0xFF1D4ED8),
      numberBgColor: const Color(0xFFF0F5F9),
      numberTextColor: const Color(0xFF2B547E),
    ),
    RequestItem(
      number: '03',
      title: 'Discharge pickup',
      route: 'St. Martha’s Hospital',
      distanceTime: '6.1 km away · 16 min',
      badgeText: 'Standard',
      badgeBgColor: const Color(0xFFE8F5EF),
      badgeTextColor: const Color(0xFF0B5D3F),
      numberBgColor: const Color(0xFFEFF7F3),
      numberTextColor: const Color(0xFF0B5D3F),
    ),
  ];

  List<RequestItem> get requests => _requests;

  // Optional: Add method to add or remove requests dynamically
  void addRequest(RequestItem item) {
    _requests.add(item);
    notifyListeners();
  }
}