import 'package:flutter/material.dart';
import 'ruta.dart'; // Asegúrate de importar ruta.dart

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
            SizedBox(height: 20), // Espacio entre el texto y el botón
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
          ],
        ),
      ),
    );
  }
}
