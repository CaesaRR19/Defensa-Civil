import 'package:defensa_civil/menu/drawer.dart';
import 'package:flutter/material.dart';

class Hostels extends StatelessWidget {
  const Hostels({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Albergues"),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      drawer: const NavigationDrawerMenu(),
    );
  }
}