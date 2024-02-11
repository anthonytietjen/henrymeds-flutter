import 'package:flutter/material.dart';
import 'package:henry_meds/models/availability.dart';
import 'package:henry_meds/models/provider.dart';
import 'package:henry_meds/services/api.dart';
import 'package:henry_meds/utils/date_utils.dart';

class TimeList extends StatefulWidget {
  Provider provider;
  Availability availability;

  TimeList({super.key, required this.provider, required this.availability});

  @override
  State<TimeList> createState() => _TimeListState();
}

class _TimeListState extends State<TimeList> {
  late List<double> _times;

  Future<void> _confirmSchedule(double selectedTime) async {
    // TODO: Show loading indicator while reserving
    DateTime reservationDateTime = combineDateWithTimeDouble(
      widget.availability.date,
      selectedTime,
    );

    // Reserve the appointment. (It will time out in 30 minutes buy the server if not confirmed in time)
    String reservationId =
        await reserveAppointment(widget.provider.id, reservationDateTime);

    if (reservationId == null) {
      // TODO: Handle error
      return;
    }

    final formattedDate = formatDay(widget.availability.date);
    final formattedTime = formatHourFromDouble(selectedTime);

    // Prompt for confirmation
    var result = await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirm'),
        content:
            Text('Confirm your appointment:\n$formattedDate at $formattedTime'),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context, 'Cancel'),
          ),
          TextButton(
            child: const Text("Confirm Appointment"),
            onPressed: () => Navigator.pop(context, 'Confirm'),
          ),
        ],
      ),
    );

    if (result == "Cancel") {
      // Cancel the reservation
      await cancelReservation(reservationId);
    } else if (result == "Confirm") {
      // TODO: Show loading indicator while confirming reservation
      var reserveSuccess = await confirmAppointment(reservationId);

      if (!reserveSuccess) {
        // TODO: Handle error
        return;
      }

      // Show success message
      await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Your appointment has been confirmed.'),
          content: Text('Please check your email for appointment details.'),
          actions: [
            TextButton(
              child: const Text("Done"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );

      // Go back to Client Portal
      // TODO: Use named routes for better routing
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor:
              Colors.white, //Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Choose Time'),
        ),
        body: ListView.builder(
          itemCount: widget.availability.times.length,
          itemBuilder: (context, index) {
            double time = widget.availability.times[index];
            return ListTile(
              title: Text(
                formatHourFromDouble(time),
                textAlign: TextAlign.center,
              ),
              onTap: () => {_confirmSchedule(time)},
            );
          },
        ));
  }
}
