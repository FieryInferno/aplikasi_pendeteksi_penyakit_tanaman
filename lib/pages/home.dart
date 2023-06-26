import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './preview_widget.dart';
import './result.dart';
import '../helpers.dart';
import '../data/blogs.dart';
import '../data/riwayat.dart';
import '../pages/riwayat_list.dart';
import '../pages/blog_detail.dart';
import '../components/title_widget.dart';
import '../components/blog_item.dart';
import '../components/text_widget.dart';
import '../components/click_widget.dart';
import '../components/page_wrap.dart';
import '../components/riwayat_item.dart';

class Home extends StatelessWidget {
  final List<Map<String, String>> _blogs = Blogs().list;
  final List<Map<String, dynamic>> _list = Riwayat().list;
  final picker = ImagePicker();

  Home({super.key});

  Future<Widget> getRiwayat() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString('token') != null
        ? ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => ClickWidget(
              destination: Result(
                  namaPenyakit: _list[index]['nama_penyakit']!,
                  timestamp: '2023-06-25T10:26:39.760447+07:00',
                  description: _list[index]['description']!,
                  solution: _list[index]['solution']!,
                  rekomendasiProduk: const [
                    {
                      "id": 5,
                      "title": "Fungisida Mancozeb",
                      "description":
                          "Fungisida Mancozeb melawan berbagai jenis jamur patogen pada tanaman. Ini memberikan perlindungan terhadap penyakit seperti embun tepung dan hawar daun.",
                      "url": "",
                      "price": 40000,
                      "image":
                          "https://storage.googleapis.com/toko-dizital/product/images/Fungisida_Mancozeb.jpeg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=django-images-bucket%40toko-dizital.iam.gserviceaccount.com%2F20230625%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20230625T032639Z&X-Goog-Expires=86400&X-Goog-SignedHeaders=host&X-Goog-Signature=8f3e409fd5804fcc102f51bfc475ec4f90275f47ca8f2bd7e3a713806b0d29a00601bb76716dad0c2b8ba51dc666ac4c96fdc41a758a62b85cddcac1ba71ec2affd667bc32f995cfe28c0546730adb20363020995e102e61c605ad676568efdaa9ce58f6459d00bf5207849f5b972bd4a6bd2a0836cc48c981b200ebaef18ad6032ebbb6c9c578b83ff00fd724cb73b010f42ace4acd9d13a4fd1170e1a0789e68fe9b251409f911f3c0a511cf85acbe19c1d70652e81fb96105513ae92b49971339d3b9086c07d129a0fe23d4135b848702b40c7a351b74ed75f6d7d5d62e42d2ec9c6902bf8a77113a9536e1a1d0a0fa7269793d0aaf006f2e66957cd798fe",
                      "created_at": "2023-05-23T22:40:00.483519+07:00",
                      "updated_at": "2023-05-23T22:40:00.483532+07:00"
                    }
                  ],
                  imagePath:
                      'https://storage.googleapis.com/toko-dizital/product/images/Fungisida_Mancozeb.jpeg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=django-images-bucket%40toko-dizital.iam.gserviceaccount.com%2F20230523%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20230523T190002Z&X-Goog-Expires=86400&X-Goog-SignedHeaders=host&X-Goog-Signature=55b8de04310c9a3fc631ced29fa9b7402e279783e9c511f530d612a9e5fdb3531ba9cf5a038fba6f9b171de4fb79dd989fa94de9aac5ca06e9e55625b7d32bc3ae0603d43e58146f3281742678f21a62b03e464c60db1903d7a3aedf0bdc8ca82b9110cbb5dbb4ee83d6f4f17f9d45d701b6c436012fc5ee4c33925bafd264539756004182948a9b364a019b5199b574dca28dbc7a9b6768dec570a7c86f96130b8619507c5fe6b553557c28302db310c67638f4c73dd37979d0b3411c0dd715d9a09f7174943d8611ad9dd9a09c6d63ef5b19a2ce0c7d2d492b4db02c5d508993e5241d7afccd3b4b245b20c77011c988bcd067b5f906de2666134d1427986c'),
              child: RiwayatItem(riwayat: _list[index]),
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 5),
            itemCount: _list.length,
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Helpers.showModalImage(
                context,
                onTap: () async {
                  XFile pickedFile = await Helpers().getImage() as XFile;

                  // ignore: use_build_context_synchronously
                  Helpers.redirectPage(
                    context,
                    PreviewWidget(File(pickedFile.path)),
                  );
                },
                onTapGallery: () async {
                  XFile pickedFile =
                      await Helpers().getImage(gallery: true) as XFile;

                  // ignore: use_build_context_synchronously
                  Helpers.redirectPage(
                    context,
                    PreviewWidget(File(pickedFile.path)),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      child: Text(
                        'Cari tahu penyakit tanaman kamu disini',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
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
                onPressed: () => Helpers.redirectPage(context, RiwayatList()),
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
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => ClickWidget(
                destination: BlogDetail(_blogs[index]),
                child: BlogItem(
                  key: Key('BlogItem$index'),
                  blog: _blogs[index],
                  index: index,
                ),
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
