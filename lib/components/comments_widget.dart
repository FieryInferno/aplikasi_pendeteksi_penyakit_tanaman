import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers.dart';
import '../model/comment_model.dart';
import '../components/mini_loading.dart';
import '../components/text_widget.dart';

class _CommentsWidget extends State<CommentsWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
    //     Provider.of<CommentModel>(context, listen: false).loadMor
    //   }
    // })
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentModel>(
      builder: (context, commentModel, child) {
        int id = widget.blogId;

        if (commentModel.comments[id] == null) {
          commentModel.getComment(id);
          return const MiniLoading();
        }

        return SizedBox(
          height: 300,
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              final comment = commentModel.comments[id]![index];
              final user = comment['user'];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.network(
                      user['image'],
                      width: 50,
                      height: 50,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              user['name'],
                              weight: FontWeight.bold,
                              size: 18,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.schedule),
                                Text(convertDate(comment['timestamp'])),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextWidget(
                          comment['message'],
                          align: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: commentModel.comments.length,
          ),
        );
      },
    );
  }
}

class CommentsWidget extends StatefulWidget {
  final int blogId;

  const CommentsWidget(this.blogId, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CommentsWidget createState() => _CommentsWidget();
}
