import 'package:flutter/material.dart';
import 'dart:async'; // Importa el paquete para usar Timer
import 'dashboard.dart';

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
  bool _isContainerVisible = false; // Controla la visibilidad del contenedor
  int _currentImageIndex = 0; // Índice de la imagen actual
  late Timer _imageChangeTimer; // Timer para cambiar la imagen

  // Lista de imágenes de fondo
  final List<String> _backgroundImages = [
    'assets/images/senderismo1.png',
    'assets/images/senderismo2.png',
    'assets/images/senderismo3.png',
    'assets/images/senderismo4.png',
  ];

  @override
  void initState() {
    super.initState();
    // Inicia el Timer para cambiar la imagen cada 2 segundos
    _imageChangeTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) %
            _backgroundImages.length; // Cambia la imagen
      });
    });
  }

  @override
  void dispose() {
    _imageChangeTimer.cancel(); // Cancela el Timer cuando se elimina el widget
    super.dispose();
  }

  void _toggleContainerVisibility() {
    setState(() {
      _isContainerVisible = !_isContainerVisible;
    });
  }

  void _hideContainer() {
    if (_isContainerVisible) {
      _toggleContainerVisibility();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _hideContainer, // Oculta el contenedor gris al tocar el fondo
        child: Stack(
          children: [
            // Fondo de la imagen de senderismo
            Positioned.fill(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), // Oscurece la imagen
                  BlendMode.darken,
                ),
                child: Image.asset(
                  _backgroundImages[_currentImageIndex], // Imagen de senderismo
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Título "SENDERISMO" y "TARATA"
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
                    'TARATA', // Cambiado de "PARQUE FERIAL" a "TARATA"
                    style: TextStyle(
                      fontSize: 32, // Aumenta el tamaño del texto
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFE135), // Amarillo patito
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 10), // Espacio entre el título y el botón
                  ElevatedButton(
                    onPressed: _toggleContainerVisibility,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color.fromARGB(255, 54, 107, 55), // Color del botón
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: Text(
                      'MÁS INFORMACIÓN',
                      style: TextStyle(color: Colors.white), // Texto blanco
                    ),
                  ),
                ],
              ),
            ),
            // Contenedor gris con bordes redondeados
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedOpacity(
                opacity: _isContainerVisible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: Visibility(
                  visible: _isContainerVisible,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0), // Bordes redondeados
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height *
                        0.5, // Ajuste de altura para 1/2 de la pantalla
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Explora el histórico Camino Inca, rodeado de paisajes andinos, y aventúrate a la enigmática Cueva Quala Quala, con sus fascinantes formaciones rocosas. Termina el recorrido en un sitio arqueológico, descubriendo los restos de antiguas civilizaciones que habitaron la región. Una experiencia perfecta para los amantes de la historia y la naturaleza.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center, // Centra el texto
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible:
            _isContainerVisible, // El botón de retroceso solo se muestra cuando el contenedor está visible
        child: Positioned(
          left: 20,
          top: 40, // Posiciona el botón en la parte superior izquierda
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            child: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // Navegar a la pantalla definida en dashboard.dart
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DashboardScreen()), // Asegúrate de que DashboardScreen esté definido en dashboard.dart
              );
            },
          ),
        ),
      ),
    );
  }
}
