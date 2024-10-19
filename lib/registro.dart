import 'package:flutter/material.dart';
import 'login.dart'; 

class RegistroScreen extends StatefulWidget {
  @override
  _RegistroScreenState createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nombreCompleto = '';
  String _email = '';
  String _contrasena = '';
  String _confirmarContrasena = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBE4CF), 
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Parte superior con la imagen y el título
            Container(
              height: 350, // Ajusta la altura para que la imagen sea más grande
              width: double.infinity, // Ocupa todo el ancho de la pantalla
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60, // Imagen del usuario más grande
                    backgroundImage: AssetImage('assets/images/user.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'REGISTRO',
                    style: TextStyle(
                      fontSize: 32, // Aumentar el tamaño del texto
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Espacio entre la imagen y el formulario
            SizedBox(height: 35),
            // Formulario
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      'Ingrese su nombre completo',
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su nombre completo';
                        }
                        return null;
                      },
                      (value) {
                        _nombreCompleto = value!;
                      },
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      'Ingrese su email',
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Por favor ingrese un email válido';
                        }
                        return null;
                      },
                      (value) {
                        _email = value!;
                      },
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      'Ingrese su password',
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su password';
                        }
                        if (value.length < 6) {
                          return 'La password debe tener al menos 6 caracteres';
                        }
                        return null;
                      },
                      (value) {
                        _contrasena = value!;
                      },
                      isPassword: true,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      'Confirme su password',
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor confirme su password';
                        }
                        return null; 
                      },
                      (value) {
                        _confirmarContrasena = value!;
                      },
                      isPassword: true,
                    ),
                    SizedBox(height: 30),
                    // Botón de registrar
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3AAF7F), 
                        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Mostrar el cuadro de diálogo de éxito
                          _showSuccessDialog(context);
                        }
                      },
                      child: Text(
                        'REGISTRAR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Enlace para iniciar sesión
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿Ya tiene una cuenta?',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Redirigir a la pantalla de login
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Iniciar sesión',
                            style: TextStyle(
                              color: Color(0xFF406E5B), // Verde personalizado 406E5B
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir los campos de texto con validación
  Widget _buildTextField(String hintText, FormFieldValidator<String>? validator,
      FormFieldSetter<String>? onSaved, {bool isPassword = false}) {
    return TextFormField(
      obscureText: isPassword,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }

  // Mostrar un cuadro de diálogo de éxito personalizado
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Bordes redondeados
          ),
          backgroundColor: Color(0xFFFBE4CF), // Fondo a tono con la app
          title: Column(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF3AAF7F), size: 60), // Icono de éxito
              SizedBox(height: 16),
              Text(
                '¡Registro exitoso!',
                style: TextStyle(
                  color: Color(0xFF406E5B),
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          content: Text(
            'Bienvenido/a a Tarata. Su cuenta ha sido creada con éxito.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3AAF7F),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Cerrar el cuadro de diálogo
                  // Navegar al login después del registro exitoso
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
