import 'package:defensa_civil/menu/drawer.dart';
import 'package:flutter/material.dart';

class HostelMap extends StatelessWidget {
  const HostelMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapa de Albergues"),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      drawer: const NavigationDrawerMenu(),
    );
  }
}