import 'package:flutter/material.dart';
import '/pages/blog_detail.dart';
import '/data/blogs.dart';
import '/components/click_widget.dart';
import '/components/blog_item.dart';
import '/components/page_wrap.dart';

class BlogList extends StatelessWidget {
  final List<Map<String, String>> _blogs = Blogs().list;

  BlogList({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      'Blog',
      child: ListView.separated(
        itemBuilder: (context, index) => ClickWidget(
          destination: BlogDetail(_blogs[index]),
          child: BlogItem(blog: _blogs[index]),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 5),
        itemCount: _blogs.length,
      ),
    );
  }
}
