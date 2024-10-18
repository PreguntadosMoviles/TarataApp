import 'package:flutter/material.dart';
import 'login.dart'; // Asegúrate de crear este archivo
import 'dashboard.dart'; // Asegúrate de crear este archivo
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Hacer que la aplicación se ejecute en modo pantalla completa
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo que cubre toda la pantalla
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png', // Cambia esta URL por la imagen correcta
              fit: BoxFit.cover,
            ),
          ),
          // Contenido encima de la imagen
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 2), // Espacio para centrar el texto
              Center(
                child: Text(
                  'WELCOME TO\nTARATA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(flex: 3), // Espacio para empujar hacia arriba y centrar
              Container(
                color: Colors.orange.shade50,
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Ingresa para poder conocer las maravillas de Tarata.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Fondo del botón
                      ),
                      onPressed: () {
                        // Navegar a la pantalla de Login
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text('Iniciar Sesión'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '¿Eres nuevo en la app?',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        // Acción de Registro
                      },
                      child: Text('¡Regístrate aquí!'),
                    ),
                    Icon(Icons.edit),
                    SizedBox(height: 16),
                    Text('¿Sin conexión? No hay problema.'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Fondo del botón
                      ),
                      onPressed: () {
                        // Navegar al dashboard en modo desconectado
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardScreen()),
                        );
                      },
                      child: Text('Ingresar en modo desconectado'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
