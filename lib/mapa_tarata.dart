import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';

class MapaTarata extends StatefulWidget {
  @override
  _MapaTarataState createState() => _MapaTarataState();
}

class _MapaTarataState extends State<MapaTarata> {
  late GoogleMapController _mapController;
  LatLng _initialPosition = LatLng(0.0, 0.0); // Coordenadas iniciales vacías
  Marker? _marker;
  IconData _iconoCentral = Icons.home;
  String _temperatura = 'Cargando...';
  String _hora = 'Cargando...';
  Set<Polyline> _polylines = {}; // Para almacenar las polilíneas

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Obtener la ubicación actual al iniciar
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _hora = TimeOfDay.now().format(context);
      });
    });
  }

  // Método para obtener la ubicación actual
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica si los servicios de localización están habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Si los servicios no están habilitados, muestra un mensaje y sale
      return;
    }

    // Verifica los permisos de ubicación
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Si el permiso está denegado, solicita el permiso
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    // Obtiene la ubicación actual
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // Actualiza la posición inicial con la ubicación obtenida
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      _setMarkerAndWeather(_initialPosition); // Establecer marcador y clima
    });
  }

  void _setMarkerAndWeather(LatLng location) {
    _marker = Marker(
      markerId: MarkerId('currentLocation'),
      position: location,
      infoWindow: InfoWindow(title: 'Ubicación Actual'),
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
                    _buildLocationButton('Plaza', LatLng(-17.47441167642077, -70.03143642188739), Icons.location_city),
                    _buildLocationButton('Mercado', LatLng(-17.47548621305333, -70.03129694701204), Icons.shopping_cart),
                    _buildLocationButton('Iglesia Tarucachi', LatLng(-17.526395986397954, -70.02885748446944), Icons.church),
                    _buildLocationButton('Municipalidad Provincial', LatLng(-17.47494266492219, -70.03169623007938), Icons.apartment),
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
  List<LatLng> polylineCoordinates = [];

  // Crear el objeto PolylineRequest
  PolylineRequest routeRequest = PolylineRequest(
    origin: PointLatLng(_initialPosition.latitude, _initialPosition.longitude),
    destination: PointLatLng(destination.latitude, destination.longitude),
    mode: TravelMode.walking,  // Usamos "walking" para el modo de transporte
  );

  // Llamar a getRouteBetweenCoordinates pasando el request como argumento
  PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
    request: routeRequest,
    googleApiKey: 'AIzaSyDYMS4cdyIBc8Y9bzrNNM8G8UI69rzS04U',  // Reemplaza con tu clave de API de Google Maps
  );

  if (result.status == "OK") {
    // Agregar solo los puntos de la ruta calculada
    polylineCoordinates.addAll(result.points.map((point) =>
        LatLng(point.latitude, point.longitude)));
  }

  setState(() {
    _polylines.clear();  // Limpiar las líneas anteriores
    _polylines.add(Polyline(
      polylineId: PolylineId('route'),
      visible: true,
      points: polylineCoordinates,
      width: 4,
      color: Colors.blue,
      geodesic: true,
    ));
  });
}
}
