import 'package:defensa_civil/menu/drawer.dart';
import 'package:defensa_civil/pages/be_volunteer/be_volunteer_body.dart';
import 'package:flutter/material.dart';

class BeVolunteer extends StatelessWidget {
  const BeVolunteer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Quiero ser voluntario"),
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
        ),
        drawer: const NavigationDrawerMenu(),
        //FAVOR AQUI PONER EL DESARROLLO DE TU WIDGET Y TU PARTE
        //AQUI IRÁ BE_VOLUNTEER_BODY
        body: const BeVolunteerBody() //BeVolunteerBody ,
        );
  }
}
