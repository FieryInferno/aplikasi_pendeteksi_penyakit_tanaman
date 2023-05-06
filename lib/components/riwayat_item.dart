import 'package:flutter/material.dart';

class RiwayatItem extends StatelessWidget {
  final Map<String, String> riwayat;

  const RiwayatItem({super.key, required this.riwayat});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 140,
          child: Image.asset(
            'assets/images/${riwayat['image']}',
            fit: BoxFit.cover,
            width: 140,
            height: 140,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      riwayat['nama_penyakit']!,
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(riwayat['tanggal']!),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
