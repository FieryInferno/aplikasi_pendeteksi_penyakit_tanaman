import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../model/blog_model.dart';
import '../pages/blog_detail.dart';
import 'blog_item.dart';
import 'click_widget.dart';
import 'title_widget.dart';

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
        children: [
          const TitleWidget(title: 'Blog'),
          Consumer<BlogModel>(builder: (context, blogModel, child) {
            List<dynamic> blog = blogModel.blogs;

            return blogModel.isLoading
                ? const Center(
                    child: CupertinoActivityIndicator(
                      color: Color(0xFF116531),
                      radius: 40,
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
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
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 5),
                      itemCount: blog.length,
                      controller: _scrollController,
                    ),
                  );
          }),
        ],
      ),
    );
  }
}
