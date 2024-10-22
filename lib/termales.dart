import 'package:flutter/material.dart';

class TermalesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baños Termales'),
      ),
      body: Center(
        child: Text(
          'Bienvenido a los Baños Termales',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
