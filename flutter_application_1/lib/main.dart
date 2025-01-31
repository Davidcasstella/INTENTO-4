import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SISTEMA DE FOTOS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const FotoPage(),
    );
  }
}

class FotoPage extends StatefulWidget {
  const FotoPage({super.key});

  @override
  State<FotoPage> createState() => _FotoPageState();
}

class _FotoPageState extends State<FotoPage> {
  XFile? _imageFile;
  String? _pickImageError;
  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageButtonPressed(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
          _pickImageError = null;
        });
      }
    } catch (e) {
      setState(() {
        _pickImageError = e.toString();
      });
    }
  }

  Widget _visualizarImagen() {
    if (_imageFile != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.file(File(_imageFile!.path), height: 300, fit: BoxFit.cover),
      );
    } else if (_pickImageError != null) {
      return Text(
        "ERROR DE RECUPERACIÓN DE IMAGEN: $_pickImageError",
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Colores neon dark mode
    final Color fondoPrincipal = const Color.fromARGB(255, 23, 139, 178); // Azul oscuro
    final Color verdeNeon = const Color(0xFF1EFFA0); // Verde neón
    final Color blanco = const Color(0xFFFFFFFF); // Blanco
    final Color negro = const Color(0xFF000000); // Negro
    final Color grisClaro = const Color(0xFFB0B0B0); // Gris claro

    final titleStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: blanco, // Texto en blanco
      shadows: [
        Shadow(
          color: verdeNeon.withOpacity(0.5),
          blurRadius: 10,
          offset: const Offset(0, 0),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [verdeNeon, verdeNeon.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            'SISTEMA DE FOTOS',
            style: TextStyle(
              color: negro, // Texto en negro
              fontSize: 24,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: verdeNeon.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: fondoPrincipal,
        elevation: 10,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [fondoPrincipal, const Color(0xFF1A1D4D)], // Degradado azul oscuro
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'SISTEMA DE FOTOS AVENTURA PARK',
                    style: titleStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Presione el botón para hacer una foto',
                    style: TextStyle(color: grisClaro, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  _visualizarImagen(),
                  const SizedBox(height: 40),
                  ElevatedButton.icon(
                    icon: Icon(Icons.camera_alt, color: negro), // Icono en negro
                    label: Text(
                      'Abrir Cámara',
                      style: TextStyle(
                        color: negro, // Texto en negro
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: verdeNeon,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 10,
                      shadowColor: verdeNeon.withOpacity(0.5),
                    ),
                    onPressed: () => _onImageButtonPressed(ImageSource.camera),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: Icon(Icons.photo_library, color: negro), // Icono en negro
                    label: Text(
                      'Abrir Galería',
                      style: TextStyle(
                        color: negro, // Texto en negro
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: verdeNeon,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 10,
                      shadowColor: verdeNeon.withOpacity(0.5),
                    ),
                    onPressed: () => _onImageButtonPressed(ImageSource.gallery),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
