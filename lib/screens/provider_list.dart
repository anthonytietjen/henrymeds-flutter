import 'package:flutter/material.dart';
import 'package:henry_meds/models/availability.dart';
import 'package:henry_meds/models/provider.dart';
import 'package:henry_meds/services/api.dart';

class ProviderList extends StatefulWidget {
  const ProviderList({super.key});

  @override
  State<ProviderList> createState() => _ProviderListState();
}

class _ProviderListState extends State<ProviderList> {
  void _onProviderPressed(String providerId) async {
    // TODO: Show loading indicator
    List<Availability> availabilities = await getAvailabilities(providerId);

    final date = await _promptForDate(availabilities);
    if (date != null) {
      // TODO:
    }
  }

  Future<DateTime?> _promptForDate(List<Availability> availabilities) async {
    final firstDate = DateTime.now();
    final lastDate = DateTime.now().add(const Duration(days: 14));

    final date = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: lastDate,
        selectableDayPredicate: (day) => availabilities.any((element) =>
            DateTime(element.date.year, element.date.month, element.date.day) ==
            DateTime(day.year, day.month, day.day)));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Choose Provider'),
      ),
      body: FutureBuilder<List<Provider>>(
        future: getProviders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Provider provider = snapshot.data![index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    // TODO: Show provider's profile picture
                    child: const Icon(Icons.person),
                  ),
                  title: Text(
                    "${provider.title} ${provider.firstName} ${provider.lastName}",
                  ),
                  onTap: () => {_onProviderPressed(provider.id)},
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
    );
  }
}
