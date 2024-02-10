import 'package:intl/intl.dart';

String formatHour(double hour) {
  int hours = hour.floor();
  int minutes = ((hour - hours) * 60).round();
  DateTime time = DateTime(1, 1, 1, hours, minutes);
  return DateFormat('h:mm a').format(time);
}

String buildDaySummary(DateTime date) {
  return DateFormat('MMM d, yyyy').format(date);
}

String formatTwoLetterDay(DateTime date) {
  final dayOfWeek = DateFormat('EEEE').format(date);
  return dayOfWeek.substring(0, 2);
}

buildTimeSummary(List<double> timeList) {
  // TODO: Make the summary look like this:
  // 8:00 AM to 12:00 PM, 1:00 PM to 5:00 PM

  List<String> times = [];

  for (double time in timeList) {
    times.add(formatHour(time));
  }

  return times.join(', ');
}
