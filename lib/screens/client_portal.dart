import 'package:flutter/material.dart';
import 'package:henry_meds/components/custom_button.dart';
import 'package:henry_meds/screens/provider_list.dart';

class ClientPortal extends StatefulWidget {
  const ClientPortal({super.key});

  @override
  State<ClientPortal> createState() => _ClientPortalState();
}

class _ClientPortalState extends State<ClientPortal> {
  void _onScheduleNewAppointmentPressed() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ProviderList()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:
            Colors.white, //Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Client Portal'),
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
