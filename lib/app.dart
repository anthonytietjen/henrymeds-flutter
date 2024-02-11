import 'package:flutter/material.dart';
import 'package:henry_meds/screens/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF03836C)),
        useMaterial3: true,
      ),
      home: const Home(title: ''),
    );
  }
}
