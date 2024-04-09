import 'package:defensa_civil/menu/drawer.dart';
import 'package:flutter/material.dart';

class BeVolunteer extends StatelessWidget {
  const BeVolunteer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiero ser Voluntario"),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      drawer: const NavigationDrawerMenu(),
    );
  }
}