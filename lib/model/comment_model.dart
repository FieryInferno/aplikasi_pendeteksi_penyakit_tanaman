import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class CommentModel extends ChangeNotifier {
  final Map<int, List<dynamic>> _comments = {};
  int page = 0;

  void getComment(id) async {
    Uri url = Constants.url['comments']!;
    url = url.replace(
      path: '${url.path}/$id',
      queryParameters: {'page': page.toString(), 'limit': '5'},
    );

    var request = http.Request('GET', url);
    http.StreamedResponse response = await request.send();
    final result = jsonDecode(await response.stream.bytesToString());

    _comments.addAll({id: result['result']});
    notifyListeners();
  }

  Map<int, List<dynamic>> get comments => _comments;
}
