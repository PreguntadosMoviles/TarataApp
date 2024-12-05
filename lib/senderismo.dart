import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SenderismoScreen(),
    );
  }
}

class SenderismoScreen extends StatefulWidget {
  @override
  _SenderismoScreenState createState() => _SenderismoScreenState();
}

class _SenderismoScreenState extends State<SenderismoScreen> {
  bool _isExpanded = false;
  int _currentImageIndex = 0;
  late Timer _imageChangeTimer;

  final List<String> _backgroundImages = [
    'assets/images/senderismo1.jpg',
    'assets/images/senderismo2.jpg',
    'assets/images/senderismo3.jpg',
    'assets/images/senderismo4.jpg',
    'assets/images/senderismo5.png',
  ];

  final PolylinePoints _polylinePoints = PolylinePoints();
  GoogleMapController? _mapController;

  LatLng _currentLocation = LatLng(0, 0);  // Placeholder for current location
  final LatLng _destination = LatLng(-17.471679874807474, -70.03172932582684);  // New meta (destination)

  Set<Polyline> _polylines = Set<Polyline>();
  late Position _position;
  late Timer _locationTimer;

  @override
  void initState() {
    super.initState();
    _imageChangeTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _currentImageIndex =
            (_currentImageIndex + 1) % _backgroundImages.length;
      });
    });
    _getCurrentLocation(); // Get the current location
  }

  @override
  void dispose() {
    _imageChangeTimer.cancel();
    _locationTimer.cancel();
    super.dispose();
  }

  void _toggleContainerSize() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  // Método para obtener la ubicación actual
  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    _locationTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      _position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentLocation = LatLng(_position.latitude, _position.longitude);
        _drawRoute(); // Dibujar la línea entre la ubicación actual y la meta
      });
    });
  }

// Método para dibujar la ruta
void _drawRoute() async {
  List<LatLng> polylineCoordinates = [];

  // Crear el objeto PolylineRequest
  PolylineRequest wa = PolylineRequest(
    origin: PointLatLng(_currentLocation.latitude, _currentLocation.longitude),
    destination: PointLatLng(_destination.latitude, _destination.longitude),
    mode: TravelMode.driving,  // Usamos "driving" para el modo de transporte
  );

  // Llamar a getRouteBetweenCoordinates pasando el request como argumento
  PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
    request: wa,
    googleApiKey: 'AIzaSyDYMS4cdyIBc8Y9bzrNNM8G8UI69rzS04U',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (_isExpanded) _toggleContainerSize();
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
                child: Image.asset(
                  _backgroundImages[_currentImageIndex],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Text(
                      'SENDERISMO',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  Text(
                    'TARATA',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFE135),
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _toggleContainerSize,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 54, 107, 55),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: Text(
                      _isExpanded ? 'MENOS INFORMACIÓN' : 'MÁS INFORMACIÓN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      _showRouteModal(context); // Mostrar modal con mapa
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[300],
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: Text(
                      'Como llegar al punto de partida',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: _isExpanded
                    ? MediaQuery.of(context).size.height * 0.5
                    : MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isExpanded
                          ? 'Explora el histórico Camino Inca, rodeado de paisajes andinos...'
                          : 'Explora el histórico Camino Inca...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _isExpanded ? 16 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (_isExpanded) SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  // Modal para ver el recorrido
  void _showRouteModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Recorrido',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey[900],
          content: Container(
            height: 300,
            width: double.infinity,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentLocation,
                zoom: 12.0,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
                _drawRoute(); // Dibuja la ruta
              },
              polylines: _polylines,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cerrar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
