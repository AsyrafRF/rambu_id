import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const RambuIDApp());
}

class RambuIDApp extends StatelessWidget {
  const RambuIDApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RambuID',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red, useMaterial3: true),
      home: const HomePage(),
    );
  }
}
