import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/components/riwayat_item.dart';
import '/data/riwayat.dart';
import '/helpers.dart';
import '/pages/riwayat_list.dart';
import '/pages/blog_detail.dart';
import '/components/title_widget.dart';
import '/components/blog_item.dart';
import '/components/text_widget.dart';
import '/components/click_widget.dart';
import '/components/page_wrap.dart';
import '/data/blogs.dart';
import 'result.dart';

class Home extends StatelessWidget {
  final List<Map<String, String>> _blogs = Blogs().list;
  final List<Map<String, String>> _list = Riwayat().list;
  final picker = ImagePicker();

  Home({super.key});

  Future<Widget> getRiwayat() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString('token') != null
        ? ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => ClickWidget(
              destination: Result(riwayat: _list[index]),
              child: RiwayatItem(riwayat: _list[index]),
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 5),
            itemCount: _list.length,
          )
        : Column(
            children: [
              Image.asset('assets/images/riwayat.png'),
              const TextWidget(
                'Masuk untuk menyimpan riwayat penyakit',
                size: 25,
                align: TextAlign.center,
                color: Color(0xFF116531),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      'Daun Daunan',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Helpers helpers = Helpers();
              helpers.showModalImage(context);
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
                onPressed: () => Helpers().redirectPage(context, RiwayatList()),
              ),
            ],
          ),
          SizedBox(
            height: 200,
            child: Center(
              child: FutureBuilder(
                future: getRiwayat(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!;
                  } else {
                    return Column(
                      children: [
                        Image.asset('assets/images/riwayat.png'),
                        const TextWidget(
                          'Masuk untuk menyimpan riwayat penyakit',
                          size: 25,
                          align: TextAlign.center,
                          color: Color(0xFF116531),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          const TitleWidget(title: 'Blog'),
          LimitedBox(
            maxHeight: 270,
            child: ListView.separated(
              itemBuilder: (context, index) => ClickWidget(
                destination: BlogDetail(_blogs[index]),
                child: BlogItem(blog: _blogs[index]),
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemCount: _blogs.length,
            ),
          ),
        ],
      ),
    );
  }
}
