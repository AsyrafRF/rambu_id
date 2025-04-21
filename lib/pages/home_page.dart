import 'package:flutter/material.dart';
import 'package:rambu_id/pages/edukasi/edukasi_page.dart' show EdukasiPage;
import '../widgets/home_menu_button.dart';
import 'detection_page.dart';
import 'edukasi_page.dart';
import 'map_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RambuID"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            HomeMenuButton(
              icon: Icons.camera_alt,
              label: "Live Detection",
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DetectionPage()),
                  ),
            ),
            HomeMenuButton(
              icon: Icons.upload_file,
              label: "Upload Gambar/Video",
              onTap: () {
                // Implementasi upload
              },
            ),
            HomeMenuButton(
              icon: Icons.school,
              label: "Mode Edukasi",
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EdukasiPage()),
                  ),
            ),
            HomeMenuButton(
              icon: Icons.map,
              label: "Peta Interaktif",
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MapPage()),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
