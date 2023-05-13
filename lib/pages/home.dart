import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '/helpers.dart';
import '/pages/riwayat_list.dart';
import '/pages/result.dart';
import '/pages/blog_detail.dart';
import '/components/riwayat_item.dart';
import '/components/title_widget.dart';
import '/components/blog_item.dart';
import '/components/text_widget.dart';
import '/components/click_widget.dart';
import '/components/menu.dart';
import '/data/riwayat.dart';
import '/data/blogs.dart';

class Home extends StatelessWidget {
  final List<Map<String, String>> _list = Riwayat().list;
  final List<Map<String, String>> _blogs = Blogs().list;
  final picker = ImagePicker();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: const Color(0xFFE7F0EB),
              padding: const EdgeInsets.symmetric(
                vertical: 20,
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
                      const TextWidget(
                        'Daun Daunan',
                        weight: FontWeight.bold,
                        size: 24,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 125,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => Helpers().getImage(context),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.photo_camera),
                                          SizedBox(width: 5),
                                          Text('Ambil Foto'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => Helpers().getImageByGaleri(),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.image),
                                          SizedBox(width: 5),
                                          Text('Galeri'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Card(
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
                  ),
                  const SizedBox(height: 10),
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RiwayatList()));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => ClickWidget(
                        destination: Result(riwayat: _list[index]),
                        child: RiwayatItem(riwayat: _list[index]),
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 5),
                      itemCount: _list.length,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const TitleWidget(title: 'Blog'),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => ClickWidget(
                        destination: BlogDetail(_blogs[index]),
                        child: BlogItem(blog: _blogs[index]),
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 5),
                      itemCount: _blogs.length,
                    ),
                  ),
                ],
              ),
            ),
            const Menu(),
          ],
        ),
      ),
    );
  }
}
