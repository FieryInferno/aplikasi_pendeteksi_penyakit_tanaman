import 'package:flutter/material.dart';
import '/components/text_widget.dart';

class BlogItem extends StatelessWidget {
  final Map<String, String> blog;

  const BlogItem({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  'assets/images/${blog['image']}',
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
                      '${blog['title']}',
                      weight: FontWeight.bold,
                      size: 15,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${blog['date']}'),
                      Text('${blog['author']}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
