import 'package:flutter/material.dart';
import 'ruta.dart'; 
import 'juegos.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pantalla de Dashboard (Modo Desconectado)'),
            SizedBox(height: 20), // Espacio entre el texto y los botones
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla definida en ruta.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RutaScreen()), // Asegúrate de que RutaScreen esté definido en ruta.dart
                );
              },
              child: Text('Ir a Ruta'),
            ),
            SizedBox(height: 20), // Espacio entre los botones
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla definida en juegos.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ParqueFerialScreen()), // Asegúrate de que JuegosScreen esté definido en juegos.dart
                );
              },
              child: Text('Ir a Juegos'),
            ),
          ],
        ),
      ),
    );
  }
}
