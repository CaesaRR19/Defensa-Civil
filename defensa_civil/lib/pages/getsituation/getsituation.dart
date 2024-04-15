import 'package:defensa_civil/menu/drawer.dart';
import 'package:defensa_civil/pages/getsituation/getsituation_body.dart';
import 'package:flutter/material.dart';

class GSituation extends StatelessWidget {
  const GSituation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Mis situaciones"),
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
        ),
        drawer: const NavigationDrawerMenu(),
        //FAVOR AQUI PONER EL DESARROLLO DE TU WIDGET Y TU PARTE
        //AQUI IRÁ BE_VOLUNTEER_BODY
        body:const GetSituationBody() //LoginBody ,
        );
  }
}