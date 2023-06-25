import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';
import 'dart:io';
import 'dart:convert';
import '../helpers.dart';
import '../constants.dart';
import '../pages/result.dart';
import '../components/primary_button.dart';
import '../components/back_button.dart';

class PreviewWidget extends StatefulWidget {
  final File? image;

  const PreviewWidget(this.image, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PreviewWidget createState() => _PreviewWidget();
}

class _PreviewWidget extends State<PreviewWidget> {
  bool _loading = false;

  void _detectDisease() async {
    setState(() => _loading = true);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString('token');
    var formData = http.MultipartRequest(
      'POST',
      Constants.url['detectDisease']!,
    );

    if (token != null) formData.headers['Authorization'] = token;
    formData.files
        .add(await http.MultipartFile.fromPath('image', widget.image!.path));

    http.StreamedResponse response = await formData.send();

    if (response.statusCode == 201) {
      Map body = jsonDecode(await response.stream.bytesToString());
      Map data = body['data'];
      Map disease = data['disease'];

      // ignore: use_build_context_synchronously
      Helpers.redirectPage(
        context,
        Result(
          imagePath: data['image'],
          imageFile: widget.image,
          namaPenyakit: disease['name'],
          timestamp: data['timestamp'],
          description: disease['description'],
          solution: disease['solution'],
          rekomendasiProduk: disease['products'],
        ),
      );
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidget = [
      Positioned(
        bottom: 175,
        top: 0,
        right: 0,
        left: 0,
        child: Image.file(
          widget.image!,
          fit: BoxFit.cover,
        ),
      ),
      const Positioned(top: 10, left: 10, child: BackButtonWidget()),
      Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: Container(
          height: 200,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                PrimaryButton(
                  'Unggah Gambar',
                  onTap: _detectDisease,
                ),
                PrimaryButton(
                  'Ambil Ulang',
                  onTap: () => Helpers().getImage(),
                ),
              ],
            ),
          ),
        ),
      ),
    ];

    if (_loading) {
      listWidget.addAll([
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            height: 160,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: const [
                  CupertinoActivityIndicator(
                    color: Color(0xFF116531),
                    radius: 40,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Sedang Diproses',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 16,
                      color: Color(0xFF116531),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]);
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: listWidget,
        ),
      ),
    );
  }
}
