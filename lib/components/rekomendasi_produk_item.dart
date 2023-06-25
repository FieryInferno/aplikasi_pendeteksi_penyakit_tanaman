import '../components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RekomendasiProdukItem extends StatelessWidget {
  final Map<String, dynamic> rekomendasiProduk;

  const RekomendasiProdukItem(this.rekomendasiProduk, {super.key});

  String formatRupiah(int angka) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID', // set locale ke Indonesia
      decimalDigits: 0, // jumlah digit desimal yang ditampilkan
      symbol: 'Rp', // simbol mata uang yang digunakan
    );

    return formatter.format(angka);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(bottom: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: SizedBox(
              child: Image.network(
                rekomendasiProduk['image'],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 221, 220, 220),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                    flex: 0,
                    child: TextWidget(
                      rekomendasiProduk['title'],
                      weight: FontWeight.bold,
                    ),
                  ),
                  Flexible(
                    child: TextWidget(
                      formatRupiah(
                        rekomendasiProduk['price'],
                      ),
                    ),
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
