import 'package:flutter/material.dart';
import 'package:aplikasi_pendeteksi_penyakit_tanaman/components/riwayat_item.dart';
import 'package:aplikasi_pendeteksi_penyakit_tanaman/components/title_widget.dart';
import 'package:aplikasi_pendeteksi_penyakit_tanaman/components/blog_item.dart';
import 'package:aplikasi_pendeteksi_penyakit_tanaman/data/riwayat.dart';
import 'package:aplikasi_pendeteksi_penyakit_tanaman/data/blogs.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final List<Map<String, String>> _list = Riwayat().list;
  final List<Map<String, String>> _blogs = Blogs().list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                    Image.asset(
                      'assets/images/logo.png',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Daun Daunan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  color: const Color(0xFFCCDDD3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 25,
                    ),
                    child: Row(
                      children: [
                        const Flexible(
                          child: Text(
                            'Cari tahu penyakit tanaman kamu disini',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                        ),
                        Image.asset('assets/images/scan.png'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TitleWidget(
                      title: 'Riwayat',
                    ),
                    TextButton(
                      child: const Text(
                        'Lihat Semua',
                        style: TextStyle(
                          color: Color(0xFF116531),
                          fontFamily: 'Quicksand',
                        ),
                      ),
                      onPressed: () => print('Lihat semua'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        RiwayatItem(riwayat: _list[index]),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 5),
                    itemCount: _list.length,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const TitleWidget(title: 'Blog'),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => BlogItem(
                      blog: _blogs[index],
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 5),
                    itemCount: _blogs.length,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              height: 62,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Warna bayangan
                    spreadRadius: 2, // Penyebaran bayangan
                    blurRadius: 5, // Ukuran bayangan
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(
                    Icons.home,
                    color: Color(0xFF116531),
                  ),
                  Icon(
                    Icons.description,
                    color: Colors.grey,
                  ),
                  Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
