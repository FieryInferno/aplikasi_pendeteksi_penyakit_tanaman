import 'package:flutter/cupertino.dart';

class MiniLoading extends StatelessWidget {
  const MiniLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(
        color: Color(0xFF116531),
        radius: 40,
      ),
    );
  }
}
