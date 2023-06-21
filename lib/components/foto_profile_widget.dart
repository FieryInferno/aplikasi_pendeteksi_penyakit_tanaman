import 'dart:io';
import 'package:flutter/material.dart';

class FotoProfileWidget extends StatelessWidget {
  final String type;
  final String? asset;
  final String? url;
  final File? file;
  final void Function()? onTap;

  const FotoProfileWidget({
    super.key,
    required this.type,
    this.file,
    this.asset,
    this.url,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> configuration = {
      'width': MediaQuery.of(context).size.width * 0.5,
      'height': MediaQuery.of(context).size.height * 0.24,
      'fit': BoxFit.cover,
    };

    Image generateChild() {
      if (type == 'file') {
        return Image.file(
          file!,
          width: configuration['width'],
          height: configuration['height'],
          fit: configuration['fit'],
        );
      } else if (type == 'network') {
        return Image.network(
          url!,
          width: configuration['width'],
          height: configuration['height'],
          fit: configuration['fit'],
        );
      } else {
        return Image.asset(
          asset!,
          width: configuration['width'],
          height: configuration['height'],
          fit: configuration['fit'],
        );
      }
    }

    return InkWell(onTap: onTap, child: ClipOval(child: generateChild()));
  }
}
