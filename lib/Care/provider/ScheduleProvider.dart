import 'package:flutter/cupertino.dart';
import 'package:patientapp/Care/model/DateModel.dart';

class ScheduleProvider extends ChangeNotifier {
  List<DateModel> dates = [];
  List<TimeModel> times = [];
  DateModel? selectedDate;
  TimeModel? selectedTime;
  bool isLoadingDate = true;
  bool isLoadingTime = false;
  ScheduleProvider() {
    fetchDates();
  }
  Future<void> fetchDates() async {
    isLoadingDate = true;
    notifyListeners();
    // final res = await Api.get('/available-dates');
    // final data = jsonDecode(res.body) as List;
    // dates = data.map((e) => DateModel.fromJson(e)).toList();
    await Future.delayed(const Duration(seconds: 1)); // mock
    dates = [
      DateModel(label: 'Today', day: '18', value: 18, fullDate: '2026-06-18'),
      DateModel(label: 'Tomorrow', day: '19', value: 19, fullDate: '2026-06-19'),
      DateModel(label: '20 Jun', day: '20', value: 20, fullDate: '2026-06-20'),
    ];
    selectedDate = dates.first;
    isLoadingDate = false;
    notifyListeners();
    fetchTimes(selectedDate!);
  }
  Future<void> fetchTimes(DateModel date) async {
    isLoadingTime = true;
    selectedDate = date;
    selectedTime = null;
    times = [];
    notifyListeners();
    // final res = await Api.get('/available-times?date=${date.fullDate}');
    // final data = jsonDecode(res.body) as List;
    // times = data.map((e) => TimeModel.fromJson(e)).toList();
    await Future.delayed(const Duration(milliseconds: 500)); // mock
    times = [
      TimeModel(label: '9:00 AM', value: '09:00'),
      TimeModel(label: '10:30 AM', value: '10:30'),
      TimeModel(label: '12:00 PM', value: '12:00'),
      TimeModel(label: '3:30 PM', value: '15:30'),
    ];
    isLoadingTime = false;
    notifyListeners();
  }
  void selectTime(TimeModel time) {
    selectedTime = time;
    notifyListeners();
  }
}