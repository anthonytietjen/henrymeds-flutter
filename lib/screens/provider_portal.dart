import 'package:flutter/material.dart';
import 'package:henry_meds/utils/date_utils.dart';
import 'package:henry_meds/models/availability.dart';

class ProviderPortal extends StatefulWidget {
  const ProviderPortal({super.key});

  @override
  State<ProviderPortal> createState() => _HomeState();
}

class _HomeState extends State<ProviderPortal> {
  late List<Availability> _availabilities;

  @override
  void initState() {
    super.initState();

    _availabilities = List.generate(
      28,
      (index) => Availability(
        date: DateTime.utc(2024, 2, index + 1),
        times: [13.0, 13.15, 13.5, 13.45],
      ),
    );
  }

  void _onAddAvailabilityPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Provider Portal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 14, right: 14, bottom: 0),
              child: Text(
                'My Availability',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _availabilities.length,
                itemBuilder: (context, index) {
                  final availability = _availabilities[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      child: Text(formatTwoLetterDay(availability.date)),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    title: Text(
                      buildDaySummary(availability.date),
                    ),
                    subtitle: Text(
                      buildTimeSummary(availability.times),
                    ),
                    onTap: () => {},
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 40, left: 14, right: 14),
              child: ElevatedButton(
                onPressed: _onAddAvailabilityPressed,
                key: const Key('buttonAddAvailability'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  foregroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(40),
                ),
                child: const Text(
                  'Add Availability',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
