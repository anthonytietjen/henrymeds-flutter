import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatHourFromDouble(double hour) {
  int hours = hour.floor();
  int minutes = ((hour - hours) * 60).round();
  DateTime time = DateTime(1, 1, 1, hours, minutes);
  return DateFormat('h:mm a').format(time);
}

String formatHourFromTimeOfDay(TimeOfDay time) {
  DateTime dateTime = DateTime(1, 1, 1, time.hour, time.minute);
  return DateFormat('h:mm a').format(dateTime);
}

String formatDay(DateTime date) {
  return DateFormat('MMM d, yyyy').format(date);
}

String formatTwoLetterDay(DateTime date) {
  final dayOfWeek = DateFormat('EEEE').format(date);
  return dayOfWeek.substring(0, 2);
}

DateTime combineDateWithTimeDouble(DateTime date, double time) {
  final hour = time.floor();
  final minutes = ((time - hour) * 60).round();

  DateTime dateTime = DateTime(
    date.year,
    date.month,
    date.day,
    hour,
    minutes,
  );

  return dateTime;
}
