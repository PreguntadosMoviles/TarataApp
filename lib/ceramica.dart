import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class CeramicaScreen extends StatefulWidget {
  @override
  _CeramicaScreenState createState() => _CeramicaScreenState();
}

class _CeramicaScreenState extends State<CeramicaScreen> {
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
      appBar: AppBar(
        title: const Text('Cerámica y Alfarería'),
        backgroundColor: const Color(0xFF406E5B),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondorelax.jpg'),
            fit: BoxFit.cover, // Aseguramos que la imagen cubra todo el fondo
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bienvenido al Taller de Cerámica',
                    style: TextStyle(
                      fontSize: 28, // Tamaño de letra aumentado
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Carrusel de imágenes arriba de la información
                  _buildCarousel(),
                  const SizedBox(height: 20),
                  // Contenedor oscuro y transparente para la información
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.black
                          .withOpacity(0.5), // Color oscuro y transparente
                      borderRadius:
                          BorderRadius.circular(10), // Bordes redondeados
                    ),
                    child: const Text(
                      'Descubre el arte ancestral de la cerámica y la alfarería en este taller interactivo. Bajo la guía de artesanos locales, aprenderás las técnicas tradicionales para moldear y decorar piezas únicas de barro. Es una oportunidad perfecta para relajarse mientras desarrollas tu creatividad, creando recuerdos tangibles de tu visita a Tarata, todo en un ambiente tranquilo y culturalmente enriquecedor.',
                      style: TextStyle(
                        fontSize: 18, // Tamaño de letra aumentado
                        fontWeight: FontWeight.bold, // Texto en negrita
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Contenedor para mapa, hora y temperatura
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
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
                        Container(
                          height: 250, // Ajusta la altura del mapa
                          width: double.infinity,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Método para construir el carrusel de imágenes
  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        enlargeCenterPage: true,
      ),
      items: [
        'assets/images/relax1.png',
        'assets/images/relax2.png',
        'assets/images/relax3.jpg',
        'assets/images/relax4.jpg',
      ].map((item) => _buildImageContainer(item)).toList(),
    );
  }

  // Método para construir contenedores de imágenes
  Widget _buildImageContainer(String imagePath) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
