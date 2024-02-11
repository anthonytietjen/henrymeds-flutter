import 'package:flutter/material.dart';
import 'package:henry_meds/models/availability.dart';
import 'package:henry_meds/models/provider.dart';
import 'package:henry_meds/screens/time_list.dart';
import 'package:henry_meds/services/api.dart';

class ProviderList extends StatefulWidget {
  const ProviderList({super.key});

  @override
  State<ProviderList> createState() => _ProviderListState();
}

class _ProviderListState extends State<ProviderList> {
  void _onProviderPressed(Provider provider) async {
    // TODO: Show loading indicator
    List<Availability> availabilities = await getAvailabilities(provider.id);

    final date = await _promptForDate(availabilities);

    if (date != null) {
      final availability = availabilities.firstWhere((element) =>
          DateTime(element.date.year, element.date.month, element.date.day) ==
          DateTime(date.year, date.month, date.day));

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TimeList(
                    provider: provider,
                    availability: availability,
                  )));
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
                  onTap: () => {_onProviderPressed(provider)},
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
