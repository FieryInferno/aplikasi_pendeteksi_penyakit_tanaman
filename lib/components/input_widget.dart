import 'package:flutter/material.dart';
import 'text_widget.dart';

class InputWidget extends StatelessWidget {
  final String label;
  final bool? password;
  final String? Function(String?)? validator;
  final TextEditingController _controller;
  final bool? disabled;
  final String? errorText;

  InputWidget({
    super.key,
    required this.label,
    this.password,
    this.validator,
    this.errorText,
    this.disabled,
    TextEditingController? controller,
  }) : _controller = controller ?? TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
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
              fontWeight:
                  disabled != null ? FontWeight.bold : FontWeight.normal,
            ),
            cursorColor: const Color(0xFF116531),
            decoration: InputDecoration(
              fillColor: disabled != null && disabled! ? null : Colors.white,
              filled: disabled != null && disabled! ? null : true,
              border: const UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              errorText: errorText,
            ),
            validator: validator,
            enabled: disabled != null ? !disabled! : true,
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
