import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'ceramica.dart'; // Asegúrate de importar la pantalla ceramica.dart
import 'termales.dart';

class RelaxScreen extends StatefulWidget {
  @override
  _RelaxScreenState createState() => _RelaxScreenState();
}

class _RelaxScreenState extends State<RelaxScreen> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  bool _isFirstCarouselActive = false;
  bool _isSecondCarouselActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0xFFFBE4CF),
      ),
      backgroundColor: const Color(0xFFFBE4CF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Contenedor verde
            Container(
              width: double.infinity,
              color: const Color(0xFF406E5B),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'RELAX',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'TARATA',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFADFAE),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Título del primer carrusel
            const Text(
              'Taller de cerámica y alfarería',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // Primer carrusel con botón "Ver Información"
            _buildCarouselWithOverlay(
              images: [
                'assets/images/relax1.png',
                'assets/images/relax2.png',
                'assets/images/relax3.jpg',
                'assets/images/relax4.jpg',
              ],
              isActive: _isFirstCarouselActive,
              onTap: () {
                setState(() {
                  _isFirstCarouselActive = !_isFirstCarouselActive;
                  _isSecondCarouselActive = false; // Oculta el segundo carrusel
                });
              },
              onInfoPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CeramicaScreen()),
                );
              },
            ),
            const SizedBox(height: 20),

            // Título del segundo carrusel
            const Text(
              'Baños termales',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // Segundo carrusel con botón "Ver Información"
            _buildCarouselWithOverlay(
              images: [
                'assets/images/relax5.png',
                'assets/images/relax6.png',
                'assets/images/relax7.png',
                'assets/images/relax8.jpg',
                'assets/images/relax9.jpg',
                'assets/images/relax10.jpg',
              ],
              isActive: _isSecondCarouselActive,
              onTap: () {
                setState(() {
                  _isSecondCarouselActive = !_isSecondCarouselActive;
                  _isFirstCarouselActive = false; // Oculta el primer carrusel
                });
              },
              onInfoPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TermalesScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir un carrusel con texto y botón de información
  Widget _buildCarouselWithOverlay({
    required List<String> images,
    required bool isActive,
    required VoidCallback onTap,
    required VoidCallback onInfoPressed, // Añadido
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              height: 200,
              autoPlay: !isActive, // Detiene el carrusel si está activo
              autoPlayInterval: const Duration(seconds: 3),
              enlargeCenterPage: true,
            ),
            items: images.map((item) => _buildImageContainer(item)).toList(),
          ),
          if (isActive)
            Container(
              color: Colors.black54, // Oscurecer el fondo
              height: 200,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 150,
                    child: Center(
                      child: Text(
                        'Toque para ver más información',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF406E5B),
                    ),
                    onPressed:
                        onInfoPressed, // Llama a la función onInfoPressed
                    child: const Text(
                      'Ver Información',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Método reutilizable para construir contenedores de imágenes
  Widget _buildImageContainer(String imagePath) {
    return Container(
      width: double.infinity, // Asegura que el contenedor ocupe todo el ancho
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
