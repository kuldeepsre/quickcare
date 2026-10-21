import 'package:flutter/material.dart';
import 'package:patientapp/Care/model/FamilyMember.dart';

class FamilyProvider extends ChangeNotifier {
  final List<FamilyMember> _members = [
    FamilyMember(
      initials: 'AK',
      name: 'Arjun Kapor',
      subtitle: 'You',
      bookings: '2',
      records: '8',
      bgColor: const Color(0xFF0E4A3E),
    ),
    FamilyMember(
      initials: 'SK',
      name: 'Sunita Kapor',
      subtitle: 'Mother · 62 years',
      bookings: '2',
      records: '8',
      bgColor: const Color(0xFFC07A6F),
    ),
  ];

  List<FamilyMember> get members => _members;

  void addMember(FamilyMember member) {
    _members.add(member);
    notifyListeners();
  }
}