import 'package:aplikasi_pendeteksi_penyakit_tanaman/helpers.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../components/text_widget.dart';

class BlogItem extends StatefulWidget {
  final Map<String, dynamic> blog;
  final int index;

  const BlogItem({Key? key, required this.blog, required this.index})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BlogItemState createState() => _BlogItemState();
}

class _BlogItemState extends State<BlogItem> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _animationSlideController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animationSlideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(_animationSlideController);
    _animationController.forward();
    _animationSlideController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationSlideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('animasi_blog${widget.index}'),
      onVisibilityChanged: (VisibilityInfo info) {
        _animationController.animateTo(info.visibleFraction,
            curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
        _animationSlideController.animateTo(
          info.visibleFraction > 0.25 ? 1.0 : 0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 600),
        );
      },
      child: SlideTransition(
        position: _slideAnimation,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Image.network(
                            widget.blog['image'],
                            height: 110,
                            width: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 80,
                              child: TextWidget(
                                '${widget.blog['title']}',
                                weight: FontWeight.bold,
                                size: 15,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    convertDate(widget.blog['timestamp']),
                                  ),
                                ),
                                Flexible(
                                  child: Text(widget.blog['user']['name']),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
