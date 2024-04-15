import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:defensa_civil/pages/login/auth_provider.dart';

class FormSituationBody extends StatefulWidget {
  const FormSituationBody({super.key});

  @override
  FormSituationBodyState createState() => FormSituationBodyState();
}

class FormSituationBodyState extends State<FormSituationBody> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _base64Image = "";

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _base64Image = base64Encode(bytes);
      });
    }
  }

  Future<void> _reportSituation() async {

    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var uri = Uri.parse('https://adamix.net/defensa_civil/def/nueva_situacion.php');
    var request = http.MultipartRequest('POST', uri);
    if (authProvider.isAuthenticated) {
    request.fields['titulo'] = _titleController.text.trim();
    request.fields['descripcion'] = _descriptionController.text.trim();
    request.fields['foto'] = _base64Image;
    request.fields['latitud'] = _latitudeController.text.trim();
    request.fields['longitud'] = _longitudeController.text.trim();
    request.fields['token'] = authProvider.token!;
    print(authProvider.token!);
      } else {
        _showErrorDialog('No se pudo enviar el reporte: No se ha iniciado sesión');
        return;

      }
    try {
      var streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Reporte Enviado'),
              content: const Text('Su reporte ha sido enviado con éxito.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        _showErrorDialog('Error al enviar reporte: Código de estado ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog('Ocurrió un error al enviar el reporte: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _titleController,
                  decoration:  InputDecoration(
                    labelText: 'Título del evento',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[100]
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese un título para el evento';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  decoration:  InputDecoration(
                    labelText: 'Descripción completa',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[100]
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese una descripción del evento';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _latitudeController,
                        decoration:  InputDecoration(
                          labelText: 'Latitud',
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[100]
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese la latitud';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _longitudeController,
                        decoration:  InputDecoration(
                          labelText: 'Longitud',
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[100]
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese la longitud';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Seleccionar Foto'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _reportSituation();
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.blue.shade700),
                      foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white)),
                  child: const Text('Reportar Situación'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}