import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  int? _userId;
  String? _nombre;
  String? _apellido;
  String? _correo;
  String? _telefono;

  String? get token => _token;
  int? get userId => _userId;
  String? get nombre => _nombre;
  String? get apellido => _apellido;
  String? get correo => _correo;
  String? get telefono => _telefono;

  void login({
    required String token,
    required int userId,
    required String nombre,
    required String apellido,
    required String correo,
    required String telefono,
  }) {
    _token = token;
    _userId = userId;
    _nombre = nombre;
    _apellido = apellido;
    _correo = correo;
    _telefono = telefono;
    notifyListeners();
  }

  void logout() {
    _token = null;
    _userId = null;
    _nombre = null;
    _apellido = null;
    _correo = null;
    _telefono = null;
    notifyListeners();
  }

  // You can use this method to know if a person is logged in. 
  bool get isAuthenticated => _token != null;
}
