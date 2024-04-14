import 'package:defensa_civil/menu/drawer.dart';
import 'package:defensa_civil/pages/login/login_body.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Inicio de sesión"),
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
        ),
        drawer: const NavigationDrawerMenu(),
        //FAVOR AQUI PONER EL DESARROLLO DE TU WIDGET Y TU PARTE
        //AQUI IRÁ BE_VOLUNTEER_BODY
        body: const LoginBody() //LoginBody ,
        );
  }
}
