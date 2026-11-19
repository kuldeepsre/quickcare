import 'package:flutter/material.dart';
import 'package:patientapp/Care/model/RideRequest.dart';

class DeriverRequestProvider extends ChangeNotifier {
  final List<RideRequest> _requests = [
    RideRequest(
      indexTag: "01",
      title: "Emergency pickup",
      location: "100 Feet Road, Indiranagar",
      distanceAndEta: "1.2 km away · 3 min",
      badgeText: "Critical",
      badgeColor: Colors.red.shade50,
      textColor: Colors.red,
    ),
    RideRequest(
      indexTag: "02",
      title: "Hospital transfer",
      location: "Manipal Hospital → CityCare",
      distanceAndEta: "4.8 km away · 12 min",
      badgeText: "Scheduled",
      badgeColor: Colors.blue.shade50,
      textColor: Colors.blue,
    ),
    RideRequest(
      indexTag: "03",
      title: "Discharge pickup",
      location: "St. Martha’s Hospital",
      distanceAndEta: "6.1 km away · 16 min",
      badgeText: "Standard",
      badgeColor: Colors.grey.shade100,
      textColor: Colors.grey.shade700,
    ),
  ];

  List<RideRequest> get requests => _requests;

  void addRequest(RideRequest request) {
    _requests.add(request);
    notifyListeners();
  }

  void removeRequest(int index) {
    _requests.removeAt(index);
    notifyListeners();
  }
}