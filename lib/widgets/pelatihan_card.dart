import 'package:flutter/material.dart';

class PelatihanCard extends StatelessWidget {
  final Map pelatihan;

  const PelatihanCard(this.pelatihan, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            'http://192.168.56.1/proyek2_mobile/portoline/upload/${pelatihan['foto']}',
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder:
                (context, error, stackTrace) => Icon(Icons.image_not_supported),
          ),
        ),
        title: Text(pelatihan['judul'] ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pelatihan['perusahaan'] ?? ''),
            const SizedBox(height: 4),
            Text(
              "Rp ${pelatihan['harga']}",
              style: TextStyle(color: Colors.green[800]),
            ),
          ],
        ),
        onTap: () {
          // Bisa diarahkan ke halaman detail
        },
      ),
    );
  }
}
