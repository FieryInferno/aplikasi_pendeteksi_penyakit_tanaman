import 'package:flutter/material.dart';
import 'text_widget.dart';

class InputWidget extends StatelessWidget {
  final String label;
  final bool? password;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController _controller = TextEditingController();
  final bool? disabled;

  InputWidget({
    super.key,
    required this.label,
    this.password,
    this.onChanged,
    this.validator,
    value,
    this.disabled,
  }) {
    _controller.text = value ?? '';
  }

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
          style: TextStyle(
            color: const Color(0xFF116531),
            fontSize: disabled != null ? 30 : 20,
            fontWeight: disabled != null ? FontWeight.bold : FontWeight.normal,
          ),
          cursorColor: const Color(0xFF116531),
          decoration: InputDecoration(
            fillColor: disabled != null && disabled! ? null : Colors.white,
            filled: disabled != null && disabled! ? null : true,
            border: const UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          onChanged: onChanged,
          validator: validator,
          enabled: disabled != null ? !disabled! : true,
          controller: _controller,
        ),
      ],
    );
  }
}
