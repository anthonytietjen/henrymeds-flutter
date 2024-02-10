import 'package:flutter_test/flutter_test.dart';
import 'package:henry_meds/utils/date_utils.dart';

void main() {
  group('date_utils_test', () {
    test('formatTwoLetterDay', () {
      expect(formatTwoLetterDay(DateTime.utc(2024, 2, 10)), 'Sa');
    });

    test('buildDaySummary', () {
      expect(buildDaySummary(DateTime.utc(2024, 1, 2)), 'Jan 2, 2024');
      expect(buildDaySummary(DateTime.utc(2024, 2, 10)), 'Feb 10, 2024');
    });

    test('buildTimeSummary', () {
      expect(
          buildTimeSummary([13.0, 13.5, 13.75]), '1:00 PM, 1:30 PM, 1:45 PM');
    });

    test('formatHour', () {
      expect(formatHour(0.0), '12:00 AM');
      expect(formatHour(9.0), '9:00 AM');
      expect(formatHour(13.0), '1:00 PM');
      expect(formatHour(13.25), '1:15 PM');
      expect(formatHour(13.5), '1:30 PM');
      expect(formatHour(13.75), '1:45 PM');
    });
  });
}
