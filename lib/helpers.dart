import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'pages/preview_widget.dart';

class Helpers {
  final picker = ImagePicker();

  Future<XFile?> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    return pickedFile;
  }

  Future getImageByGaleri() async {
    // ignore: unused_local_variable
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  }

  void redirectPage(context, Widget destination) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => destination),
    );
  }

  Future<dynamic> showModalImage(context) {
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
                    onTap: () {
                      XFile pickedFile = Helpers().getImage() as XFile;
                      Helpers().redirectPage(
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
  }
}
