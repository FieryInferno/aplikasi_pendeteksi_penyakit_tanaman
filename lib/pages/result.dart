import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/components/back_button.dart';
import '/components/title_widget.dart';
import '/components/text_widget.dart';
import '/components/rekomendasi_produk_item.dart';

class Result extends StatefulWidget {
  final Map<String, String>? riwayat;
  final File? imageFile;
  final String? imagePath;
  final String namaPenyakit;
  final String timestamp;
  final String description;
  final String solution;
  final List<dynamic> rekomendasiProduk;

  const Result({
    super.key,
    this.riwayat,
    this.imageFile,
    this.imagePath,
    required this.namaPenyakit,
    required this.timestamp,
    required this.description,
    required this.solution,
    required this.rekomendasiProduk,
  });

  @override
  // ignore: library_private_types_in_public_api
  _Result createState() => _Result();
}

class _Result extends State<Result> {
  bool _displayFull = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: screenHeight / 2 - 60,
              top: 0,
              right: 0,
              left: 0,
              child: widget.imageFile != null
                  ? Image.file(widget.imageFile!, fit: BoxFit.cover)
                  : Image.asset(widget.imagePath!, fit: BoxFit.cover),
            ),
            const Positioned(top: 10, left: 10, child: BackButtonWidget()),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              bottom: 0,
              right: 0,
              left: 0,
              top: _displayFull ? 80 : screenHeight / 2,
              child: GestureDetector(
                onTap: () => setState(() => _displayFull = !_displayFull),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 30,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleWidget(
                            title: (widget.namaPenyakit).toString(),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.schedule),
                              const SizedBox(width: 5),
                              TextWidget(DateFormat('dd MMMM yyyy, HH:mm')
                                  .format(DateTime.parse(widget.timestamp))),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextWidget(
                            widget.description,
                            size: 17.5,
                            align: TextAlign.justify,
                          ),
                          const SizedBox(height: 10),
                          const TextWidget(
                            'Cara Mengobati',
                            size: 20,
                            weight: FontWeight.bold,
                          ),
                          TextWidget(
                            widget.solution,
                            size: 17.5,
                            align: TextAlign.justify,
                          ),
                          const SizedBox(height: 10),
                          const TextWidget(
                            'Rekomendasi Produk',
                            size: 20,
                            weight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 300,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  RekomendasiProdukItem(
                                      widget.rekomendasiProduk[index]),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 5),
                              itemCount: widget.rekomendasiProduk.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
