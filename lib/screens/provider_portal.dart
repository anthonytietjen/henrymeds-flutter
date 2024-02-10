import 'package:flutter/material.dart';

class ProviderPortal extends StatefulWidget {
  const ProviderPortal({super.key});

  @override
  State<ProviderPortal> createState() => _HomeState();
}

class _HomeState extends State<ProviderPortal> {
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
                  top: 10, left: 16, right: 16, bottom: 10),
              child: Text(
                'My Availability',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 40,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: const Icon(Icons.chevron_right),
                    title: const Text("Hello World"),
                    onTap: () => {},
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 40, left: 16, right: 16),
              child: ElevatedButton(
                onPressed: _onAddAvailabilityPressed,
                key: const Key('buttonAddAvailability'),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40)),
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
