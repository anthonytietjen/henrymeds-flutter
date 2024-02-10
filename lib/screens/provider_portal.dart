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

  void _onAddAvailabilityPressed() {
    // TODO: Show new scren
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
                            buildDaySummary(availability.date),
                          ),
                          subtitle: Text(
                            buildTimeSummary(availability.times),
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
