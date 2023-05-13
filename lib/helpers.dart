import '../pages/preview_widget.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class Helpers {
  final picker = ImagePicker();

  Future getImage(context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewWidget(File(pickedFile!.path)),
      ),
    );
  }

  Future getImageByGaleri() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  }

  void redirectPage(context, Widget destination) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }
}
