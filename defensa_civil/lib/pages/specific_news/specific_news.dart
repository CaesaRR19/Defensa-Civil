import 'package:defensa_civil/menu/drawer.dart';
import 'package:flutter/material.dart';

import 'Specific_news_body.dart';

class SpecificNews extends StatelessWidget {
  const SpecificNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Noticias"),
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
        ),
        drawer: const NavigationDrawerMenu(),
        //FAVOR AQUI PONER EL DESARROLLO DE TU WIDGET Y TU PARTE
        //AQUI IRÁ NEWS_BODY
        body: SpecificNewsBody()
        );
  }
}
