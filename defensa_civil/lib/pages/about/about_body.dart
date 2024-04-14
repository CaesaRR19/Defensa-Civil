import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AboutBody extends StatelessWidget {
  final List<Map<String, String>> civilDefenseActions = [
    {
      "title": "Cristian Eulises Sánchez Ramirez ",
      "description": "2021-1899",
      "image": "assets/images/Cristian.jpeg"
    },
    {
      "title": "Valerie Lantigua De la Cruz",
      "description": "2021-1709",
      "image": "assets/images/Valerie.jpeg"
    },
    {
      "title": "Endrik Feliz Lora                           ",
      "description": "2022-0288",
      "image": "assets/images/Endrik.jpg"
    },
    {
      "title": "Loren Feliz                                 ",
      "description": "2022-0098",
      "image": "assets/images/Loren.jpeg"
    },
    {
      "title": "Cesar Omar Ramos Nolasco",
      "description": "2022-0022",
      "image": "assets/images/Cesar.png"
    }
  ];

  AboutBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuestro Equipo'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      ),
      body: CarouselSlider.builder(
        itemCount: civilDefenseActions.length,
        itemBuilder: (context, index, realIndex) {
          final item = civilDefenseActions[index];
          return Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(item['image']!),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.75),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: const Offset(0, 4), 
                ),
              ],
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5), 
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      item['title']!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
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
            ),
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          initialPage: 0,
        ),
      ),
    );
  }
}