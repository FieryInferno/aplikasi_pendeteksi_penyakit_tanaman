import 'package:flutter/material.dart';
import '/data/rekomendasi_produk.dart';
import '/components/back_button.dart';
import '/components/title_widget.dart';
import '/components/text_widget.dart';
import '/components/rekomendasi_produk_item.dart';

class Result extends StatefulWidget {
  final Map<String, String>? riwayat;

  const Result({super.key, this.riwayat});

  @override
  _Result createState() => _Result();
}

class _Result extends State<Result> {
  final List<Map<String, dynamic>> _rekomendasiProduk =
      RekomendasiProduk().list;
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
              child: Image.asset(
                  'assets/images/${widget.riwayat!['image'] ?? 'blog-1.jpg'}',
                  fit: BoxFit.cover),
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
                            title: widget.riwayat!['nama_penyakit'] ??
                                'Nama Penyakit',
                          ),
                          Row(
                            children: [
                              const Icon(Icons.schedule),
                              const SizedBox(width: 5),
                              TextWidget(widget.riwayat!['tanggal'] ??
                                  '4 Mei 2023, 09:00'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const TextWidget(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec condimentum pulvinar aliquet. Mauris molestie, sapien vitae commodo sollicitudin, nibh nisi gravida eros, mollis porta massa velit sed purus. Nulla in nibh ut dui rutrum cursus. Donec viverra sed nibh vel mollis. Vivamus varius luctus metus, vel ultricies augue. Ut sit amet eros tempus, sagittis nibh vitae, commodo tortor. Donec sollicitudin mi in porttitor venenatis. Curabitur at massa at elit efficitur pulvinar. Etiam accumsan augue non nunc convallis commodo. Nam aliquet consequat blandit. Sed et quam ut felis efficitur gravida. Maecenas scelerisque quis nisi et ultrices. Nullam blandit sit amet purus iaculis luctus. Donec quis velit consectetur, pulvinar orci at, tincidunt odio.',
                            size: 17.5,
                            align: TextAlign.justify,
                          ),
                          const SizedBox(height: 10),
                          const TextWidget(
                            'Cara Mengobati',
                            size: 20,
                            weight: FontWeight.bold,
                          ),
                          const TextWidget(
                            'Fusce ac diam justo. Donec nec magna nunc. Suspendisse vulputate erat eu magna mattis efficitur. Aenean odio orci, feugiat quis gravida non, rutrum sit amet tortor. Praesent eu ullamcorper libero, nec cursus leo. Donec quis neque pretium, convallis mi sed, mollis mauris. Duis sit amet neque nec mauris imperdiet consectetur in quis massa. Aenean nec placerat justo, quis pretium turpis. Pellentesque nec sem id leo mattis convallis. Curabitur ac volutpat neque, a tincidunt libero. Nunc eleifend felis et enim scelerisque hendrerit. Donec gravida metus non nisi pellentesque pharetra. Duis vel pulvinar erat. Integer consequat diam sit amet diam porttitor posuere. Sed sit amet tortor quis quam vestibulum scelerisque quis eget magna.',
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
                            height: 210,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  RekomendasiProdukItem(
                                      _rekomendasiProduk[index]),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 5),
                              itemCount: _rekomendasiProduk.length,
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
