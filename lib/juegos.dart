import 'package:flutter/material.dart';
import 'dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ParqueFerialScreen(),
    );
  }
}

class ParqueFerialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de la imagen del puente tibetano
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.darken,
              ),
              child: Image.asset(
                'assets/images/puente.jpg', 
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenido superpuesto
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                  'YUNGA',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
              ),
              Text(
                'PARQUE FERIAL',
                style: TextStyle(
                  fontSize: 32, 
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFE135),
                  letterSpacing: 2,
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 48,
                      weight: 5), 
                  Column(
                    children: [
                      Text(
                        'PUENTE',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold, 
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'TIBETANO',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold, 
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 48,
                      weight: 5), 
                ],
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0), 
                    topRight: Radius.circular(30.0),
                  ),
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3, 
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Atrévete a cruzar el columpio tibetano.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      child: Text(
                        'MÁS INFORMACIÓN',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Botones de precios y galería elevados
          Positioned(
            left: 10,
            top: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_money,
                      color: Colors.white, size: 48), 
                  onPressed: () {
                   
                  },
                ),
                Text(
                  'Precios',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            top: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.photo,
                      color: Colors.white, size: 48), 
                  onPressed: () {
                   
                  },
                ),
                Text(
                  'Galería',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
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
