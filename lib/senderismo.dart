import 'package:flutter/material.dart';
import 'dart:async';

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
  bool _isExpanded = false; // Controla si el contenedor está expandido o no
  int _currentImageIndex = 0;
  late Timer _imageChangeTimer;

  final List<String> _backgroundImages = [
    'assets/images/senderismo1.jpg',
    'assets/images/senderismo2.jpg',
    'assets/images/senderismo3.jpg',
    'assets/images/senderismo4.jpg',
    'assets/images/senderismo5.png',
  ];

  @override
  void initState() {
    super.initState();
    _imageChangeTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _currentImageIndex =
            (_currentImageIndex + 1) % _backgroundImages.length;
      });
    });
  }

  @override
  void dispose() {
    _imageChangeTimer.cancel();
    super.dispose();
  }

  void _toggleContainerSize() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (_isExpanded)
            _toggleContainerSize(); // Oculta el contenedor al hacer clic fuera si está expandido
        },
        child: Stack(
          children: [
            // Fondo de imágenes cambiantes
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
            // Contenido superior
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: Text(
                      _isExpanded ? 'MENOS INFORMACIÓN' : 'MÁS INFORMACIÓN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            // Contenedor inferior con información
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
                          ? 'Explora el histórico Camino Inca, rodeado de paisajes andinos, y aventúrate a la enigmática Cueva Quala Quala, con sus fascinantes formaciones rocosas. Termina el recorrido en un sitio arqueológico, descubriendo los restos de antiguas civilizaciones que habitaron la región. Una experiencia perfecta para los amantes de la historia y la naturaleza.'
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
}
