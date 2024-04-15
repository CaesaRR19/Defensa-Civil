import 'package:defensa_civil/menu/drawer.dart';
import 'package:flutter/material.dart';
import 'package:defensa_civil/pages/addsituation/formsituation_body.dart';

class Fsituation extends StatelessWidget {
  const Fsituation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Reportar Situación"),
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
        ),
        drawer: const NavigationDrawerMenu(),
        //FAVOR AQUI PONER EL DESARROLLO DE TU WIDGET Y TU PARTE
        //AQUI IRÁ ABOUT_BODY
        body: FormSituationBody()//AboutBody ,
        );
  }
}
