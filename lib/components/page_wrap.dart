import 'package:flutter/material.dart';
import 'menu.dart';
import 'text_widget.dart';

class PageWrapper extends StatelessWidget {
  final String pageName;
  final Widget? child;

  const PageWrapper(this.pageName, {super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: const Color(0xFFE7F0EB),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/logo.png'),
                      const SizedBox(width: 10),
                      TextWidget(
                        pageName,
                        weight: FontWeight.bold,
                        size: 24,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  child!,
                ],
              ),
            ),
            const Menu(),
          ],
        ),
      ),
    );
  }
}
