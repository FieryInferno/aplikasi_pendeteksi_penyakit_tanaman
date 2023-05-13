import 'package:flutter/material.dart';
import 'text_widget.dart';

class InputWidget extends StatelessWidget {
  final String label;
  final bool? password;

  const InputWidget({super.key, required this.label, this.password});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          label,
          color: const Color(0xFF116531),
          size: 20,
          weight: FontWeight.bold,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: TextFormField(
            obscureText: password ?? false,
            style: const TextStyle(color: Color(0xFF116531)),
            cursorColor: const Color(0xFF116531),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
