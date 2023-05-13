import 'package:flutter/material.dart';
import '../helpers.dart';

class ClickWidget extends StatelessWidget {
  final Widget child;
  final Widget destination;

  const ClickWidget(
      {super.key, required this.child, required this.destination});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Helpers().redirectPage(context, destination),
      child: child,
    );
  }
}
