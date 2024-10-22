import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class TermalesScreen extends StatefulWidget {
  @override
  _TermalesScreenState createState() => _TermalesScreenState();
}

class _TermalesScreenState extends State<TermalesScreen> {
  late GoogleMapController _mapController;
  LatLng _initialPosition =
      LatLng(-17.43411130001547, -70.03831385914525); // Nueva coordenada
  Marker? _marker;
  String _temperatura = 'Cargando...';
  String _hora = 'Cargando...';
  late Timer _timer; // 1. Declaración del Timer

  @override
  void initState() {
    super.initState();
    _setMarkerAndWeather(
        _initialPosition); // Establecer marcador y clima al iniciar
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (mounted) {
        // 2. Verificación del estado montado
        setState(() {
          _hora = TimeOfDay.now().format(context);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // 3. Cancelación del Timer en dispose()
    _mapController.dispose(); // Liberar recursos del controlador de mapas
    super.dispose();
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
        title: const Text('Baños termales'),
        backgroundColor: const Color(0xFF406E5B),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Fondo completo usando Stack
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/fondorelax.jpg'),
                  fit: BoxFit
                      .cover, // Aseguramos que la imagen cubra todo el fondo
                ),
              ),
            ),
            // Contenido sobre el fondo
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Bienvenido a los baños termales',
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
                        'Ubicados en un entorno natural privilegiado, los Baños Termales de Putina ofrecen una experiencia relajante y revitalizante. Sus aguas termales, ricas en minerales, son conocidas por sus propiedades curativas, perfectas para aliviar el estrés y revitalizar el cuerpo. Rodeado de naturaleza, este lugar es ideal para desconectarse y disfrutar de momentos de paz y tranquilidad en plena conexión con el entorno andino.',
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
          ],
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
        'assets/images/relax5.png',
        'assets/images/relax6.png',
        'assets/images/relax7.jpg',
        'assets/images/relax8.jpg',
        'assets/images/relax9.jpg',
        'assets/images/relax10.jpg',
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