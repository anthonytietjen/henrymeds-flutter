import 'package:henry_meds/models/availability.dart';

Future<List<Availability>> getMyAvailabilities() async {
  // TODO: Filter by logged in provider

  // Simiulate network latency
  await Future.delayed(const Duration(milliseconds: 750));

  // Build fake data
  final List<Availability> availabilities = List.generate(
    28,
    (index) => Availability(
      date: DateTime.utc(2024, 2, index + 1),
      times: [13.0, 13.15, 13.5, 13.45],
    ),
  );

  return availabilities;
}

Future<bool> saveNewAvailability(DateTime date) async {
  // TODO: Use logged in provider's session

  // Simiulate network latency
  await Future.delayed(const Duration(milliseconds: 750));

  return true;
}
