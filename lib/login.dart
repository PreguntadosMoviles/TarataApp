import 'package:flutter/material.dart';
import 'registro.dart';
import 'dashboard.dart';
import 'recuperarPassword.dart'; // Importa el archivo recuperarPassword.dart
import 'main.dart'; // Importa el archivo main.dart

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBE4CF), // Fondo cambiado a FBE4CF
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
                    'INICIA SESIÓN',
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
            SizedBox(height: 30),
            // Formulario
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      'Ingresar correo electrónico',
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su correo electrónico';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Por favor ingrese un correo válido';
                        }
                        return null;
                      },
                      (value) {
                        _email = value!;
                      },
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      'Ingresar Password',
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su contraseña';
                        }
                        return null;
                      },
                      (value) {
                        _password = value!;
                      },
                      isPassword: true,
                    ),
                    SizedBox(height: 30),
                    // Botón de iniciar sesión
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3AAF7F), // Verde personalizado
                        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Navegar al dashboard
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => DashboardScreen()),
                          );
                        }
                      },
                      child: Text(
                        'INICIAR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Botón de volver
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF406E5B), // Verde oscuro personalizado
                        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        // Navegar de vuelta al archivo main.dart
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyApp()), // Redirige a la pantalla principal
                        );
                      },
                      child: Text(
                        'VOLVER',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Enlace para registrarse
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿No tienes una cuenta?',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Redirigir a la pantalla de registro
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistroScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Registrate',
                            style: TextStyle(
                              color: Color(0xFF406E5B), // Verde personalizado 406E5B
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Enlace de olvido de contraseña
                    TextButton(
                      onPressed: () {
                        // Redirigir a la pantalla de recuperación de contraseña
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecuperarPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        '¿Olvidó su contraseña?',
                        style: TextStyle(
                          color: Color(0xFF406E5B), // Verde personalizado 406E5B
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
}
