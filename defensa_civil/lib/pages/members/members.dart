import 'package:defensa_civil/menu/drawer.dart';
import 'package:defensa_civil/pages/members/members_body.dart';
import 'package:flutter/material.dart';

class Members extends StatelessWidget {
  const Members({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Miembros"),
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
        ),
        drawer: const NavigationDrawerMenu(),
        body: MembersBody(),
        );
  }
}
