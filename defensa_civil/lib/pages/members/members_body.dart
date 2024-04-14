import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Member {
  final String id;
  final String photoUrl;
  final String name;
  final String position;

  Member({required this.id, required this.photoUrl, required this.name, required this.position});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      photoUrl: json['foto'],
      name: json['nombre'],
      position: json['cargo'],
    );
  }
}

class MembersBody extends StatefulWidget {
  @override
  _MembersBodyState createState() => _MembersBodyState();
}

class _MembersBodyState extends State<MembersBody> {
  late Future<List<Member>> _futureMembers;

  @override
  void initState() {
    super.initState();
    _futureMembers = fetchMembers(); // Inicia la carga de los miembros al iniciar la pantalla
  }

  Future<List<Member>> fetchMembers() async {
    final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/miembros.php')); // Obtiene los datos de la API
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['datos']; // Decodifica la respuesta JSON
      return data.map((json) => Member.fromJson(json)).toList(); // Mapea los datos JSON a objetos Member
    } else {
      throw Exception('Failed to load members');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Member>>(
      future: _futureMembers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Muestra un indicador de carga mientras se obtienen los datos
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Muestra un mensaje de error si falla la carga
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return MemberCard(member: snapshot.data![index]); // Crea una tarjeta para cada miembro en la lista
            },
          );
        }
      },
    );
  }
}

class MemberCard extends StatelessWidget {
  final Member member;

  MemberCard({required this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image.network(
            member.photoUrl,
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ), // Muestra la foto del miembro desde la URL proporcionada
          SizedBox(height: 12),
          Text(
            member.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ), // Muestra el nombre del miembro
          Text(
            member.position,
            style: TextStyle(fontSize: 16),
          ), // Muestra el cargo del miembro
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
