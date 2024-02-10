import 'package:flutter/material.dart';
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
              ElevatedButton(
                key: const Key('buttonProviderPortal'),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40)),
                onPressed: _onProviderPortalPressed,
                child: const Text('Provider Portal'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                key: const Key('buttonClientPortal'),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40)),
                onPressed: _onClientPortalPressed,
                child: const Text('Client Portal'),
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
