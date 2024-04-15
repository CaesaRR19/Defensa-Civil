import 'package:defensa_civil/menu/drawer.dart';
import 'package:defensa_civil/pages/change_password/change_password_body.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cambiar contraseña"),
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
        ),
        drawer: const NavigationDrawerMenu(),
        //FAVOR AQUI PONER EL DESARROLLO DE TU WIDGET Y TU PARTE
        //AQUI IRÁ LoginBody
        body: const ChangePasswordBody() //LoginBody ,
        );
  }
}
