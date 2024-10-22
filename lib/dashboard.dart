import 'package:apptarata/mapa_tarata.dart';
import 'package:flutter/material.dart';
import 'mapa_tarata.dart' hide MyApp;
import 'juegos.dart' hide MyApp;
import 'relax.dart' hide MyApp;
import 'senderismo.dart' hide MyApp;
import 'main.dart'; 
import 'package:video_player/video_player.dart'; // Importar el paquete de video_player

class DashboardScreen extends StatefulWidget {
  final String? nombreUsuario; // Parámetro opcional para el nombre de usuario

  // Constructor que acepta el nombre de usuario
  DashboardScreen({this.nombreUsuario});

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
        setState(() {}); // Actualiza el estado cuando el video esté listo
        _controller.setLooping(true); // Para que el video se repita en bucle
        _controller.play(); // Inicia la reproducción del video
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera el controlador cuando se destruye el widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determinar el texto de bienvenida
    String saludo = widget.nombreUsuario != null
        ? 'Bienvenido ${widget.nombreUsuario}'
        : 'Bienvenido';

    return Scaffold(
      body: Stack(
        children: [
          // Video de fondo
          _controller.value.isInitialized
              ? SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                )
              : Container(), // Muestra un contenedor vacío mientras el video carga

          // Botón de cerrar sesión en la parte superior derecha
          Positioned(
            top: 20,
            right: 10,
            child: GestureDetector(
              onTap: () {
                // Redirigir a la pantalla principal (main.dart)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()), // Redirige a la pantalla principal
                );
              },
              child: Icon(
                Icons.logout,
                color: Colors.white, // Cambiar el color del ícono a blanco
                size: 30,
              ),
            ),
          ),

          // Contenido sobre el video
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/images/user.png'),
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        saludo, // Mostrar el saludo dinámico
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Disposición vertical de los botones
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      buildButton(
                        context,
                        'Ir a Relax',
                        'assets/images/relax.png',
                        RelaxScreen(),
                      ),
                      const SizedBox(height: 10),
                      buildButton(
                        context,
                        'Ir a Senderismo',
                        'assets/images/senderismo.png',
                        SenderismoScreen(),
                      ),
                      const SizedBox(height: 10),
                      buildButton(
                        context,
                        'Ir a Ruta',
                        'assets/images/ruta.png',
                        MapaTarata(),
                      ),
                      const SizedBox(height: 10),
                      buildButton(
                        context,
                        'Ir a Juegos',
                        'assets/images/yunga.png',
                        ParqueFerialScreen(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Método para crear botones consistentes
  Widget buildButton(
      BuildContext context, String label, String assetPath, Widget targetScreen) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetScreen),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF406E5B).withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Image.asset(
              assetPath,
              height: 36,
            ),
          ],
        ),
      ),
    );
  }
}
