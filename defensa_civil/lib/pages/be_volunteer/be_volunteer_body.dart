import 'dart:convert';
import 'package:defensa_civil/utils/security_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class BeVolunteerBody extends StatefulWidget {
  const BeVolunteerBody({super.key});

  @override
  BeVolunteerBodyState createState() => BeVolunteerBodyState();
}

class BeVolunteerBodyState extends State<BeVolunteerBody> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _addVolunteer() async {
    var uri = Uri.parse('https://adamix.net/defensa_civil/def/registro.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields['cedula'] = _idController.text;
    request.fields['nombre'] = _nameController.text;
    request.fields['apellido'] = _surnameController.text;
    request.fields['clave'] =
        SecurityUtils().hashPassword(_passwordController.text);
    request.fields['correo'] = _emailController.text;
    request.fields['telefono'] = _phoneNumberController.text;

    try {
      var streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['exito'] == true) {
          _showDialog('Éxito', 'El registro fue exitoso.');
        } else {
          _showDialog('Error', 'El registro falló: ${responseData['mensaje']}');
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // cedula's TextFormField
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
                ],
              ),
              const SizedBox(height: 10),
              // nombre's TextFormField
              TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: 'Ingrese su nombre',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[100]),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese su nombre';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]+')),
                  ]),
              const SizedBox(height: 10),
              // apellido's TextFormField
              TextFormField(
                  controller: _surnameController,
                  decoration: InputDecoration(
                      labelText: 'Ingrese sus apellidos',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[100]),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese sus apellidos';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]+')),
                  ]),
              const SizedBox(height: 10),
              // telefono's TextFormField
              TextFormField(
                  maxLength: 12,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                      labelText: 'Ingrese su número telefónico',
                      hintText: "XXX-XXX-XXXX",
                      counterText: "",
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[100]),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese su número telefónico';
                    }
                    if (!RegExp(r'^\d{3}-\d{3}-\d{4}$').hasMatch(value)) {
                      return 'Por favor, ingrese su número telefónico en un formato válido. Ejemplo: XXX-XXX-XXXX';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d{0,3}-?\d{0,3}-?\d{0,4}$')),
                  ]),
              const SizedBox(height: 10),
              // correo's TextFormField
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: 'Ingrese su correo electrónico',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[100]),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su correo electrónico';
                  }
                  if (!RegExp(
                          r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')
                      .hasMatch(value)) {
                    return 'Por favor, ingrese un correo válido';
                  }
                  return null;
                },
              ),
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
                      _addVolunteer();
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.blue.shade700),
                      foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white)),
                  child: const Text('¡Registrate!')),
            ],
          ),
        ),
      ),
    );
  }
}
