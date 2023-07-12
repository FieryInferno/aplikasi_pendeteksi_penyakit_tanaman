import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers.dart';
import '../model/comment_model.dart';
import '../components/back_button.dart';
import '../components/title_widget.dart';
import '../components/text_widget.dart';
import '../components/mini_loading.dart';

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
                          TextWidget(
                            widget.blogData['description'],
                            size: 17.5,
                            align: TextAlign.justify,
                          ),
                          const SizedBox(height: 10),
                          const TitleWidget(title: 'Komentar'),
                          Consumer<CommentModel>(
                              builder: (context, commentModel, child) {
                            int id = widget.blogData['id'];

                            if (commentModel.comments[id] == null) {
                              commentModel.getComment(id);
                              return const MiniLoading();
                            }

                            List<Widget> listCommentWidget = [];

                            for (var i = 0;
                                i < commentModel.comments[id]!.length;
                                i++) {
                              final comment = commentModel.comments[id]![i];
                              final user = comment['user'];

                              listCommentWidget.add(Row(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextWidget(
                                              user['name'],
                                              weight: FontWeight.bold,
                                              size: 18,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.schedule),
                                                Text(convertDate(
                                                    comment['timestamp'])),
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
                              ));
                            }

                            return Column(
                              children: listCommentWidget,
                            );
                          })
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
