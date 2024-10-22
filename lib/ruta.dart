import 'package:flutter/material.dart';
import 'mapa_tarata.dart';

class RutaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ruta de Acceso a Tarata',
          style: TextStyle(
              color: Colors.white
              ),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: MapaTarata(),
    );
  }
}
