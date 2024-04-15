import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HostelsBody extends StatefulWidget {
  const HostelsBody({Key? key}) : super(key: key);

  @override
  HostelsBodyState createState() => HostelsBodyState();
}

class HostelsBodyState extends State<HostelsBody> {
  late Future<List<dynamic>> _hostelsData;
  late List<dynamic> _allHostels = [];
  late List<dynamic> _filteredHostels = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _hostelsData = _fetchHostelsData();
    _hostelsData.then((data) {
      setState(() {
        _allHostels = data;
        _filteredHostels = _allHostels;
      });
    });
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _filterHostels(_searchController.text);
  }

  Future<List<dynamic>> _fetchHostelsData() async {
    final response = await http
        .get(Uri.parse('https://adamix.net/defensa_civil/def/albergues.php'));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['datos'] != null && jsonResponse['datos'] is List) {
        return jsonResponse['datos'];
      } else {
        throw Exception('Datos no encontrados o el formato no es el esperado');
      }
    } else {
      throw Exception('Failed to load hostels');
    }
  }

  void _filterHostels(String query) {
    setState(() {
      _filteredHostels = _allHostels.where((hostel) {
        String hostelName = hostel['edificio'].toLowerCase();
        return hostelName.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albergues Disponibles'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar albergue',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _hostelsData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return _buildHostelsList();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHostelsList() {
    if (_filteredHostels.isNotEmpty) {
      return ListView.builder(
        itemCount: _filteredHostels.length,
        itemBuilder: (context, index) {
          final hostel = _filteredHostels[index];
          return ListTile(
            title: Text(hostel['edificio']),
            subtitle: Text(hostel['ciudad']),
            onTap: () {
              _showHostelDetails(context, hostel);
            },
          );
        },
      );
    } else {
      return const Center(
        child: Text('No se encontraron resultados'),
      );
    }
  }

  void _showHostelDetails(BuildContext context, dynamic hostel) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(hostel['edificio']),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Ciudad: ${hostel['ciudad']}'),
              Text('Coordinador: ${hostel['coordinador']}'),
              Text('Teléfono: ${hostel['telefono']}'),
              if (hostel['capacidad'] != "")
                Text('Capacidad: ${hostel['capacidad']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
