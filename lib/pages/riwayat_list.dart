import 'package:aplikasi_pendeteksi_penyakit_tanaman/components/title_widget.dart';
import 'package:flutter/material.dart';
import '/components/text_widget.dart';

class RiwayatList extends StatelessWidget {
  const RiwayatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFE7F0EB),
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.keyboard_arrow_left,
                      size: 40,
                      color: Color(0xFF116531),
                    ),
                  ),
                  const TitleWidget(title: 'Riwayat')
                ],
              ),
              const SizedBox(height: 10),
              ListView(
                shrinkWrap: true,
                children: [
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Image.asset(
                                'assets/images/penyakit-1.png',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 80,
                                  child: TextWidget(
                                    'Penyakit 1',
                                    weight: FontWeight.bold,
                                    size: 15,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('{blog[date]}'),
                                    Text('{blog[author]}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
