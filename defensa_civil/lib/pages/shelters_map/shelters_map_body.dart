import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'shelters.dart';

class AlbergueMap extends StatefulWidget {
  @override
  _AlbergueMapState createState() => _AlbergueMapState();
}

class _AlbergueMapState extends State<AlbergueMap> {
  List<Shelter> shelters = [];
  Marker? userMarker;
  bool isLoading = true;
  late MapController mapController;
  Position? position;
  bool colorwhite = false;

  @override
  void initState() {
    super.initState();
    fetchAlbergues();
    _initializeUserMarker();
    mapController = MapController();
  }

  void colors (int num){
    if (num % 2 == 0){
        colorwhite = false;
    }else{
      colorwhite = true;
    }
  }

  /// Determine the current position of the device.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void _initializeUserMarker() async {
    isLoading = true;
    try {
      position = await _determinePosition();
      setState(() {
        userMarker = Marker(
          width: 80.0,
          height: 80.0,
          point: position != null
              ? LatLng(position?.latitude ?? 0, position?.longitude ?? 0)
              : LatLng(0, 0),
          child: IconButton(
            icon: const Icon(Icons.location_history),
            color: Colors.blue,
            onPressed: () {},
          ),
        );
        isLoading = false;
      });
    } catch (e) {
      print('Error obteniendo la ubicación: $e');
      isLoading = false;
    }
  }

  Future<void> fetchAlbergues() async {
    final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/albergues.php'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> data = jsonData['datos'];
      List<Shelter> tempShelters = [];
      for (var item in data) {
        Shelter shelter = Shelter(
          ciudad: item['ciudad'],
          codigo: item['codigo'],
          edificio: item['edificio'],
          coordinador: item['coordinador'],
          telefono: item['telefono'],
          capacidad: item['capacidad'],
          latitude: double.parse(item['lat']),
          longitude: double.parse(item['lng']),
        );
        tempShelters.add(shelter);
      }
      setState(() {
        shelters = tempShelters;
      });
    } else {
      throw Exception('Failed to load albergues');
    }
  }

  void _zoomAndCenter(double latitude, double longitude) {
    try {
      mapController.move(LatLng(latitude, longitude), 20.0); // Zoom al nivel 15
    } catch (e) {
      print('Error obteniendo la ubicación: $e');
    }
  }
// Función para calcular la distancia entre dos puntos (latitud y longitud)
double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371; // Radio de la tierra en kilómetros
  var dLat = _degreesToRadians(lon2 - lat1);
  var dLon = _degreesToRadians(lat2 - lon1);
  var a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) *
          sin(dLon / 2) * sin(dLon / 2);
  var c = 2 * atan2(sqrt(a), sqrt(1 - a));
  var distance = R * c; // Distancia en kilómetros
  return distance;
}

double _degreesToRadians(degrees) {
  return degrees * pi / 180;
}

// Función para ordenar los refugios por distancia
void sortSheltersByDistance(List<Shelter> shelters, double userLat, double userLon) {
  shelters.sort((a, b) {
    var distanceToA = calculateDistance(userLat, userLon, a.latitude, a.longitude);
    var distanceToB = calculateDistance(userLat, userLon, b.latitude, b.longitude);
    return distanceToA.compareTo(distanceToB);
  });
}


  void _showShelterDetails(BuildContext context, Shelter shelter) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(shelter.edificio),
        content: RichText(
          text: TextSpan(
            text: '',
            style: TextStyle(color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: '${shelter.ciudad}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    '\n Codigo: ${shelter.codigo} \n coordinador: ${shelter.coordinador} \n telefono: ${shelter.telefono} \n capacidad: ${shelter.capacidad} \n',
              ),
            ],
          ),
        ),
      ),
    );
    _zoomAndCenter(shelter.longitude, shelter.latitude);
  }

  @override
  Widget build(BuildContext context) {
    final LatLng RDPosition = LatLng(18.735693, -70.162651);
    return Scaffold(
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator(), // Muestra el CircularProgressIndicator mientras se cargan los marcadores
            )
          : Column(
              children: [
                Flexible(
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      initialCenter: RDPosition,
                      center: RDPosition,
                      zoom: 7.1,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      ),
                      MarkerLayer(
                        markers: [
                          ...shelters.map((shelter) {
                            return Marker(
                              width: 80.0,
                              height: 80.0,
                              point: LatLng(shelter.longitude, shelter.latitude),
                              child: IconButton(
                                icon: const Icon(Icons.location_pin),
                                color: Colors.red,
                                onPressed: () {
                                  _showShelterDetails(context, shelter);
                                },
                              ),
                            );
                          }).toList(),
                          userMarker!,
                        ],
                      ),
                    ],
                  ),
                ),Expanded(
                    child: ListView.builder(
                      itemCount: shelters.length,
                      itemBuilder: (context, index) {
                        // Antes de construir cada ListTile, ordena los refugios por distancia de menor a mayor
      shelters.sort((a, b) {
        double distanceToA = calculateDistance(
          position?.latitude ?? 0,
          position?.longitude ?? 0,
          a.latitude,
          a.longitude,
        );
        double distanceToB = calculateDistance(
          position?.latitude ?? 0,
          position?.longitude ?? 0,
          b.latitude,
          b.longitude,
        );
        return distanceToA.compareTo(distanceToB);
      });
      
                        // Antes de construir cada ListTile, obtén el refugio actual
                        final shelter = shelters[index];
                        colors(index);
                        
                        // Llama a la función para calcular la distancia entre el usuario y el refugio actual
                        double distanceToShelter = calculateDistance(
                          position?.latitude ?? 0,
                          position?.longitude ?? 0,
                          shelter.latitude,
                          shelter.longitude,
                        );
                        
                        // Ahora, en lugar de simplemente construir un ListTile, puedes construir un ListTile personalizado
                        return Container(
                          color: colorwhite ? Color.fromARGB(255, 241, 233, 233) : Color.fromARGB(255, 236, 218, 238),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(shelter.edificio),
                                Text('Distancia: ${distanceToShelter.toStringAsFixed(2)} km'), // Muestra la distancia en kilómetros
                              ],
                            ),
                            onTap: () {
                              _showShelterDetails(context, shelter);
                            },
                          ),
                        );
                      },
                    ),
                  ),

              ],
            ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight, // Posicionar el botón en la esquina inferior derecha
        child: FloatingActionButton(
          onPressed: () => _zoomAndCenter(position?.latitude ?? 0, position?.longitude?? 0),
          tooltip: 'Zoom y centrar en la posición del usuario.',
          child: Icon(Icons.location_searching),
          backgroundColor: Color.fromARGB(255, 236, 218, 238),
        ),
      ),
    );
  }
}
