import 'package:flutter/material.dart';
import '../components/back_button.dart';
import '../components/title_widget.dart';
import '../components/text_widget.dart';
import '../helpers.dart';

class BlogDetail extends StatefulWidget {
  final Map<String, dynamic> blogData;

  const BlogDetail(this.blogData, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BlogDetail createState() => _BlogDetail();
}

class _BlogDetail extends State<BlogDetail> {
  bool _displayFull = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: screenHeight / 2 - 60,
              top: 0,
              right: 0,
              left: 0,
              child: Image.network(widget.blogData['image'], fit: BoxFit.cover),
            ),
            const Positioned(top: 10, left: 10, child: BackButtonWidget()),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              bottom: 0,
              right: 0,
              left: 0,
              top: _displayFull ? 80 : screenHeight / 2,
              child: GestureDetector(
                onTap: () => setState(() => _displayFull = !_displayFull),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 30,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleWidget(title: widget.blogData['title']!),
                          Row(
                            children: [
                              const Icon(Icons.schedule),
                              const SizedBox(width: 5),
                              TextWidget(
                                convertDate(widget.blogData['timestamp']!),
                              ),
                              const SizedBox(width: 5),
                              const Icon(Icons.person),
                              TextWidget(widget.blogData['user']['name']!),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const TextWidget(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec condimentum pulvinar aliquet. Mauris molestie, sapien vitae commodo sollicitudin, nibh nisi gravida eros, mollis porta massa velit sed purus. Nulla in nibh ut dui rutrum cursus. Donec viverra sed nibh vel mollis. Vivamus varius luctus metus, vel ultricies augue. Ut sit amet eros tempus, sagittis nibh vitae, commodo tortor. Donec sollicitudin mi in porttitor venenatis. Curabitur at massa at elit efficitur pulvinar. Etiam accumsan augue non nunc convallis commodo. Nam aliquet consequat blandit. Sed et quam ut felis efficitur gravida. Maecenas scelerisque quis nisi et ultrices. Nullam blandit sit amet purus iaculis luctus. Donec quis velit consectetur, pulvinar orci at, tincidunt odio.',
                            size: 17.5,
                            align: TextAlign.justify,
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
