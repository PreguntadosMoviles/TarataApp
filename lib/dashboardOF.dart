import 'package:flutter/material.dart';
import 'ruta.dart';
import 'juegos.dart';
import 'relax.dart';
import 'senderismo.dart';

class DashboardScreenOF extends StatefulWidget {
  @override
  _DashboardScreenOF createState() => _DashboardScreenOF();
}

class _DashboardScreenOF extends State<DashboardScreenOF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: const Color(0xFFFBE4CF),
      ),
      backgroundColor: const Color(0xFFFBE4CF),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Parte superior con la imagen y el título
            Container(
              height: 350, 
              width: double.infinity, 
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
                    radius: 60, 
                    backgroundImage: AssetImage('assets/images/user.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Bienvenido',
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
                          const Color(0xFF406E5B),
                      padding: const EdgeInsets.symmetric(
                          vertical: 24), 
                      shape:
                          const BeveledRectangleBorder(),
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
                        const SizedBox(
                            height: 8), 
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 24), 
                      shape:
                          const BeveledRectangleBorder(), 
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 24),
                      shape:
                          const BeveledRectangleBorder(),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 24), 
                      shape:
                          const BeveledRectangleBorder(),
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
          ],
        ),
      ),
      bottomNavigationBar: const SizedBox(
          height: 0), 
    );
  }
}
