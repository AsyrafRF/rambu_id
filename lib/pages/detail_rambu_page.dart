// detail_page.dart
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String rambu;

  const DetailPage({super.key, required this.rambu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(rambu), backgroundColor: Colors.blueAccent),
      body: Center(
        child: Text(
          "Detail dari $rambu",
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}