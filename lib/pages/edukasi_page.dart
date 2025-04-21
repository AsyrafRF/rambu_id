import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Edukasi RambuID: Aplikasi Pengenalan Rambu Jalan Raya Indonesia Berbasis IoT dan AI',
          ),
        ),
      ),
    );
  }
}
