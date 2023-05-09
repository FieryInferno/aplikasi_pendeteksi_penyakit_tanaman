import 'package:flutter/material.dart';
import 'package:aplikasi_pendeteksi_penyakit_tanaman/components/primary_button.dart';
import 'dart:io';

class PreviewWidget extends StatelessWidget {
  final File? image;

  const PreviewWidget(this.image, {super.key});

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
              child: Image.file(
                image!,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF116531),
                ),
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
