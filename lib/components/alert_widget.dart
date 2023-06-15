import 'package:flutter/material.dart';

import 'text_widget.dart';

class AlertWidget extends StatefulWidget {
  final String message;
  final String type;

  const AlertWidget({super.key, required this.message, required this.type});

  @override
  // ignore: library_private_types_in_public_api
  _AlertWidget createState() => _AlertWidget();
}

class _AlertWidget extends State<AlertWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _startAnimation();
  }

  void _startAnimation() async {
    await _animationController.forward();
    await Future.delayed(const Duration(seconds: 3));
    await _animationController.reverse();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _heightAnimation = Tween<double>(
      begin: 0.0,
      end: MediaQuery.of(context).size.height * 0.1,
    ).animate(_animationController);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: SafeArea(
            child: Container(
              height: _heightAnimation.value,
              margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: widget.type == 'error' ? Colors.red : Colors.green,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                            widget.type == 'error'
                                ? Icons.warning
                                : Icons.check_circle,
                            color: Colors.white),
                        const SizedBox(width: 5),
                        TextWidget(
                          widget.type == 'error' ? 'Error' : 'Success',
                          weight: FontWeight.bold,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextWidget(
                      widget.message,
                      color: Colors.white,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

void showCustomAlert(BuildContext context,
    {required String message, required String type}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.white.withOpacity(0.0),
    builder: (BuildContext context) {
      return Stack(children: [
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: AlertWidget(message: message, type: type),
        ),
      ]);
    },
  );
}
