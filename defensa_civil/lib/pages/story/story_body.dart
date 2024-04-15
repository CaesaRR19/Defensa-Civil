import 'package:flutter/material.dart';

class StoryBody extends StatelessWidget {
  final List<Map<String, dynamic>> civilDefenseMilestones = [
    {
      "year": "1950",
      "event": "Creación de la Defensa Civil",
      "details": "La Defensa Civil fue establecida para coordinar respuestas a emergencias y desastres naturales."
    },
    {
      "year": "1965",
      "event": "Implementación del primer plan nacional",
      "details": "Se implementó el primer plan nacional de respuesta a emergencias para mejorar la eficiencia."
    },
    {
      "year": "1980",
      "event": "Ampliación de capacidades",
      "details": "La Defensa Civil expandió sus capacidades incluyendo equipos más avanzados y entrenamiento especializado."
    },
    {
      "year": "1990",
      "event": "Introducción de tecnología moderna",
      "details": "Incorporación de tecnologías modernas para mejorar la comunicación y la eficiencia en las respuestas."
    },
    {
      "year": "2000",
      "event": "Iniciativas internacionales",
      "details": "La Defensa Civil comenzó a participar en misiones internacionales de ayuda en desastres."
    },
    {
      "year": "2010",
      "event": "Mejora en la formación y preparación",
      "details": "Se mejoraron los programas de formación y preparación para enfrentar emergencias más complejas."
    },
    {
      "year": "2020",
      "event": "Respuesta a la pandemia",
      "details": "Jugó un papel crucial en la coordinación de la respuesta nacional a la pandemia de COVID-19."
    }
  ];

  StoryBody({Key? key}) : super(key: key);

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuestra Historia - Defensa Civil"),
      ),
      body: ListView.builder(
        itemCount: civilDefenseMilestones.length,
        itemBuilder: (context, index) {
          final milestone = civilDefenseMilestones[index];
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 5,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              title: Text(
                milestone['event'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                milestone['details'],
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(milestone['year'], style: const TextStyle(color: Colors.white)),
              ),
              tileColor: index % 2 == 0 ? Colors.blue[50] : Colors.grey[100],
            ),
          );
        },
      ),
    );
  }
}