import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsBody extends StatefulWidget {
  @override
  _NewsBodyState createState() => _NewsBodyState();
}

class _NewsBodyState extends State<NewsBody> {
  List<dynamic> noticias = [];

  @override
  void initState() {
    super.initState();
    obtenerNoticias();
  }

  Future<void> obtenerNoticias() async {
    final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/noticias.php'));

    if (response.statusCode == 200) {
      setState(() {
        noticias = json.decode(response.body)['datos'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: noticias.length,
        itemBuilder: (context, index) {
          final noticia = noticias[index];
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
