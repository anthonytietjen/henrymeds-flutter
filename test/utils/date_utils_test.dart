import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:henry_meds/utils/date_utils.dart';

void main() {
  group('date_utils_test', () {
    test('formatTwoLetterDay', () {
      expect(formatTwoLetterDay(DateTime.utc(2024, 2, 10)), 'Sa');
    });

    test('formatDay', () {
      expect(formatDay(DateTime.utc(2024, 1, 2)), 'Jan 2, 2024');
      expect(formatDay(DateTime.utc(2024, 2, 10)), 'Feb 10, 2024');
    });

    test('formatTimeRanges', () {
      expect(
          formatTimeRanges([13.0, 13.5, 13.75]), '1:00 PM, 1:30 PM, 1:45 PM');
    });

    test('formatHourFromTimeOfDay', () {
      expect(formatHourFromTimeOfDay(const TimeOfDay(hour: 13, minute: 30)),
          '1:30 PM');
    });

    test('formatHourFromDouble', () {
      expect(formatHourFromDouble(0.0), '12:00 AM');
      expect(formatHourFromDouble(9.0), '9:00 AM');
      expect(formatHourFromDouble(13.0), '1:00 PM');
      expect(formatHourFromDouble(13.25), '1:15 PM');
      expect(formatHourFromDouble(13.5), '1:30 PM');
      expect(formatHourFromDouble(13.75), '1:45 PM');
    });
  });
}
