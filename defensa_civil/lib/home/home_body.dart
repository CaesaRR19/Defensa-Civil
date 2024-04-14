import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeBody extends StatelessWidget {
  final List<Map<String, String>> civilDefenseActions = [
    {
      "title": "Bienvenido/a a la Defensa Civil",
      "description": "Cursos y talleres sobre cómo actuar en caso de desastres naturales.",
      "image": "assets/images/emergency_preparation.png"
    },
    {
      "title": "Respuesta a Inundaciones",
      "description": "Equipos especializados para responder rápidamente a inundaciones.",
      "image": "assets/images/flood_response.jpg"
    },
    {
      "title": "Recuperación y Apoyo",
      "description": "Asistencia en la recuperación post-desastre para comunidades afectadas.",
      "image": "assets/images/recovery_support.jpg"
    }
  ];

  HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarouselSlider.builder(
        itemCount: civilDefenseActions.length,
        itemBuilder: (context, index, realIndex) {
          final item = civilDefenseActions[index];
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(item['image']!),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    item['title']!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item['description']!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 1.0,
          height: MediaQuery.of(context).size.height,
          initialPage: 0,
        ),
      ),
    );
  }
}