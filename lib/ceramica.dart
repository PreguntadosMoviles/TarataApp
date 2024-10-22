import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CeramicaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cerámica y Alfarería'),
        backgroundColor: const Color(0xFF406E5B),
      ),
      body: Stack(
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
          SingleChildScrollView(
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
                    // Información adicional sobre el taller
                    const Text(
                      'Descubre el arte ancestral de la cerámica y la alfarería en este taller interactivo. Bajo la guía de artesanos locales, aprenderás las técnicas tradicionales para moldear y decorar piezas únicas de barro. Es una oportunidad perfecta para relajarse mientras desarrollas tu creatividad, creando recuerdos tangibles de tu visita a Tarata, todo en un ambiente tranquilo y culturalmente enriquecedor.',
                      style: TextStyle(
                        fontSize: 18, // Tamaño de letra aumentado
                        fontWeight: FontWeight.bold, // Texto en negrita
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
