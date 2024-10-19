import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RelaxScreen extends StatelessWidget {
  final CarouselSliderController _carouselController =
      CarouselSliderController(); // Controlador del carrusel

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0xFFFBE4CF),
      ),
      backgroundColor: const Color(0xFFFBE4CF), // Fondo crema
      body: Column(
        children: [
          // Contenedor verde
          Container(
            width: double.infinity,
            color: const Color(0xFF406E5B), // Verde oscuro
            padding:
                const EdgeInsets.symmetric(vertical: 20), // Espaciado vertical
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ajusta el tamaño mínimo
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Centra el contenido
              children: const [
                Text(
                  'RELAX',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8), // Espacio entre RELAX y TARATA
                Text(
                  'TARATA',
                  style: TextStyle(
                    fontSize: 30, // Tamaño mayor para TARATA
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFADFAE), // Color crema claro
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
              height: 20), // Espacio entre el contenedor y el carrusel

          // Primer carrusel
          CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              enlargeCenterPage: true,
            ),
            items: [
              'assets/images/relax1.png',
              'assets/images/relax2.png',
              'assets/images/relax3.png',
            ].map((item) => _buildImageContainer(item)).toList(),
          ),
          const SizedBox(height: 20),

          // Segundo carrusel
          CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              enlargeCenterPage: true,
            ),
            items: [
              'assets/images/relax4.png',
              'assets/images/relax5.png',
              'assets/images/relax6.png',
            ].map((item) => _buildImageContainer(item)).toList(),
          ),
        ],
      ),
    );
  }

  // Método reutilizable para construir contenedores de imágenes
  Widget _buildImageContainer(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
