import 'package:flutter/material.dart';
import 'mapa_tarata.dart'; // Asegúrate de que el archivo mapa_tarata.dart esté creado

class RutaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ruta de Acceso a Tarata',
          style: TextStyle(
              color: Colors.white), // Cambia el color del texto a blanco
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: MapaTarata(), // Usa el widget MapaTarata aquí
    );
  }
}
