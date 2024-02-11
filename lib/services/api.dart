import 'package:henry_meds/models/availability.dart';
import 'package:henry_meds/models/provider.dart';

Future<List<Availability>> getAvailabilities(String providerId) async {
  // Simiulate network latency
  await Future.delayed(const Duration(milliseconds: 750));

  // Build fake data
  final DateTime startDate = DateTime.now().subtract(Duration(days: 1));
  final List<Availability> availabilities = List.generate(
    7,
    (index) => Availability(
      date: startDate.add(Duration(days: index)),
      times: [13.0, 13.15, 13.5, 13.45],
    ),
  );

  return availabilities;
}

Future<List<Provider>> getProviders() async {
  // Simiulate network latency
  await Future.delayed(const Duration(milliseconds: 750));

  // Build fake data
  final List<Provider> providers = List.generate(
    30,
    (index) => Provider(
      id: (index + 1).toString(),
      title: "Dr.",
      firstName: index % 2 == 0 ? "John" : "Jane",
      lastName: "Doe ${(index + 1)}",
    ),
  );

  return providers;
}

Future<bool> saveNewAvailability(DateTime date) async {
  // TODO: Use logged in provider's session when saving

  // Simiulate network latency
  await Future.delayed(const Duration(milliseconds: 750));

  return true;
}
