import 'dart:convert';
import 'package:defensa_civil/pages/login/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:defensa_civil/utils/security_utils.dart';
import 'package:provider/provider.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  LoginBodyState createState() => LoginBodyState();
}

class LoginBodyState extends State<LoginBody> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    var uri =
        Uri.parse('https://adamix.net/defensa_civil/def/iniciar_sesion.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields['cedula'] = _idController.text;
    request.fields['clave'] =
        SecurityUtils().hashPassword(_passwordController.text);
    try {
      var streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['exito'] == true) {
          _showDialog('Éxito', 'Sesión iniciada.');
          // ignore: use_build_context_synchronously
          Provider.of<AuthProvider>(context, listen: false).login(
              token: responseData['datos']['token'],
              userId: int.parse(responseData['datos']['id']),
              nombre: responseData['datos']['nombre'],
              apellido: responseData['datos']['apellido'],
              correo: responseData['datos']['correo'],
              telefono: responseData['datos']['telefono']);
        } else {
          _showDialog(
              'Error', 'El inicio de sesión falló: ${responseData['mensaje']}');
        }
      } else {
        _showDialog('Error',
            'Error de conexión: Código de estado ${response.statusCode}');
      }
    } catch (e) {
      _showDialog('Error', 'Ocurrió un error: $e');
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
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
                maxLength: 13,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                controller: _idController,
                decoration: InputDecoration(
                    labelText: 'Ingrese su cédula',
                    hintText: "XXX-XXXXXXX-X",
                    counterText: "",
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[100]),
                keyboardType:
                    const TextInputType.numberWithOptions(signed: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su cédula';
                  }
                  if (!RegExp(r'^\d{3}-\d{7}-\d{1}$').hasMatch(value)) {
                    return 'Por favor, ingrese su cédula en un formato válido. Ejemplo: XXX-XXXXXXX-X';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d{0,3}-?\d{0,7}-?\d{0,1}$')),
                ]),
            const SizedBox(height: 10),
            // clave's TextFormField
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                  labelText: 'Ingrese su contraseña',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[100]),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 8) {
                  return 'La contraseña contener 8 caracteres como minimo';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _login();
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.blue.shade700),
                    foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.white)),
                child: const Text('¡Inicia Sesión!')),
          ],
        ),
      ),
    )));
  }
}
