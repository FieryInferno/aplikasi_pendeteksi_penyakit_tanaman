import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class BlogModel extends ChangeNotifier {
  final List<dynamic> _blogs = [];

  BlogModel() {
    if (_blogs.isEmpty) {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    Uri url = Constants.url['blogs']!;

    url = url.replace(queryParameters: {'page': '1', 'limit': '5'});

    var request = http.Request('GET', url);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final result = jsonDecode(await response.stream.bytesToString());

      _blogs.addAll(result['result']);
    }
    notifyListeners();
  }

  List<dynamic> get blogs => _blogs;
}
