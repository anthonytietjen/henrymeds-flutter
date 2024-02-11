import 'package:flutter/material.dart';
import 'package:henry_meds/components/custom_button.dart';
import 'package:henry_meds/services/api.dart';
import 'package:henry_meds/utils/date_utils.dart';
import 'package:henry_meds/models/availability.dart';

class ProviderPortal extends StatefulWidget {
  const ProviderPortal({super.key});

  @override
  State<ProviderPortal> createState() => _HomeState();
}

class _HomeState extends State<ProviderPortal> {
  void _onExistingAvailabilityPressed(DateTime date) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Under Construction'),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context, 'OK'),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> _promptForDate() async {
    final firstDate = DateTime.now();
    final lastDate = DateTime.now().add(const Duration(days: 14));
    final date = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    return date;
  }

  Future<TimeOfDay?> _promptForTime(TimeOfDay initialTime) async {
    // TODO: Build a better widget that only presents 15 minute increments for selection
    // TODO: when returning to this after showing message about 15 minute increment requirement, default to the minute selection
    final time = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (time != null) {
      // If it is not a 15 minute increment, prompt again and show a message
      if (time.minute % 15 != 0) {
        _promptForTime(time);
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Please select 15 minute increment'),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () => Navigator.pop(context, 'OK'),
              ),
            ],
          ),
        );
      } else {
        return time;
      }
    }

    return null;
  }

  void _onAddAvailabilityPressed() async {
    final date = await _promptForDate();
    if (date != null) {
      final initialTime = TimeOfDay.fromDateTime(DateTime.utc(1, 1, 1, 8, 0));
      final time = await _promptForTime(initialTime);

      if (time != null) {
        // Confirm Selection
        final formattedDate = formatDay(date);
        final formattedTime = formatHourFromTimeOfDay(time);
        var result = await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Confirm'),
            content: Text(
                'Confirm your selection:\n$formattedDate at $formattedTime'),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context, 'Cancel'),
              ),
              TextButton(
                child: const Text("Save"),
                onPressed: () => Navigator.pop(context, 'Save'),
              ),
            ],
          ),
        );

        if (result == "Save") {
          final availabilityDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );

          // TODO: Show a loading indicator while saving
          final success = await saveNewAvailability(availabilityDateTime);
          final message =
              success ? "Sucessfully added" : "Error saving. Please try again";

          // Show snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              duration: Duration(seconds: 2),
            ),
          );

          // TODO: Add it to the list if it was successfully added to the api
        }
      }
    }
  }

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
              child: FutureBuilder<List<Availability>>(
                future: getMyAvailabilities(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Availability availability = snapshot.data![index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            child: Text(formatTwoLetterDay(availability.date)),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          title: Text(
                            formatDay(availability.date),
                          ),
                          subtitle: Text(
                            formatTimeRanges(availability.times),
                          ),
                          onTap: () => {
                            _onExistingAvailabilityPressed(availability.date)
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 40, left: 14, right: 14),
              child: CustomButton(
                onPressed: _onAddAvailabilityPressed,
                key: const Key('buttonAddAvailability'),
                title: 'Add Availability',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
