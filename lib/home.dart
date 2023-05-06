import 'package:flutter/material.dart';
import 'package:aplikasi_pendeteksi_penyakit_tanaman/components/riwayat_item.dart';
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
                const Text(
                  'Riwayat',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600,
                  ),
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
            // Expanded(
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //       Column(
            //         children: [
            //           SizedBox(
            //             width: 140,
            //             child: Expanded(
            //               child: Image.asset(
            //                 'assets/images/penyakit-1.png',
            //                 fit: BoxFit.cover,
            //               ),
            //             ),
            //           ),
            //           Container(
            //             decoration: const BoxDecoration(
            //               color: Colors.white,
            //               borderRadius: BorderRadius.only(
            //                 bottomLeft: Radius.circular(10),
            //                 bottomRight: Radius.circular(10),
            //               ),
            //             ),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Container(
            //                   decoration: const BoxDecoration(
            //                     image: DecorationImage(
            //                       image: AssetImage(
            //                           'assets/images/penyakit-1.png'),
            //                       fit: BoxFit.cover,
            //                     ),
            //                   ),
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(10),
            //                   child: Column(
            //                     children: const [
            //                       Text(
            //                         'Penyakit 1',
            //                         style: TextStyle(
            //                           fontFamily: 'Quicksand',
            //                           fontWeight: FontWeight.bold,
            //                         ),
            //                       ),
            //                       Text('4 Maret 2023 09:00'),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return RiwayatItem(riwayat: _list[index]);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 5,
                  );
                },
                itemCount: _list.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
