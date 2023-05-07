import 'package:flutter/material.dart';
import 'package:aplikasi_pendeteksi_penyakit_tanaman/components/riwayat_item.dart';
import 'package:aplikasi_pendeteksi_penyakit_tanaman/components/title_widget.dart';
import 'package:aplikasi_pendeteksi_penyakit_tanaman/data/riwayat.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final List<Map<String, String>> _list = Riwayat().list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                separatorBuilder: (context, index) => const SizedBox(width: 5),
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
            SizedBox(
              height: 140,
              child: ListView(
                children: [
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Image.asset('assets/images/penyakit-1.png'),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 80,
                                  child: Text(
                                    'What is lorem ipsum?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Quicksand',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('4 mei'),
                                    Text('M. Bagas Setia'),
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
            ),
          ],
        ),
      ),
    );
  }
}
