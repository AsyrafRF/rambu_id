import 'package:flutter/material.dart';
import 'package:rambu_id/pages/detail_rambu_page.dart';

class KategoriDetailPage extends StatelessWidget {
  final String kategori;

  const KategoriDetailPage({super.key, required this.kategori});

  @override
  Widget build(BuildContext context) {
    // Dummy data untuk simulasi rambu
    final rambuList = List.generate(10, (index) => '$kategori #$index');

    return Scaffold(
      appBar: AppBar(title: Text(kategori), backgroundColor: Colors.redAccent),
      body: ListView.builder(
        itemCount: rambuList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.traffic),
            title: Text(rambuList[index]),
            subtitle: const Text("Penjelasan singkat rambu..."),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(rambu: rambuList[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
