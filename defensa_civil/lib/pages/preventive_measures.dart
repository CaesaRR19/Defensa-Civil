import 'package:defensa_civil/menu/drawer.dart';
import 'package:flutter/material.dart';

class PreventiveMeasures extends StatelessWidget {
  const PreventiveMeasures({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medidas Preventivas"),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      drawer: const NavigationDrawerMenu(),
    );
  }
}