import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MapaCeramica extends StatefulWidget {
  @override
  _MapaCeramicaState createState() => _MapaCeramicaState();
}

class _MapaCeramicaState extends State<MapaCeramica> {
  late GoogleMapController _mapController;
  LatLng _initialPosition =
      LatLng(-17.444421419011142, -70.04773716583185); // Nueva coordenada
  Marker? _marker;
  String _temperatura = 'Cargando...';
  String _hora = 'Cargando...';

  @override
  void initState() {
    super.initState();
    _setMarkerAndWeather(
        _initialPosition); // Establecer marcador y clima al iniciar
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
    final apiKey =
        '8d3426d47c0a287369de2ad44d01a886'; // Reemplaza con tu API Key
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
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
                        _mapController.animateCamera(
                            CameraUpdate.newLatLng(_initialPosition));
                      });
                    },
                    markers: _marker != null ? {_marker!} : {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
