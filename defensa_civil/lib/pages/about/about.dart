import 'package:defensa_civil/menu/drawer.dart';
import 'package:flutter/material.dart';
import 'package:defensa_civil/pages/about/about_body.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Acerca de"),
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
        ),
        drawer: const NavigationDrawerMenu(),
        //FAVOR AQUI PONER EL DESARROLLO DE TU WIDGET Y TU PARTE
        //AQUI IRÁ ABOUT_BODY
        body: AboutBody() //AboutBody ,
        );
  }
}
