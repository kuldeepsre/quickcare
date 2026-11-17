import 'package:flutter/cupertino.dart';
import 'package:patientapp/Care/model/ArrivalItemData.dart';

class ArrivalProvider extends ChangeNotifier {
  final List<ArrivalItemData> _arrivalList = [
    const ArrivalItemData(
      indexNumber: '01',
      indexBgColor: Color(0xFFFEE2E2),
      indexTextColor: Color(0xFFDC2626),
      title: 'QC Ambulance · AMB-118',
      subtitle: 'Cardiac emergency · Male, 58',
      etaText: 'ETA 6 minutes · Bay 2 assigned',
      statusLabel: 'Critical',
      statusBgColor: Color(0xFFFEE2E2),
      statusTextColor: Color(0xFFDC2626),
    ),
    const ArrivalItemData(
      indexNumber: '02',
      indexBgColor: Color(0xFFFEF3C7),
      indexTextColor: Color(0xFFD97706),
      title: 'QC Ambulance · AMB-092',
      subtitle: 'Road accident · Female, 34',
      etaText: 'ETA 14 minutes · Trauma alerted',
      statusLabel: 'Priority',
      statusBgColor: Color(0xFFFEF3C7),
      statusTextColor: Color(0xFFD97706),
    ),
    const ArrivalItemData(
      indexNumber: '03',
      indexBgColor: Color(0xFFE0F2FE),
      indexTextColor: Color(0xFF0284C7),
      title: 'Inter-hospital transfer',
      subtitle: 'Neurology referral · Male, 67',
      etaText: 'Arriving 11:40 AM',
      statusLabel: 'Scheduled',
      statusBgColor: Color(0xFFE0F2FE),
      statusTextColor: Color(0xFF0284C7),
    ),
  ];

  List<ArrivalItemData> get arrivalList => _arrivalList;

  // Example method to add or update items dynamically if needed
  void addArrival(ArrivalItemData newItem) {
    _arrivalList.add(newItem);
    notifyListeners();
  }
}