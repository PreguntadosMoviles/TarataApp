import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart'; // Importa el paquete de video
import 'ruta.dart';
import 'juegos.dart';
import 'relax.dart';
import 'senderismo.dart';
import 'login.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreen createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/background.mp4')
      ..initialize().then((_) {
        setState(() {}); // Actualiza el estado cuando el video esté cargado
        _controller.setLooping(true); // Configura para que se repita el video
        _controller.play(); // Inicia la reproducción automática
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera el controlador cuando la pantalla se destruye
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Video de fondo
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(), // Muestra un contenedor vacío mientras se carga el video

          // Contenido encima del video
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Parte superior con la imagen y el título
                Container(
                  height: 350,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.black45, // Agrega un fondo semi-transparente
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/images/user.png'),
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Bienvenido Usuario',
                        style: TextStyle(
                          fontSize: 32,
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
                          backgroundColor: const Color(0xFF406E5B),
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          shape: const BeveledRectangleBorder(),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Ir a Relax',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Image.asset(
                              'assets/images/relax.png',
                              height: 36,
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
                                builder: (context) => SenderismoScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF406E5B),
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          shape: const BeveledRectangleBorder(),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Ir a Senderismo',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Image.asset(
                              'assets/images/senderismo.png',
                              height: 36,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

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
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          shape: const BeveledRectangleBorder(),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Ir a Ruta',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Image.asset(
                              'assets/images/ruta.png',
                              height: 36,
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
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          shape: const BeveledRectangleBorder(),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Ir a Juegos',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Image.asset(
                              'assets/images/yunga.png',
                              height: 36,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Botón de Cerrar Sesión
                SizedBox(
                  width: double.infinity, // Ocupa todo el ancho
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen()), // Asegúrate de que LoginScreen esté definido en login.dart
                      );
                    },
                    child: const Text(
                      'Cerrar Sesión',
                      style: TextStyle(
                        color: Colors.white, // Color del texto cambiado a blanco
                        fontWeight: FontWeight.bold, // Texto en negrita
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.redAccent, // Color del botón
                      shape: const BeveledRectangleBorder(), // Bordes sin redondear
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
