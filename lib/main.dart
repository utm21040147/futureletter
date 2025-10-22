import 'package:flutter/material.dart';
import 'screens/login_page.dart'; // Importa la pantalla de login

void main() {
  // Asegura que los bindings de Flutter estén inicializados
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LetterToFutureApp()); // <-- Aquí defines LetterToFutureApp
}

class LetterToFutureApp extends StatelessWidget {
  const LetterToFutureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carta al Futuro',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      // Le decimos a la app que comience en la LoginPage
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
