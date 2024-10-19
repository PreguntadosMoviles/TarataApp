import 'package:flutter/material.dart';
import 'login.dart'; 
import 'dashboard.dart'; 
import 'registro.dart'; 
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'dart:async'; 

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

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  late PageController _pageController;
  int _currentPage = 0;
  final List<String> _texts = ['WELCOME TO\nTARATA', 'BIENVENIDO A\nTARATA', 'KAMISARAKI\nTARATA']; // Inglés, español, aymara

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    
    _controller = VideoPlayerController.asset('assets/videos/background.mp4')
      ..initialize().then((_) {
        // Reproducir el video en loop cuando esté listo
        _controller.setLooping(true);
        _controller.play();
        setState(() {}); // Actualizamos el estado cuando el video está inicializado
      });
    
    // Temporizador para cambiar las páginas automáticamente cada 5 segundos
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    // Liberar el controlador cuando no se necesite más
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Definir los colores personalizados
    final Color iniciarSesionColor = Color(0xFF3AAF7F); // Verde claro para "Iniciar Sesión"
    final Color modoDesconectadoColor = Color(0xFF406E5B); // Verde oscuro para "Ingresar en modo desconectado"

    return Scaffold(
      body: Stack(
        children: [
          // Video de fondo que cubre toda la pantalla
          Positioned.fill(
            child: _controller.value.isInitialized
                ? Stack(
                    children: [
                      VideoPlayer(_controller), // Video que cubre toda la pantalla
                      // Contenedor con opacidad encima del video
                      Container(
                        color: Colors.black.withOpacity(0.5), // Ajusta el valor de opacidad aquí
                      ),
                    ],
                  )
                : Container(color: Colors.black), // Muestra un fondo negro mientras carga el video
          ),
          // Contenido centrado
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0), // Padding lateral
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center, // Centrar todo horizontalmente
                children: [
                  // Carrusel de texto
                  Container(
                    height: 120, // Altura del contenedor de texto
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _texts.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Text(
                            _texts[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 36, // Mantener el título grande
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30), // Reducir el espaciado entre el título y la frase
                  Text(
                    'Ingresa para poder conocer las maravillas de Tarata.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16, // Reducir ligeramente el tamaño de la fuente
                      color: Colors.white,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(height: 20), // Reducir el espaciado entre la frase y el botón de iniciar sesión
                  // Botón de "Iniciar Sesión"
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: iniciarSesionColor,
                      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12), // Reducir el padding del botón
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25), // Botón redondeado
                      ),
                    ),
                    onPressed: () {
                      // Navegar a la pantalla de Login
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 16, // Tamaño de fuente más pequeño en el botón
                      ),
                    ),
                  ),
                  SizedBox(height: 15), // Reducir el espaciado entre botones
                  Text(
                    '¿Eres nuevo en la app?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navegar a la pantalla de Registro
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistroScreen()),
                      );
                    },
                    child: Column(
                      children: [
                        Text(
                          '¡Regístrate aquí!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16, // Tamaño de fuente más pequeño
                            decoration: TextDecoration.underline,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        SizedBox(height: 8), // Espacio más pequeño debajo del icono
                        Icon(Icons.edit, color: Colors.white, size: 24), // Icono más pequeño
                      ],
                    ),
                  ),
                  SizedBox(height: 15), // Reducir el espaciado
                  Text(
                    '¿Sin conexión? No hay problema.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14, // Tamaño de fuente más pequeño
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(height: 15),
                  // Botón de "Ingresar en modo desconectado"
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: modoDesconectadoColor,
                      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12), // Reducir el padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25), // Botón redondeado
                      ),
                    ),
                    onPressed: () {
                      // Navegar al dashboard en modo desconectado
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DashboardScreen()),
                      );
                    },
                    child: Text(
                      'Ingresar en modo desconectado',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 16, // Texto más pequeño
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
