import 'package:flutter/material.dart';
import '/pages/blog_detail.dart';
import '/data/blogs.dart';
import '/components/text_widget.dart';
import '/components/click_widget.dart';
import '/components/blog_item.dart';
import '/components/menu.dart';

class BlogList extends StatelessWidget {
  final List<Map<String, String>> _blogs = Blogs().list;

  BlogList({super.key});

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
                      const TextWidget('Blog',
                          weight: FontWeight.bold, size: 24),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => ClickWidget(
                        destination: BlogDetail(_blogs[index]),
                        child: BlogItem(blog: _blogs[index]),
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 5),
                      itemCount: _blogs.length,
                    ),
                  ),
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
