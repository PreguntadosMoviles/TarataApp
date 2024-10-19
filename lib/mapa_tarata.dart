import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapaTarata extends StatefulWidget {
  @override
  _MapaTarataState createState() => _MapaTarataState();
}

class _MapaTarataState extends State<MapaTarata> {
  late GoogleMapController _mapController;
  LatLng _initialPosition = LatLng(-18.006680899903547, -70.22713187454809); // Coordenadas específicas
  Marker? _marker;
  IconData _iconoCentral = Icons.home;
  String _temperatura = 'Cargando...';
  String _hora = 'Cargando...';
  Set<Polyline> _polylines = {}; // Para almacenar las polilíneas

  @override
  void initState() {
    super.initState();
    _setMarkerAndWeather(_initialPosition); // Establecer marcador y clima al iniciar
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _hora = TimeOfDay.now().format(context);
      });
    });
  }

  void _setMarkerAndWeather(LatLng location) {
    _marker = Marker(
      markerId: MarkerId('specifiedLocation'),
      position: location,
      infoWindow: InfoWindow(title: 'Ubicación Especificada'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    _getWeather(location); // Obtener temperatura en la ubicación especificada
  }

  Future<void> _getWeather(LatLng location) async {
    final apiKey = '8d3426d47c0a287369de2ad44d01a886'; // Reemplaza con tu API Key
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _temperatura = '${data['main']['temp']}ºC';
        });
      } else {
        setState(() {
          _temperatura = 'Error';
        });
      }
    } catch (e) {
      setState(() {
        _temperatura = 'Error';
      });
    }
  }

  void _updateMarker(String label, LatLng location, IconData icon) {
    setState(() {
      _marker = Marker(
        markerId: MarkerId(label),
        position: location,
        infoWindow: InfoWindow(title: label),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );

      // Mueve la cámara hacia la nueva posición del marcador
      _mapController.animateCamera(CameraUpdate.newLatLng(location));

      // Actualiza el ícono central al ícono del botón seleccionado
      _iconoCentral = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                color: Color(0xFF373737),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'RUTA DE ACCESO',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'TARATA',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFADFAE),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Color(0xFF868973),
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        _temperatura,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Color(0xFF636560),
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        _hora,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 14.0,
                    ),
                    onMapCreated: (controller) {
                      _mapController = controller;
                      setState(() {
                        _mapController.animateCamera(CameraUpdate.newLatLng(_initialPosition));
                      });
                    },
                    markers: _marker != null ? {_marker!} : {},
                    polylines: _polylines, // Agregar polilíneas al mapa
                  ),
                ),
              ),
              Container(
                color: Color(0xFF373737),
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                height: MediaQuery.of(context).size.height * 0.25,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.8,
                  children: [
                    _buildLocationButton('Plaza', LatLng(-17.474622343888903, -70.03224877351491), Icons.location_city),
                    _buildLocationButton('Mercado', LatLng(-17.475491685082943, -70.0313025044189), Icons.shopping_cart),
                    _buildLocationButton('Iglesia Tarucachi', LatLng(-17.522411446211972, -70.02899311937927), Icons.church),
                    _buildLocationButton('Municipalidad Provincial', LatLng(-17.447941219604804, -70.03147924152483), Icons.apartment),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 150,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(5),
              child: Icon(
                _iconoCentral,
                size: 50,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationButton(String label, LatLng location, IconData icon) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: EdgeInsets.all(10),
      ),
      onPressed: () {
        _updateMarker(label, location, icon);
        _showRoute(location); // Muestra la ruta al destino seleccionado
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showRoute(LatLng destination) async {
    final googlePoints = PolylinePoints();
    List<LatLng> polylineCoordinates = [];

    // Reemplaza con tu API Key de Google
    String googleApiKey = 'AIzaSyDYMS4cdyIBc8Y9bzrNNM8G8UI69rzS04U';

    // Construir la URL para la Directions API
    String url = 'https://maps.googleapis.com/maps/api/directions/json?origin=${_initialPosition.latitude},${_initialPosition.longitude}&destination=${destination.latitude},${destination.longitude}&key=$googleApiKey';
    print(url); // Imprimir la URL para verificación

    // Realizar la solicitud a la Directions API
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['status'] == 'OK') {
        // Obtener las coordenadas de la ruta
        for (var step in data['routes'][0]['legs'][0]['steps']) {
          // Obtener los puntos de la ruta utilizando "polyline"
          var polyline = step['polyline']['points'];
          polylineCoordinates.addAll(_convertToLatLng(polyline));
        }

        // Limpiar las polilíneas antes de agregar la nueva
        _polylines.clear();

        // Crear la nueva polilínea
        Polyline polyline = Polyline(
          polylineId: PolylineId('route'),
          color: Colors.blue,
          points: polylineCoordinates,
          width: 5,
        );

        // Agregar la polilínea al conjunto
        _polylines.add(polyline);

        // Actualizar el estado para reflejar los cambios
        setState(() {});
      }
    }
  }

  List<LatLng> _convertToLatLng(String encoded) {
    List<LatLng> coordinates = [];
    List<int> offsets = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat = (result >> 1) ^ -(result & 1);
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlng = (result >> 1) ^ -(result & 1);
      lng += dlng;

      LatLng latLng = LatLng(lat / 1E5, lng / 1E5);
      coordinates.add(latLng);
    }
    return coordinates;
  }
}
