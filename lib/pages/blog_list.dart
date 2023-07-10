import 'package:flutter/material.dart';
import '../components/page_wrap.dart';
import '../components/blog_list_view.dart';

class BlogList extends StatelessWidget {
  const BlogList({super.key});

  @override
  Widget build(BuildContext context) =>
      const PageWrapper('Blog', child: BlogListView());
}
