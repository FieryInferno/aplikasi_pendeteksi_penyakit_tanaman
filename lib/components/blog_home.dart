import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import './title_widget.dart';
import '../model/blog_model.dart';
import '../components/blog_list_view.dart';

class BlogHome extends StatefulWidget {
  const BlogHome({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BlogHome createState() => _BlogHome();
}

class _BlogHome extends State<BlogHome> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Provider.of<BlogModel>(context, listen: false).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: const [
          TitleWidget(title: 'Blog'),
          Expanded(child: BlogListView()),
        ],
      ),
    );
  }
}
