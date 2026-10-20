import 'package:intl/intl.dart';

class DateTimeUtils {
  DateTimeUtils._();

  // Common date formats
  static const String _dateFormat = 'dd-MM-yyyy';
  static const String _apiDateFormat = 'yyyy-MM-dd';
  static const String _slashDateFormat = 'dd/MM/yyyy';
  static const String _shortDateFormat = 'dd MMM yyyy';
  static const String _fullDateFormat = 'dd MMMM yyyy';

  // Common time formats
  static const String _time12Format = 'hh:mm a';
  static const String _time24Format = 'HH:mm';
  static const String _timeSecondsFormat = 'hh:mm:ss a';

  // Date formatting
  static String formatDate(DateTime? date) => _format(date, _dateFormat);

  static String formatDateSlash(DateTime? date) =>
      _format(date, _slashDateFormat);

  static String formatApiDate(DateTime? date) => _format(date, _apiDateFormat);

  static String formatShortDate(DateTime? date) =>
      _format(date, _shortDateFormat);

  static String formatFullDate(DateTime? date) =>
      _format(date, _fullDateFormat);

  static String formatDayName(DateTime? date) => _format(date, 'EEEE');

  static String formatMonthYear(DateTime? date) => _format(date, 'MMMM yyyy');

  static String formatShortMonthYear(DateTime? date) =>
      _format(date, 'MMM yyyy');

  // Time formatting
  static String formatTime12Hour(DateTime? date) =>
      _format(date, _time12Format);

  static String formatTime24Hour(DateTime? date) =>
      _format(date, _time24Format);

  static String formatTimeWithSeconds(DateTime? date) =>
      _format(date, _timeSecondsFormat);

  // Date and time formatting
  static String formatDateTime(DateTime? date) =>
      _format(date, 'dd-MM-yyyy hh:mm a');

  static String formatApiDateTime(DateTime? date) =>
      _format(date, "yyyy-MM-dd'T'HH:mm:ss");

  static String formatAppointment(DateTime? date) =>
      _format(date, 'EEE, dd MMM • hh:mm a');

  // Custom format
  static String formatCustom(DateTime? date, {required String pattern}) =>
      _format(date, pattern);

  // Parse ISO-compatible date strings
  static DateTime? parse(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    return DateTime.tryParse(value.trim());
  }

  // Parse using a specified format
  static DateTime? parseCustom(String? value, {required String pattern}) {
    if (value == null || value.trim().isEmpty) return null;

    try {
      return DateFormat(pattern).parseStrict(value.trim());
    } catch (_) {
      return null;
    }
  }

  // Current date and time
  static DateTime now() => DateTime.now();

  // Today's date at midnight
  static DateTime today() {
    final date = now();
    return DateTime(date.year, date.month, date.day);
  }

  // Date comparisons
  static bool isToday(DateTime? date) => isSameDay(date, now());

  static bool isSameDay(DateTime? first, DateTime? second) {
    if (first == null || second == null) return false;

    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  static int differenceInDays(DateTime first, DateTime second) {
    final start = DateTime(first.year, first.month, first.day);
    final end = DateTime(second.year, second.month, second.day);

    return end.difference(start).inDays;
  }

  // Today, Yesterday, Tomorrow, or formatted date
  static String formatRelativeDate(DateTime? date) {
    if (date == null) return '';

    final difference = differenceInDays(now(), date);

    switch (difference) {
      case 0:
        return 'Today';
      case 1:
        return 'Tomorrow';
      case -1:
        return 'Yesterday';
      default:
        return formatShortDate(date);
    }
  }

  // Private formatter
  static String _format(DateTime? date, String pattern) {
    if (date == null) return '';

    return DateFormat(pattern).format(date);
  }
}
/*final date = DateTime.now();

print(DateTimeUtils.formatDate(date));           // 16-10-2026
print(DateTimeUtils.formatDateSlash(date));      // 16/10/2026
print(DateTimeUtils.formatApiDate(date));        // 2026-10-16
print(DateTimeUtils.formatShortDate(date));      // 16 Oct 2026
print(DateTimeUtils.formatFullDate(date));       // 16 October 2026

print(DateTimeUtils.formatTime12Hour(date));     // 10:30 AM
print(DateTimeUtils.formatTime24Hour(date));     // 10:30
print(DateTimeUtils.formatDateTime(date));       // 16-10-2026 10:30 AM

print(DateTimeUtils.formatRelativeDate(date));   // Today*/