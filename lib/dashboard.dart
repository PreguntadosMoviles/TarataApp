import 'package:flutter/material.dart';
import 'ruta.dart';
import 'juegos.dart';
import 'relax.dart';
import 'senderismo.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreen createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      backgroundColor: const Color(0xFFFBE4CF),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Parte superior con la imagen y el título
            Container(
              height: 350, // Ajusta la altura para que la imagen sea más grande
              width: double.infinity, // Ocupa todo el ancho de la pantalla
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 60, // Imagen del usuario más grande
                    backgroundImage: AssetImage('assets/images/user.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Bienvenido Usuario',
                    style: TextStyle(
                      fontSize: 32, // Aumentar el tamaño del texto
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Espacio entre el texto y los botones

            // Fila de botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RelaxScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF406E5B), // Color de fondo
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Ir a Relax',
                          style:
                              TextStyle(color: Colors.white), // Color de texto
                        ),
                        const SizedBox(
                            height: 8), // Espacio entre el texto y el ícono
                        Image.asset(
                          'assets/images/relax.png', // Ruta del ícono
                          height: 24, // Tamaño del ícono
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Espacio entre botones
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SenderismoScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF406E5B),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Ir a Senderismo',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Image.asset(
                          'assets/images/senderismo.png',
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10), // Espacio entre las filas

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RutaScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF406E5B),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Ir a Ruta',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Image.asset(
                          'assets/images/ruta.png',
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ParqueFerialScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF406E5B),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Ir a Juegos',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Image.asset(
                          'assets/images/yunga.png',
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Espacio entre las filas

            // Botón de Cerrar Sesión
            SizedBox(
              width: double.infinity, // Ocupa todo el ancho
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Cierra sesión y regresa
                },
                child: const Text('Cerrar Sesión'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.redAccent, // Color del botón
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
