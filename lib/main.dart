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
  final List<String> _texts = [
    'WELCOME TO\nTARATA',
    'BIENVENIDO A\nTARATA',
    'KAMISARAKI\nTARATA'
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _controller = VideoPlayerController.asset('assets/videos/background.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.play();
        setState(
            () {}); 
      });


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
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color iniciarSesionColor =
        Color(0xFF3AAF7F); 
    final Color modoDesconectadoColor =
        Color(0xFF406E5B); 

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _controller.value.isInitialized
                ? Stack(
                    children: [
                      VideoPlayer(
                          _controller), 
                      Container(
                        color: Colors.black.withOpacity(
                            0.5), 
                      ),
                    ],
                  )
                : Container(
                    color: Colors
                        .black), 
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 32.0), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.center, 
                children: [
                  Container(
                    height: 120, 
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _texts.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Text(
                            _texts[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 36, 
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
                  SizedBox(
                      height:
                          30), 
                  Text(
                    'Ingresa para poder conocer las maravillas de Tarata.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:
                          16, 
                      color: Colors.white,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(
                      height:
                          20), 
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: iniciarSesionColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: 35,
                          vertical: 12), 
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(25), 
                      ),
                    ),
                    onPressed: () {
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
                        fontSize:
                            16,
                      ),
                    ),
                  ),
                  SizedBox(height: 15), 
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistroScreen()),
                      );
                    },
                    child: Column(
                      children: [
                        Text(
                          '¡Regístrate aquí!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16, 
                            decoration: TextDecoration.underline,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        SizedBox(
                            height: 8), 
                        Icon(Icons.edit,
                            color: Colors.white, size: 24), 
                      ],
                    ),
                  ),
                  SizedBox(height: 15), 
                  Text(
                    '¿Sin conexión? No hay problema.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14, 
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: modoDesconectadoColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: 35, vertical: 12), 
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(25), 
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardScreen()),
                      );
                    },
                    child: Text(
                      'Ingresar en modo desconectado',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 16, 
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
