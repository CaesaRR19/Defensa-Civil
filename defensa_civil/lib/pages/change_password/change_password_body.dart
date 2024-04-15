import 'dart:convert';
import 'package:defensa_civil/pages/login/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:defensa_civil/utils/security_utils.dart';
import 'package:provider/provider.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  ChangePasswordBodyState createState() => ChangePasswordBodyState();
}

class ChangePasswordBodyState extends State<ChangePasswordBody> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _changePassword() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var uri =
        Uri.parse('https://adamix.net/defensa_civil/def/cambiar_clave.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields['token'] = authProvider.token!;
    request.fields['clave_anterior'] =
        SecurityUtils().hashPassword(_oldPasswordController.text);
    request.fields['clave_nueva'] =
        SecurityUtils().hashPassword(_newPasswordController.text);
    try {
      var streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['exito'] == true) {
          _showDialog('Éxito', 'Contraseña cambiada correctamente');
        } else {
          _showDialog('Error',
              'El cambio de contraseña falló: ${responseData['mensaje']}');
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
            // clave_anterior's TextFormField
            TextFormField(
              controller: _oldPasswordController,
              decoration: InputDecoration(
                  labelText: 'Ingrese su contraseña actual',
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
            const SizedBox(height: 10),
            TextFormField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                  labelText: 'Ingrese la nueva contraseña',
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
                    _changePassword();
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.blue.shade700),
                    foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.white)),
                child: const Text('Cambiar Contraseña')),
          ],
        ),
      ),
    )));
  }
}
