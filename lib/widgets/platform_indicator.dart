import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PlatformIndicator extends StatelessWidget {
  const PlatformIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    // Inicializamos las variables del ícono y el texto
    IconData platformIcon;
    String platformText;

    // Usamos kIsWeb para detectar si la app corre en un navegador
    if (kIsWeb) {
      platformIcon = Icons.web;
      platformText = 'Web (Navegador)';
    }
    // Si no es web, usamos dart:io para las demás plataformas
    else if (Platform.isAndroid) {
      platformIcon = Icons.android;
      platformText = 'Android';
    } else if (Platform.isWindows) {
      platformIcon = Icons.desktop_windows;
      platformText = 'Windows';
    }
    // Puedes agregar más, como iOS, Linux, etc.
    // else if (Platform.isIOS) { ... }
    else {
      // Un valor por defecto si no es ninguna de las anteriores
      platformIcon = Icons.device_unknown;
      platformText = 'Desconocido';
    }

    // Devolvemos un Row con el ícono y el texto, bien formateado
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(platformIcon, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Text(
            platformText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
