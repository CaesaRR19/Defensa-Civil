import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServicesBody extends StatefulWidget {
  @override
  _ServicesBodyState createState() => _ServicesBodyState();
}

class _ServicesBodyState extends State<ServicesBody> {
  List<dynamic> services = [];
  bool isLoading = true;

  Future<void> fetchServices() async {
    try {
      final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/servicios.php'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['exito'] == true) {
          setState(() {
            services = jsonData['datos'];
            isLoading = false;
          });
        } else {
          throw Exception('Error en la respuesta de la API: ${jsonData["mensaje"]}');
        }
      } else {
        throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
      }
    } catch (error) {
      print('Error al cargar los servicios: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : services.isEmpty
            ? Center(
                child: Text('No se encontraron servicios'),
              )
            : ListView.builder(
                itemCount: services.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 250, // Ajustamos el tamaño del contenedor para la imagen
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: index == 0
                                ? AssetImage('assets/images/imagen1_services.jpg') as ImageProvider<Object> // Convertimos explícitamente a ImageProvider<Object>
                                : NetworkImage(services[index]['foto']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 16), // Aumentamos el espacio entre la imagen y el texto
                        Text(
                          services[index]['nombre'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: double.infinity, // Ajustamos el ancho del contenedor al ancho de la pantalla
                          child: Text(
                            services[index]['descripcion'],
                            maxLines: 5, // Mostramos un máximo de 5 líneas
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
  }
}
