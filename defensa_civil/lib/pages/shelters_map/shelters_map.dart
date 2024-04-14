import 'package:defensa_civil/menu/drawer.dart';
import 'package:flutter/material.dart';
import 'shelters_map_body.dart';

class HostelsMap extends StatelessWidget {
  const HostelsMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Mapa de albergues"),
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
        ),
        drawer: const NavigationDrawerMenu(),
        body: AlbergueMap()
        );
  }
}
