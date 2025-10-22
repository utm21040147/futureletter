<div align="center">

# 📬 FutureLetter: Carta al Futuro

<p>
  <a href="#-descripción">Descripción</a> •
  <a href="#-características-principales">Características</a> •
  <a href="#-tecnologías">Tecnologías</a> •
  <a href="#-instalación">Instalación</a> •
  <a href="#-autor">Autor</a>
</p>

![Flutter Shield](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart Shield](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

</div>

---

## 📖 Descripción

**FutureLetter** es una aplicación móvil desarrollada con Flutter que permite a los usuarios escribir y guardar mensajes para su "yo" del futuro. La aplicación se enfoca en una experiencia segura y personal, almacenando todas las cartas de forma local en el dispositivo.

## ✨ Características Principales

-   **Autenticación Segura**:
    -   **Credenciales**: Inicio de sesión tradicional con usuario/contraseña.
    -   **Biometría**: Acceso rápido y seguro mediante huella digital o reconocimiento facial (`local_auth`).
-   **Almacenamiento Persistente**:
    -   Las cartas se guardan en una base de datos **SQLite** local, garantizando que los datos persisten incluso si la app se cierra.
-   **Interfaz Intuitiva**:
    -   Un formulario claro y sencillo para escribir la carta, con un límite de 500 caracteres.
    -   Selección de la "fecha de entrega" conceptual (6 meses, 1 año, 2 años).
-   **Widget Multiplataforma**:
    -   Un indicador dinámico en el `AppBar` que muestra la plataforma actual (Android, Windows, Web), demostrando la adaptabilidad del código.

## 🛠️ Tecnologías

| Tecnología | Propósito                               |
| :----------- | :---------------------------------------- |
| **Flutter** | Framework para el desarrollo multiplataforma. |
| **Dart** | Lenguaje de programación.                 |
| **SQLite** | Sistema de base de datos local.           |
| `sqflite`    | Plugin para la integración con SQLite.    |
| `local_auth` | Plugin para la autenticación biométrica.  |

## 🚀 Instalación

Sigue estos pasos para configurar y ejecutar el proyecto en tu entorno local.

### 1. Prerrequisitos

-   Tener [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado.
-   Un emulador de Android/iOS o un dispositivo físico.

### 2. Configuración del Proyecto

```bash
# 1. Clona el repositorio
git clone [https://github.com/tu-usuario/futureletter.git](https://github.com/tu-usuario/futureletter.git)

# 2. Navega al directorio del proyecto
cd futureletter

# 3. Instala las dependencias
flutter pub get
