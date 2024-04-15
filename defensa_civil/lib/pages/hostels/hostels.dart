import 'package:defensa_civil/menu/drawer.dart';
import 'package:flutter/material.dart';

class HostelsTem extends StatelessWidget {
  const HostelsTem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Albergues"),
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
        ),
        drawer: const NavigationDrawerMenu(),
        //FAVOR AQUI PONER EL DESARROLLO DE TU WIDGET Y TU PARTE
        //AQUI IRÁ HOSTELS_BODY
        body: null //HostelsBody ,
        );
  }
}
