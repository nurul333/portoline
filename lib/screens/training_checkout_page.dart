import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import 'jobseeker_dashboard.dart'; // pastikan file ini berisi class TrainingItem

class TrainingCheckoutPage extends StatelessWidget {
  final TrainingItem training;

  const TrainingCheckoutPage({super.key, required this.training});

  void _payNow(BuildContext context) async {
    final uri = Uri.parse(
      'http:/127.0.0.1:8000/api/create-snap',
    ); // ganti IP jika deploy
    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "gross_amount": training.price,
        "name": "John Doe",
        "email": "johndoe@mail.com",
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final snapToken = data['snap_token'];

      void launchMidtrans(String snapToken) async {
        final url = Uri.parse(
          "https://app.sandbox.midtrans.com/snap/v2/vtweb/$snapToken",
        );

        if (await canLaunchUrl(url)) {
          await launchUrl(
            url,
            mode:
                LaunchMode
                    .externalApplication, // untuk buka di browser atau app lain
          );
        } else {
          throw 'Could not launch $url';
        }
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal membuat Snap Token")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Beli Pelatihan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                training.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              training.title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Harga: ${training.price}',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _payNow(context),
              child: Text("Bayar Sekarang"),
            ),
          ],
        ),
      ),
    );
  }
}
