import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Termales1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baños Termales'),
        backgroundColor: const Color(0xFF406E5B),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/fondorelax.jpg'),
                fit: BoxFit
                    .cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Bienvenido a los baños termales',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    _buildCarousel(),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.black
                            .withOpacity(0.5),
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Ubicados en un entorno natural privilegiado, los Baños Termales de Putina ofrecen una experiencia relajante y revitalizante. Sus aguas termales, ricas en minerales, son conocidas por sus propiedades curativas, perfectas para aliviar el estrés y revitalizar el cuerpo. Rodeado de naturaleza, este lugar es ideal para desconectarse y disfrutar de momentos de paz y tranquilidad en plena conexión con el entorno andino.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
