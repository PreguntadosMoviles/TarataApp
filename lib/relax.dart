import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RelaxScreen extends StatelessWidget {
  final CarouselSliderController _carouselController =
      CarouselSliderController(); // Usar la clase correcta

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relax'),
        backgroundColor: const Color(0xFF406E5B),
      ),
      backgroundColor: const Color(0xFFFBE4CF),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF406E5B),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: const [
                Text(
                  'RELAX',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'TARATA',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFADFAE),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Primer carrusel
          CarouselSlider(
            carouselController: _carouselController, // Clase corregida
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
            ]
                .map((item) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(item),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),

          // Segundo carrusel
          CarouselSlider(
            carouselController: _carouselController, // Clase corregida
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
            ]
                .map((item) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(item),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
