import 'package:flutter/material.dart';
import 'package:aplikasi_pendeteksi_penyakit_tanaman/components/primary_button.dart';

class PreviewWidget extends StatelessWidget {
  const PreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 175,
              top: 0,
              right: 0,
              left: 0,
              child: Image.asset(
                'assets/images/blog-1.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 200,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      PrimaryButton('Unggah Gambar'),
                      PrimaryButton('Ambil Ulang'),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
