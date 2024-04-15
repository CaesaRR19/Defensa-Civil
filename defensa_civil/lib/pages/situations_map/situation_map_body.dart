import 'package:defensa_civil/menu/drawer.dart';
import 'package:defensa_civil/pages/login/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Situation {
  final String title;
  final String description;
  final double lat;
  final double lng;

  Situation({
    required this.title,
    required this.description,
    required this.lat,
    required this.lng,
  });
}

class SituationsMap extends StatefulWidget {
  const SituationsMap({Key? key}) : super(key: key);

  @override
  SituationsMapState createState() => SituationsMapState();
}

class SituationsMapState extends State<SituationsMap> {
  late GoogleMapController mapController;
  late List<Situation> situations = [];

  @override
  void initState() {
    super.initState();
    _fetchSituations();
  }

  Future<void> _fetchSituations() async {
    try {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      final response = await http.post(
        Uri.parse('https://adamix.net/defensa_civil/def/situaciones.php'),
        body: {'token': auth.token ?? ''},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['exito'] == true) {
          final List<dynamic> situationsData = jsonData['datos'];
          setState(() {
            situations = situationsData.map((data) => Situation(
              title: data['titulo'],
              description: data['descripcion'],
              lat: double.parse(data['latitud']),
              lng: double.parse(data['longitud']),
            )).toList();
          });
        } else {
          throw Exception('Failed to load situations: ${jsonData['mensaje']}');
        }
      } else {
        throw Exception('Failed to load situations');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Error fetching situations: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Mis Situaciones', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      drawer: NavigationDrawerMenu(),
      body: situations.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(situations[0].lat, situations[0].lng),
                zoom: 10,
              ),
              markers: Set<Marker>.from(situations.map((situation) => Marker(
                    markerId: MarkerId(situation.title),
                    position: LatLng(situation.lat, situation.lng),
                    onTap: () => _showSituationDetails(situation),
                  ))),
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _zoomIn,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _zoomOut,
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _showSituationDetails(Situation situation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(situation.title),
        content: Text(situation.description),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _zoomIn() {
    mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    mapController.animateCamera(CameraUpdate.zoomOut());
  }
}
