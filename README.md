Carta al Futuro (futureletter)

Aplicación móvil multiplataforma que permite a los usuarios escribir mensajes para sí mismos, guardarlos de forma segura en su dispositivo y especificar una fecha futura para su "entrega" conceptual.

📖 Descripción

El objetivo de este proyecto fue desarrollar una aplicación móvil utilizando Flutter. La aplicación, denominada "Carta al Futuro", permite a los usuarios escribir mensajes, guardarlos en una base de datos local y seguro, y tener una forma de recordar esos pensamientos en el futuro.

El desarrollo se centró en crear una experiencia de usuario limpia, segura y funcional, cumpliendo con todos los requisitos especificados.

✨ Características

Autenticación Dual:

Inicio de sesión tradicional con usuario y contraseña (credenciales harcodeadas: user / password).

Inicio de sesión biométrico mediante huella digital o reconocimiento facial.

Almacenamiento Local Seguro:

Toda la información se guarda de forma persistente en una base de datos local SQLite.

Composición de Cartas:

Editor de texto con un límite de 500 caracteres.

Selección de fecha de "entrega" (6 meses, 1 año, 2 años).

Indicador de Plataforma Dinámico:

Un widget en el AppBar que muestra en qué plataforma se está ejecutando la app (Android, Windows, Web, etc.).

🛠️ Tecnologías Utilizadas

Framework: Flutter 3.x

Lenguaje: Dart

Base de Datos: SQLite

Paquetes Clave:

sqflite: Para la gestión de la base de datos local.

path: Para la correcta localización de la ruta de la base de datos.

local_auth: Para la funcionalidad de autenticación biométrica.

🚀 Instalación y Puesta en Marcha

Para ejecutar este proyecto localmente, sigue estos pasos:

1. Prerrequisitos

Asegúrate de tener el Flutter SDK instalado en tu máquina.

2. Clonar el Repositorio

git clone [https://github.com/tu-usuario/futureletter.git](https://github.com/tu-usuario/futureletter.git)
cd futureletter


3. Instalar Dependencias

Ejecuta el siguiente comando en la raíz del proyecto para instalar todos los paquetes necesarios.

flutter pub get


4. Configuración Nativa (¡Importante!)

Para que la autenticación biométrica funcione, necesitas realizar las siguientes configuraciones:

Android:

Añade el permiso en android/app/src/main/AndroidManifest.xml (antes de la etiqueta <application>):

<uses-permission android:name="android.permission.USE_BIOMETRIC"/>


Cambia la clase base en android/app/src/main/kotlin/.../MainActivity.kt:

import io.flutter.embedding.android.FlutterFragmentActivity
class MainActivity: FlutterFragmentActivity() {}


iOS:

Añade la descripción de uso en ios/Runner/Info.plist:

<key>NSFaceIDUsageDescription</key>
<string>Necesitamos tu permiso para usar Face ID y autenticarte.</string>


5. Ejecutar la Aplicación

Conecta un dispositivo o inicia un emulador y ejecuta el siguiente comando:

flutter run


👤 Autor

Isaac Reyes

📜 Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo LICENSE para más detalles.
