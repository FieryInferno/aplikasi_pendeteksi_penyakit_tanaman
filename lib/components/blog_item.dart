import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '/components/text_widget.dart';

class BlogItem extends StatefulWidget {
  final Map<String, String> blog;
  final int index;

  const BlogItem({super.key, required this.blog, required this.index});

  @override
  // ignore: library_private_types_in_public_api
  _BlogItem createState() => _BlogItem();
}

class _BlogItem extends State<BlogItem> with TickerProviderStateMixin {
  AnimationController? _animationController;
  AnimationController? _animationSlideController;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _slideAnimation;

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
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController!);
    _slideAnimation = Tween<Offset>(
            begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
        .animate(_animationSlideController!);
    _animationController!.forward();
    _animationSlideController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('animasi_blog${widget.index}'),
      onVisibilityChanged: (info) {
        _animationController!.animateTo(info.visibleFraction);
        _animationSlideController!.animateTo(
            info.visibleFraction > 0.25 ? 1.0 : info.visibleFraction);
      },
      child: SlideTransition(
        position: _slideAnimation!,
        child: AnimatedBuilder(
          animation: _animationController!,
          builder: (BuildContext context, Widget? child) {
            return Opacity(
              opacity: _opacityAnimation!.value,
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
                          child: Image.asset(
                            'assets/images/${widget.blog['image']}',
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
                                Flexible(child: Text('${widget.blog['date']}')),
                                Flexible(
                                  child: Text('${widget.blog['author']}'),
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
