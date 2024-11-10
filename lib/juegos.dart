import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ParqueFerialScreen(),
      debugShowCheckedModeBanner: false, // Opcional: elimina la etiqueta de debug
    );
  }
}

class ParqueFerialScreen extends StatefulWidget {
  @override
  _ParqueFerialScreenState createState() => _ParqueFerialScreenState();
}

class _ParqueFerialScreenState extends State<ParqueFerialScreen> {
  final PageController _pageController = PageController();
  final List<String> _titles = [
    "PUENTE TIBETANO",
    "COLUMPIO EXTREMO",
    "ZIPLINE BIKE",
    "CANOPY"
  ];
  final List<String> _backgroundImages = [
    'assets/images/puente.jpg',
    'assets/images/columpio.jpg',
    'assets/images/zipline.png',
    'assets/images/canopy.jpg'
  ];
  final Map<String, List<String>> _galleryImages = {
    "PUENTE TIBETANO": [
      'assets/images/puente1.jpg',
      'assets/images/puente2.jpg'
    ],
    "COLUMPIO EXTREMO": [
      'assets/images/columpio1.jpg',
      'assets/images/columpio2.jpg'
    ],
    "ZIPLINE BIKE": [
      'assets/images/zipline1.jpg',
      'assets/images/zipline2.png'
    ],
    "CANOPY": [
      'assets/images/canopy1.jpg',
      'assets/images/canopy2.jpeg'
    ]
  };
  final Map<String, String> _attractionInfo = {
    "PUENTE TIBETANO": """
**Descripción General:**
El Puente Tibetano es una emocionante aventura a gran altura que desafía tu valentía y equilibrio. Cruzar este puente te permitirá disfrutar de vistas espectaculares del entorno natural.

**Actividades:**
- **Cruzando el Puente:** Camina sobre el estrecho puente suspendido entre dos pilares, sintiendo la adrenalina mientras te desplazas sobre el vacío.
- **Fotografía Panorámica:** Aprovecha los puntos estratégicos para capturar impresionantes fotografías del paisaje.
- **Desafío de Equilibrio:** Participa en competencias amistosas para ver quién puede cruzar el puente con el mejor equilibrio.

**Consejos:**
- Usa ropa cómoda y zapatos adecuados para caminar.
- No es necesario tener experiencia previa, pero se recomienda mantener la calma y seguir las indicaciones de los guías.
""",
    "COLUMPIO EXTREMO": """
**Descripción General:**
El Columpio Extremo es una experiencia única que combina la emoción del balanceo con vistas panorámicas de la naturaleza circundante. Es ideal para quienes buscan una dosis extra de adrenalina.

**Actividades:**
- **Balanceo de Alta Altura:** Siente la emoción mientras te balanceas a alturas impresionantes, disfrutando de la brisa y las vistas.
- **Retos de Tiempo:** Participa en retos para ver cuánto tiempo puedes mantener el balanceo sin perder la coordinación.
- **Fotografía en Movimiento:** Captura momentos dinámicos mientras te balanceas, creando recuerdos inolvidables.

**Consejos:**
- Mantén los brazos y las piernas en posición para un balanceo más estable.
- Escucha las instrucciones de los operadores para garantizar tu seguridad.
""",
    "ZIPLINE BIKE": """
**Descripción General:**
La Zipline Bike es una innovadora combinación de ciclismo y tirolesa. Esta atracción te permite deslizarte a gran velocidad mientras pedaleas, ofreciendo una experiencia única y emocionante.

**Actividades:**
- **Deslizamiento en Zipline:** Conecta tu bicicleta a la tirolesa y deslízate por el aire, sintiendo la velocidad y la libertad.
- **Carreras de Zipline:** Compite contra otros participantes en emocionantes carreras de zipline bike.
- **Técnicas de Ciclismo Aéreo:** Aprende y practica técnicas avanzadas de ciclismo mientras te desplazas por la tirolesa.

**Consejos:**
- Asegúrate de que tu bicicleta esté bien sujeta antes de comenzar.
- Usa equipo de protección adecuado proporcionado por el parque.
- Mantén la concentración durante todo el recorrido para garantizar una experiencia segura.
""",
    "CANOPY": """
**Descripción General:**
El Canopy te ofrece una emocionante travesía por las copas de los árboles, combinando velocidad y vistas panorámicas. Es perfecto para los amantes de la naturaleza y la aventura.

**Actividades:**
- **Tirolesa de Alta Velocidad:** Deslízate a través del canopy a velocidades emocionantes, disfrutando de la vista desde las alturas.
- **Exploración de Senderos Elevados:** Camina por senderos suspendidos entre los árboles, explorando la biodiversidad del área.
- **Fotografía del Ecosistema:** Captura imágenes de la flora y fauna desde perspectivas únicas y elevadas.

**Consejos:**
- Sigue las instrucciones de los guías para una experiencia segura.
- Mantén un ritmo constante durante el deslizamiento para maximizar la seguridad y la diversión.
- Disfruta de las vistas y la tranquilidad del entorno natural mientras te desplazas por el canopy.
"""
  };
  int _currentIndex = 0;

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _showGallery(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black54,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: EdgeInsets.all(16),
            height: 350, // Aumentado para acomodar más imágenes
            width: MediaQuery.of(context).size.width * 0.8, // Ancho adaptativo
            child: Column(
              children: [
                Text(
                  'Galería',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: PageView.builder(
                    itemCount:
                        _galleryImages[_titles[_currentIndex]]?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        _galleryImages[_titles[_currentIndex]]![index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding:
                        EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    'Cerrar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPrices(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView( // Permite el desplazamiento si es necesario
            child: Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width * 0.8, // Ancho adaptativo
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ajusta la altura al contenido
                children: [
                  Text(
                    'Precios',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  // Paquete Aventura
                  Card(
                    color: Colors.grey[800],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Text(
                            'Paquete Aventura - S/ 50',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellowAccent),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Incluye: Acceso al ${_titles[_currentIndex]}, equipo de seguridad, guía profesional y certificado de participación.',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Paquete Premium
                  Card(
                    color: Colors.grey[800],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Text(
                            'Paquete Premium - S/ 80',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 252, 227, 38)),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Incluye: Acceso ilimitado a ${_titles[_currentIndex]}, equipo completo, fotos de recuerdo profesionales, transporte dentro del parque y acceso a áreas exclusivas.',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      'Cerrar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Función para mostrar el modal de más información
  void _showMoreInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85, // Ancho adaptativo
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _titles[_currentIndex], // Título de la atracción
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    _attractionInfo[_titles[_currentIndex]] ??
                        "Información no disponible.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      'Cerrar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: _backgroundImages.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              // Fondo de la imagen de la atracción
              Positioned.fill(
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                  child: Image.asset(
                    _backgroundImages[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Contenido superpuesto
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Text(
                      'YUNGA',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  Text(
                    'PARQUE FERIAL',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFE135),
                      letterSpacing: 2,
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios,
                            color: Colors.white, size: 48),
                        onPressed: () {
                          if (_currentIndex > 0) _goToPage(_currentIndex - 1);
                        },
                      ),
                      Column(
                        children: [
                          Text(
                            _titles[index].split(" ")[0],
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          if (_titles[index].contains(" "))
                            Text(
                              _titles[index].split(" ")[1],
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios,
                            color: Colors.white, size: 48),
                        onPressed: () {
                          if (_currentIndex < _backgroundImages.length - 1)
                            _goToPage(_currentIndex + 1);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Atrévete a cruzar el ${_titles[index].toLowerCase()}.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            _showMoreInfo(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            textStyle: TextStyle(fontSize: 18),
                          ),
                          child: Text(
                            'MÁS INFORMACIÓN',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Botones de "Precios" y "Galería"
              Positioned(
                left: 10,
                top: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.attach_money,
                          color: Colors.white, size: 48),
                      onPressed: () => _showPrices(context),
                    ),
                    Text(
                      'Precios',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 10,
                top: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.photo, color: Colors.white, size: 48),
                      onPressed: () => _showGallery(context),
                    ),
                    Text(
                      'Galería',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
