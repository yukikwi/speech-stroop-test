// Date format
import 'package:intl/intl.dart';
import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';

var dateFormatter = DateFormat.yMMMd();
var chartDateFormatter = DateFormat.EEEE();

String convertDateTime(DateTime date) {
  return dateFormatter.formatInBuddhistCalendarThai(date);
}

String chartDate(DateTime date) {
  return chartDateFormatter.formatInBuddhistCalendarThai(date);
}

String toDate(DateTime date) {
  return date.toIso8601String().split("T")[0];
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isNextDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day + 1;
  }
}
