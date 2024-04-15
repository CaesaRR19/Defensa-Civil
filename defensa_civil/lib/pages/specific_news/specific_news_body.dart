import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../login/auth_provider.dart';

class SpecificNewsBody extends StatefulWidget {
  @override
  _SpecificNewsBodyState createState() => _SpecificNewsBodyState();
}

class _SpecificNewsBodyState extends State<SpecificNewsBody> {
  List<dynamic> specificNews = [];

  @override
  void initState() {
    super.initState();
    getSpecificNews();
  }

  Future<void> getSpecificNews() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var uri =
    Uri.parse('https://adamix.net/defensa_civil/def/noticias_especificas.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields['token'] = authProvider.token!;
      var streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['exito'] == true) {
        specificNews = json.decode(response.body)['datos'];
     } 
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: specificNews.length,
        itemBuilder: (context, index) {
          final noticia = specificNews[index];
          return Card(
            elevation: 2.0,
            margin: EdgeInsets.all(8.0),
            child: ExpansionTile(
              title: ListTile(
                leading: Image.network(
                  noticia['foto'],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  noticia['titulo'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  noticia['fecha'],
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(noticia['contenido']),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}