import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Hostel {
  final String ciudad;
  final String edificio;
  final String coordinador;
  final String telefono;
  final String capacidad;
  final double lat;
  final double lng;

  Hostel({
    required this.ciudad,
    required this.edificio,
    required this.coordinador,
    required this.telefono,
    required this.capacidad,
    required this.lat,
    required this.lng,
  });
}

class HostelsMapPage extends StatefulWidget {
  const HostelsMapPage({super.key});

  @override
  HostelsMapPageState createState() => HostelsMapPageState();
}

class HostelsMapPageState extends State<HostelsMapPage> {
  late GoogleMapController mapController;
  late List<Hostel> hostels = [];

  @override
  void initState() {
    super.initState();
    _fetchHostels();
  }

  Future<void> _fetchHostels() async {
    try {
      final response = await http.get(
        Uri.parse('https://adamix.net/defensa_civil/def/albergues.php'),
      );
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['exito']) {
        final hostelsData = jsonResponse['datos'];
        setState(() {
          hostels = _parseHostels(hostelsData);
        });
      } else {
        throw Exception('Failed to load hostels');
      }
    } catch (e) {
      AlertDialog(content: Text('Error fetching hostels: $e'));
    }
  }

  List<Hostel> _parseHostels(List<dynamic> hostelsData) {
    return hostelsData
        .map((hostelData) => Hostel(
              ciudad: hostelData['ciudad'],
              edificio: hostelData['edificio'],
              coordinador: hostelData['coordinador'],
              telefono: hostelData['telefono'],
              capacidad: hostelData['capacidad'],
              lat: double.parse(hostelData['lng']),
              lng: double.parse(hostelData['lat']),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hostels.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : hostels.isEmpty
              ? const Center(child: Text('No hay albergues.'))
              : Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(hostels[0].lat, hostels[0].lng),
                        zoom: 10,
                      ),
                      markers: Set<Marker>.from(hostels.map((hostel) => Marker(
                            markerId:
                                MarkerId('${hostel.ciudad}-${hostel.edificio}'),
                            position: LatLng(hostel.lat, hostel.lng),
                            onTap: () => _showHostelDetails(hostel),
                          ))),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: FloatingActionButton(
                        onPressed: _zoomIn,
                        child: const Icon(Icons.add),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 72,
                      child: FloatingActionButton(
                        onPressed: _zoomOut,
                        child: const Icon(Icons.remove),
                      ),
                    ),
                  ],
                ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _showHostelDetails(Hostel hostel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${hostel.ciudad} - ${hostel.edificio}'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Coordinador: ${hostel.coordinador}'),
            Text('Teléfono: ${hostel.telefono}'),
            Text('Capacidad: ${hostel.capacidad}'),
          ],
        ),
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
