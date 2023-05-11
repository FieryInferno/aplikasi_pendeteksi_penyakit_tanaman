import 'package:flutter/material.dart';

class ClickWidget extends StatelessWidget {
  final Widget child;
  final Widget destination;

  const ClickWidget(
      {super.key, required this.child, required this.destination});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => destination,
        ),
      ),
      child: child,
    );
  }
}
