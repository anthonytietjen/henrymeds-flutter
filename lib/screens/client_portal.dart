import 'package:flutter/material.dart';
import 'package:henry_meds/components/custom_button.dart';
import 'package:henry_meds/services/api.dart';
import 'package:henry_meds/utils/date_utils.dart';

class ClientPortal extends StatefulWidget {
  const ClientPortal({super.key});

  @override
  State<ClientPortal> createState() => _ClientPortalState();
}

class _ClientPortalState extends State<ClientPortal> {
  void _onScheduleNewAppointmentPressed() async {
    // TODO: Show next screen
  }

  void _onExistingAppointmentsPressed() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Provider Portal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 2),
              CustomButton(
                key: const Key('buttonScheduleNewAppointment'),
                onPressed: _onScheduleNewAppointmentPressed,
                title: 'Schedule new appointment',
              ),
              const SizedBox(height: 10),
              CustomButton(
                key: const Key('buttonExistingAppointments'),
                onPressed: _onExistingAppointmentsPressed,
                title: 'View my scheduled appointments',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
