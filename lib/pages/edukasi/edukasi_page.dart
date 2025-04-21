import 'package:flutter/material.dart';
import 'kategori_detail_page.dart';

class EdukasiPage extends StatelessWidget {
  const EdukasiPage({super.key});

  final List<Map<String, dynamic>> kategoriRambu = const [
    {
      'label': 'Rambu Peringatan',
      'icon': Icons.warning,
      'color': Colors.orange,
    },
    {'label': 'Rambu Larangan', 'icon': Icons.block, 'color': Colors.red},
    {'label': 'Rambu Perintah', 'icon': Icons.directions, 'color': Colors.blue},
    {'label': 'Rambu Petunjuk', 'icon': Icons.info, 'color': Colors.green},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mode Edukasi"),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
        itemCount: kategoriRambu.length,
        itemBuilder: (context, index) {
          var item = kategoriRambu[index];
          return ListTile(
            leading: Icon(item['icon'], color: item['color']),
            title: Text(item['label']),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => KategoriDetailPage(kategori: item['label']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
