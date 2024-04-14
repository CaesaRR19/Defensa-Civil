import 'package:defensa_civil/menu/drawer.dart';
import 'package:flutter/material.dart';

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
        //FAVOR AQUI PONER EL DESARROLLO DE TU WIDGET Y TU PARTE
        //AQUI IRÁ HOSTELS_MAP_BODY
        body: null //HostelsMapBody ,
        );
  }
}
