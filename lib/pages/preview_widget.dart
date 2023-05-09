import 'package:aplikasi_pendeteksi_penyakit_tanaman/helpers.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_pendeteksi_penyakit_tanaman/components/primary_button.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'dart:ui';

class PreviewWidget extends StatefulWidget {
  final File? image;

  const PreviewWidget(this.image, {super.key});

  @override
  _PreviewWidget createState() => _PreviewWidget();
}

class _PreviewWidget extends State<PreviewWidget> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidget = [
      Positioned(
        bottom: 175,
        top: 0,
        right: 0,
        left: 0,
        child: Image.file(
          widget.image!,
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
              children: [
                PrimaryButton(
                  'Unggah Gambar',
                  onTap: () => setState(() {
                    _loading = true;
                  }),
                ),
                PrimaryButton(
                  'Ambil Ulang',
                  onTap: () => Helpers().getImage(context),
                ),
              ],
            ),
          ),
        ),
      ),
    ];

    if (_loading) {
      listWidget.addAll([
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            height: 160,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: const [
                  CupertinoActivityIndicator(
                    color: Color(0xFF116531),
                    radius: 40,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Sedang Diproses',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 16,
                      color: Color(0xFF116531),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]);
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: listWidget,
        ),
      ),
    );
  }
}
