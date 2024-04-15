import 'package:defensa_civil/menu/drawer.dart';
import 'package:defensa_civil/pages/videos/videos_body.dart';
import 'package:flutter/material.dart';

class Videos extends StatelessWidget {
  const Videos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Videos"),
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
        ),
        drawer: const NavigationDrawerMenu(),
        //FAVOR AQUI PONER EL DESARROLLO DE TU WIDGET Y TU PARTE
        //AQUI IRÁ VIDEOS_BODY
        body: VideosBody(),
        );
  }
}