import 'package:defensa_civil/menu/drawer.dart';
import 'package:flutter/material.dart';

class PreventiveMeasures extends StatelessWidget {
  const PreventiveMeasures({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Medidas preventivas"),
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
        ),
        drawer: const NavigationDrawerMenu(),
        //FAVOR AQUI PONER EL DESARROLLO DE TU WIDGET Y TU PARTE
        //AQUI IRÁ PREVENTIVE_MEASURES_BODY
        body: null //PreventiveMeasuresBody ,
        );
  }
}
