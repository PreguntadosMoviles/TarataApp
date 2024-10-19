import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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

            // Primer carrusel con texto
            _buildCarouselWithOverlay(
              images: [
                'assets/images/relax1.png',
                'assets/images/relax2.png',
                'assets/images/relax3.png',
              ],
              text:
                  'Descubre el arte ancestral de la cerámica y la alfarería en este taller interactivo. Bajo la guía de artesanos locales, aprenderás las técnicas tradicionales para moldear y decorar piezas únicas de barro. Es una oportunidad perfecta para relajarse mientras desarrollas tu creatividad, creando recuerdos tangibles de tu visita a Tarata, todo en un ambiente tranquilo y culturalmente enriquecedor.',
              isActive: _isFirstCarouselActive,
              onTap: () {
                setState(() {
                  _isFirstCarouselActive = !_isFirstCarouselActive;
                  _isSecondCarouselActive = false; // Oculta el segundo carrusel
                });
              },
            ),
            const SizedBox(height: 20),

            // Botón de Ver Ubicación para el primer carrusel
            if (_isFirstCarouselActive)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF406E5B),
                ),
                onPressed: () {
                  // Acción del botón para el primer carrusel
                },
                child: const Text(
                  'Ver Ubicación',
                  style: TextStyle(color: Colors.white), // Texto en blanco
                ),
              ),
            const SizedBox(height: 20),

            // Segundo carrusel con texto
            _buildCarouselWithOverlay(
              images: [
                'assets/images/relax4.png',
                'assets/images/relax5.png',
                'assets/images/relax6.png',
              ],
              text:
                  'Ubicados en un entorno natural privilegiado, los Baños Termales de Putina ofrecen una experiencia relajante y revitalizante. Sus aguas termales, ricas en minerales, son conocidas por sus propiedades curativas, perfectas para aliviar el estrés y revitalizar el cuerpo. Rodeado de naturaleza, este lugar es ideal para desconectarse y disfrutar de momentos de paz y tranquilidad en plena conexión con el entorno andino.',
              isActive: _isSecondCarouselActive,
              onTap: () {
                setState(() {
                  _isSecondCarouselActive = !_isSecondCarouselActive;
                  _isFirstCarouselActive = false; // Oculta el primer carrusel
                });
              },
            ),
            const SizedBox(height: 20),

            // Botón de Ver Ubicación para el segundo carrusel
            if (_isSecondCarouselActive)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF406E5B),
                ),
                onPressed: () {
                  // Acción del botón para el segundo carrusel
                },
                child: const Text(
                  'Ver Ubicación',
                  style: TextStyle(color: Colors.white), // Texto en blanco
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Método para construir un carrusel con texto
  Widget _buildCarouselWithOverlay({
    required List<String> images,
    required String text,
    required bool isActive,
    required VoidCallback onTap,
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold, // Texto en negrita
                    ),
                  ),
                ),
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
