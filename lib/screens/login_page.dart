import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart'; // <-- NUEVO: Importar el paquete
import 'write_letter_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // <-- NUEVO: Instancia de LocalAuthentication
  final LocalAuthentication _auth = LocalAuthentication();
  bool _isAuthenticating = false;

  // Credenciales harcodeadas
  final String _correctUsername = 'user';
  final String _correctPassword = 'password';

  // --- Login con Usuario/Contraseña (Sin cambios) ---
  void _login() {
    if (_formKey.currentState!.validate()) {
      if (_usernameController.text == _correctUsername &&
          _passwordController.text == _correctPassword) {
        _navigateToHome();
      } else {
        _showError('Usuario o contraseña incorrectos.');
      }
    }
  }

  // --- NUEVO: Lógica de Autenticación Biométrica ---
  Future<void> _authenticateWithBiometrics() async {
    if (_isAuthenticating) return;

    setState(() {
      _isAuthenticating = true;
    });

    try {
      // 1. Revisar si el dispositivo soporta biométricos
      bool canAuthenticate =
          await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

      if (!canAuthenticate) {
        _showError('Biométricos no disponibles en este dispositivo.');
        setState(() => _isAuthenticating = false);
        return;
      }

      // 2. Intentar autenticar
      bool authenticated = await _auth.authenticate(
        localizedReason: 'Inicia sesión con tu huella o rostro',
        options: const AuthenticationOptions(
          biometricOnly: true, // Solo permitir huella/rostro, no PIN
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );

      // 3. Navegar si es exitoso
      if (authenticated) {
        _navigateToHome();
      } else {
        _showError('Autenticación fallida.');
      }
    } catch (e) {
      _showError('Error de autenticación: $e');
    } finally {
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  // --- NUEVO: Helpers para mostrar error y navegar ---
  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  void _navigateToHome() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WriteLetterPage()),
    );
  }
  // --- Fin de nuevos helpers ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade300, Colors.indigo.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.lock_outline,
                        size: 60,
                        color: Colors.indigo.shade400,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Iniciar Sesión',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo.shade800,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Usa user / password para entrar.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Usuario',
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu usuario';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon: const Icon(Icons.lock_person_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu contraseña';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo.shade500,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _login,
                          child: const Text(
                            'Entrar',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),

                      // --- NUEVO: Botón de Biométricos ---
                      const SizedBox(height: 20),
                      Text('O', style: TextStyle(color: Colors.grey.shade600)),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          icon: Icon(
                            Icons.fingerprint,
                            color: Colors.indigo.shade500,
                          ),
                          label: Text(
                            _isAuthenticating
                                ? 'Autenticando...'
                                : 'Iniciar con huella',
                            style: TextStyle(
                              color: Colors.indigo.shade500,
                              fontSize: 16,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: Colors.indigo.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _isAuthenticating
                              ? null
                              : _authenticateWithBiometrics,
                        ),
                      ),
                      // --- Fin del nuevo botón ---
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
