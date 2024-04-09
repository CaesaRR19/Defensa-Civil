import 'package:defensa_civil/menu/drawer.dart';
import 'package:flutter/material.dart';

class Videos extends StatelessWidget {
  const Videos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Videos"),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      drawer: const NavigationDrawerMenu(),
    );
  }
}