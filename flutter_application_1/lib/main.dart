import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //haciendo una prueba con el repository
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Fotos',
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
      return Image.file(File(_imageFile!.path), height: 300);
    } else if (_pickImageError != null) {
      return Text(
        "Error de recuperación de imagen: $_pickImageError",
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      );
    } else {
      return const Text(
        'No hay imagen',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.blue.shade700;
    final titleStyle = const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    final subtitleStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bienvenido al sistema de fotos\nDe David López',
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'del Aventura Park',
                  style: subtitleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Presione el botón para hacer una foto',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Aquí mostramos la imagen o el texto según el estado.
                _visualizarImagen(),
                const SizedBox(height: 40),
                // Botón para abrir cámara
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 30,
                    ),
                  ),
                  onPressed: () => _onImageButtonPressed(ImageSource.camera),
                  child: const Text(
                    'Abrir Cámara',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                // Botón adicional para abrir galería
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 30,
                    ),
                  ),
                  onPressed: () => _onImageButtonPressed(ImageSource.gallery),
                  child: const Text(
                    'Abrir Galería',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
