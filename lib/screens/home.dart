import 'package:flutter/material.dart';
import 'package:henry_meds/components/custom_button.dart';
import 'package:henry_meds/screens/provider_portal.dart';

class Home extends StatefulWidget {
  final String title;

  const Home({super.key, required this.title});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _onProviderPortalPressed() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ProviderPortal()));
  }

  void _onClientPortalPressed() {
    // TOOD: Open client portal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 60),
              const Image(
                image: AssetImage('assets/images/logo.png'),
                height: 75,
              ),
              const SizedBox(height: 40),
              CustomButton(
                key: const Key('buttonProviderPortal'),
                onPressed: _onProviderPortalPressed,
                title: 'Provider Portal',
              ),
              const SizedBox(height: 10),
              CustomButton(
                key: const Key('buttonClientPortal'),
                onPressed: _onClientPortalPressed,
                title: 'Client Portal',
              ),
              const SizedBox(height: 60),
              Text(
                'Copyright 2024 Henry Meds',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
