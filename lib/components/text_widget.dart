import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final FontWeight weight;
  final double size;
  final TextAlign align;

  const TextWidget(this.title,
      {super.key,
      this.weight = FontWeight.normal,
      this.size = 15,
      this.align = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: align,
      style: TextStyle(
        fontFamily: 'Quicksand',
        fontWeight: weight,
        fontSize: size,
      ),
    );
  }
}
