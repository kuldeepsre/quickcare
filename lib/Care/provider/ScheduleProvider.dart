import 'package:flutter/cupertino.dart';
import 'package:patientapp/Care/model/DateModel.dart';
import 'package:flutter/material.dart';
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

  Future<void> fetchDates({int count = 7}) async {
    isLoadingDate = true;
    notifyListeners();

    try {
      // Replace this mock with your API call if needed.
      await Future.delayed(const Duration(seconds: 1));

      final today = DateTime.now();
      final todayDate = DateTime(today.year, today.month, today.day);

      dates = List.generate(count, (index) {
        final date = todayDate.add(Duration(days: index));

        String label;

        if (index == 0) {
          label = 'TODAY';
        } else if (index == 1) {
          label = 'TOMORROW';
        } else {
/*          const weekdays = [
            'MON',
            'TUE',
            'WED',
            'THU',
            'FRI',
            'SAT',
            'SUN',
          ];

          label = weekdays[date.weekday - 1];*/
          const months = [
            'JAN', 'FEB', 'MAR', 'APR',
            'MAY', 'JUN', 'JUL', 'AUG',
            'SEP', 'OCT', 'NOV', 'DEC',
          ];

          label = '${months[date.month - 1]} ${date.day}';        }

        final fullDate =
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

        return DateModel(
          label: label,
          day: date.day.toString(),
          value: date.day,
          fullDate: fullDate,
        );
      });

      selectedDate = dates.isNotEmpty ? dates.first : null;

      isLoadingDate = false;
      notifyListeners();

      if (selectedDate != null) {
        await fetchTimes(selectedDate!);
      }
    } catch (e) {
      isLoadingDate = false;
      notifyListeners();
      debugPrint('Error fetching dates: $e');
    }
  }

  Future<void> fetchTimes(DateModel date) async {
    isLoadingTime = true;
    selectedDate = date;
    selectedTime = null;
    times = [];
    notifyListeners();

    try {
      // API example:
      // /available-times?date=${date.fullDate}

      await Future.delayed(const Duration(milliseconds: 500));

      // Mock time slots
      times = [
        TimeModel(label: '9:00 AM', value: '09:00'),
        TimeModel(label: '10:30 AM', value: '10:30'),
        TimeModel(label: '12:00 PM', value: '12:00'),
        TimeModel(label: '3:30 PM', value: '15:30'),
      ];
    } catch (e) {
      times = [];
      debugPrint('Error fetching times: $e');
    } finally {
      isLoadingTime = false;
      notifyListeners();
    }
  }

  void selectTime(TimeModel time) {
    selectedTime = time;
    notifyListeners();
  }
}
