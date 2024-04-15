import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:defensa_civil/pages/login/auth_provider.dart';
import 'package:defensa_civil/pages/getsituation/datasituations.dart';

class GetSituationBody extends StatefulWidget {
  const GetSituationBody({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GetSituationBodyState createState() => _GetSituationBodyState();
}

class _GetSituationBodyState extends State<GetSituationBody> {
  Future<List<Situation>> _fetchSituations() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final uri = Uri.parse('https://adamix.net/defensa_civil/def/situaciones.php');
    var request = http.MultipartRequest('POST', uri)
      ..fields['token'] = auth.token ?? '';  // Asumiendo que la API requiere el token en los campos del formdata

    var streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      var response = await http.Response.fromStream(streamedResponse);
      var jsonData = json.decode(response.body);

      if (jsonData['exito'] == true && jsonData.containsKey('datos')) {
        List<dynamic> situationsJson = jsonData['datos'];
        return situationsJson.map((json) => Situation.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load situations or no data available');
      }
    } else {
      throw Exception('Failed to load situations with status code: ${streamedResponse.statusCode}');
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Situaciones'),
      ),
      body: FutureBuilder<List<Situation>>(
        future: _fetchSituations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                var situation = snapshot.data![index];
                var bytes = base64Decode(situation.photo);
                return ListTile(
                  leading: Image.memory(bytes, width: 100, height: 100, fit: BoxFit.cover),
                  title: Text(situation.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ID: ${situation.id}"),
                      Text("Fecha: ${situation.date}"),
                      Text("Estado: ${situation.status}"),
                      Text("Descripción: ${situation.description}"),
                    ],
                  ),
                  isThreeLine: true,
                  onTap: () {
                    // Aquí podrías abrir una nueva pantalla con los detalles
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}