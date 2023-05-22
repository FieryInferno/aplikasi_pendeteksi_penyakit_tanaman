import 'package:flutter/material.dart';
import 'text_widget.dart';

class InputWidget extends StatelessWidget {
  final String label;
  final bool? password;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const InputWidget({
    super.key,
    required this.label,
    this.password,
    this.onChanged,
    this.validator,
  });

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
        TextFormField(
          obscureText: password ?? false,
          style: const TextStyle(color: Color(0xFF116531)),
          cursorColor: const Color(0xFF116531),
          decoration: const InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
