import 'package:flutter/material.dart';
import 'login.dart'; // Asegúrate de tener este archivo creado e importado

class RecuperarPasswordScreen extends StatefulWidget {
  @override
  _RecuperarPasswordScreenState createState() =>
      _RecuperarPasswordScreenState();
}

class _RecuperarPasswordScreenState extends State<RecuperarPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String _newPassword = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBE4CF), // Fondo personalizado
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
                    'RECUPERAR CONTRASEÑA',
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
                      'Ingrese su nueva contraseña',
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su nueva contraseña';
                        }
                        if (value.length < 6) {
                          return 'La contraseña debe tener al menos 6 caracteres';
                        }
                        return null;
                      },
                      (value) {
                        _newPassword = value!;
                      },
                      isPassword: true,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      'Confirme su nueva contraseña',
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor confirme su nueva contraseña';
                        }
                        return null;
                      },
                      (value) {
                        _confirmPassword = value!;
                      },
                      isPassword: true,
                    ),
                    SizedBox(height: 30),
                    // Botón de cambiar contraseña
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xFF3AAF7F), // Verde personalizado
                        padding:
                            EdgeInsets.symmetric(horizontal: 80, vertical: 16),
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
                        'CAMBIAR CONTRASEÑA',
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
                        backgroundColor:
                            Color(0xFF406E5B), // Verde oscuro personalizado
                        padding:
                            EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        // Navegar de vuelta al archivo main.dart o login.dart
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoginScreen()), // Redirige al login
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
      FormFieldSetter<String>? onSaved,
      {bool isPassword = false}) {
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

  // Mostrar un cuadro de diálogo de éxito con fondo translúcido
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Evita que se cierre al tocar fuera del diálogo
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Bordes redondeados
            ),
            backgroundColor: Colors.white.withOpacity(0.8), // Fondo translúcido
            title: Column(
              children: [
                Icon(Icons.check_circle,
                    color: Color(0xFF3AAF7F), size: 60), // Icono de éxito
                SizedBox(height: 16),
                Text(
                  '¡Contraseña cambiada!',
                  style: TextStyle(
                    color: Color(0xFF406E5B),
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            content: Text(
              'Su contraseña ha sido cambiada con éxito.',
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
                    // Navegar al login después de cambiar la contraseña
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
