import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import './click_widget.dart';
import './blog_item.dart';
import '../model/blog_model.dart';
import '../pages/blog_detail.dart';

class BlogListView extends StatefulWidget {
  const BlogListView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BlogListView createState() => _BlogListView();
}

class _BlogListView extends State<BlogListView> {
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
    return Consumer<BlogModel>(builder: (context, blogModel, child) {
      List<dynamic> blog = blogModel.blogs;

      return blogModel.isLoading
          ? const Center(
              child: CupertinoActivityIndicator(
                color: Color(0xFF116531),
                radius: 40,
              ),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                return blog[index] is bool
                    ? const Text('Load more...')
                    : ClickWidget(
                        destination: BlogDetail(blog[index]),
                        child: BlogItem(
                          key: Key('BlogItem$index'),
                          blog: blog[index],
                          index: index,
                        ),
                      );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemCount: blog.length,
              controller: _scrollController,
            );
    });
  }
}
