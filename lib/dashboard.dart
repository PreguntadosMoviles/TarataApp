import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'mapa_tarata.dart' hide MyApp;
import 'ruta.dart';
import 'juegos.dart' hide MyApp;
import 'relax.dart' hide MyApp;
import 'senderismo.dart' hide MyApp;
import 'main.dart';
import 'package:video_player/video_player.dart';

class DashboardScreen extends StatefulWidget {
  final String? nombreUsuario;
  final bool isOffline; // Parámetro para identificar si es modo desconectado

  DashboardScreen({this.nombreUsuario, this.isOffline = false});

  @override
  _DashboardScreen createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  late VideoPlayerController _controller;
  String? _nombreUsuario;
  String? _emailUsuario;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/background.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      });
    if (!widget.isOffline) {
      _getUserData();  // Solo obtener los datos si el usuario está conectado
    }
  }

  // Función para obtener los datos del usuario desde Firestore
  Future<void> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _emailUsuario = user.email;
      });

      // Obtener nombre del usuario desde Firestore
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .get();
      
      if (doc.exists) {
        setState(() {
          _nombreUsuario = doc['nombre'];  // Asegúrate de tener el campo 'nombre' en Firestore
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Método para hacer logout
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();  // Cerrar sesión en Firebase
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => MyApp()),  // Redirigir al login
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    String saludo = widget.isOffline
        ? 'Bienvenido (Modo Desconectado)'
        : (_nombreUsuario != null ? 'Bienvenido $_nombreUsuario' : 'Bienvenido');

    return Scaffold(
      body: Stack(
        children: [
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
              : Container(),
          Positioned(
            bottom: 20,
            right: 10,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF406E5B),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(50, 50),
              ),
              onPressed: _logout,  // Llamamos al método logout
              child: Icon(
                Icons.logout,
                color: Colors.white,
                size: 24,
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
                        saludo,
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
                        RutaScreen(),
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
