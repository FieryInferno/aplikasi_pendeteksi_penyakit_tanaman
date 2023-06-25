import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import './pages/preview_widget.dart';

class Helpers {
  final picker = ImagePicker();

  Future<XFile?> getImage({bool? gallery}) async {
    ImageSource source = ImageSource.camera;

    if (gallery != null) source = ImageSource.gallery;

    final pickedFile = await picker.pickImage(source: source);

    return pickedFile;
  }

  static void redirectPage(context, Widget destination) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => destination),
    );
  }

  static Future<dynamic> showModalImage(context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 125,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      XFile pickedFile = await Helpers().getImage() as XFile;

                      // ignore: use_build_context_synchronously
                      Helpers.redirectPage(
                        context,
                        PreviewWidget(File(pickedFile.path)),
                      );
                    },
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
                    onTap: () async {
                      XFile pickedFile =
                          await Helpers().getImage(gallery: true) as XFile;

                      // ignore: use_build_context_synchronously
                      Helpers.redirectPage(
                        context,
                        PreviewWidget(File(pickedFile.path)),
                      );
                    },
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
  }
}
