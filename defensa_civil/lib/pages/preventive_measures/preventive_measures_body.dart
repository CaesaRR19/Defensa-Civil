import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PreventiveMeasuresBody extends StatefulWidget {
  const PreventiveMeasuresBody({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PreventiveMeasuresBodyState createState() => _PreventiveMeasuresBodyState();
}


class _PreventiveMeasuresBodyState extends State<PreventiveMeasuresBody> {
  late Future<List<Measure>> _measures;

  @override
  void initState() {
    super.initState();
    _measures = fetchMeasures();
  }
   

  Future<List<Measure>> fetchMeasures() async {
    final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/medidas_preventivas.php'));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['exito']) {
        return (jsonResponse['datos'] as List)
            .map((data) => Measure.fromJson(data))
            .toList();
      } else {
        throw Exception('Failed to load measures');
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medidas Preventivas'),
      ),
      body: FutureBuilder<List<Measure>>(
        future: _measures,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: snapshot.data![index].foto != null ? Image.network(snapshot.data![index].foto!) : null,
                  title: Text(snapshot.data![index].titulo),
                  subtitle: Text(snapshot.data![index].descripcion),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class Measure {
  final String id;
  final String titulo;
  final String descripcion;
  final String? foto;

  Measure({required this.id, required this.titulo, required this.descripcion, this.foto});

  factory Measure.fromJson(Map<String, dynamic> json) {
    return Measure(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      foto: json['foto'],
    );
  }
}