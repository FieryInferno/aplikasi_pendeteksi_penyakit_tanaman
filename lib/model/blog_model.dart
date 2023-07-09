import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class BlogModel extends ChangeNotifier {
  final List<dynamic> _blogs = [];
  bool _isLoading = false;
  int _page = 1;

  BlogModel() {
    if (_blogs.isEmpty) {
      _isLoading = true;
      getInitialData();
    }
  }

  Future<void> getInitialData() async {
    Map<String, dynamic> result = await fetchData();

    _blogs.addAll(result['result']);
    _isLoading = false;
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchData() async {
    Uri url = Constants.url['blogs']!;

    url =
        url.replace(queryParameters: {'page': _page.toString(), 'limit': '5'});

    var request = http.Request('GET', url);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return jsonDecode(await response.stream.bytesToString());
    }

    return {};
  }

  List<dynamic> get blogs => _blogs;
  bool get isLoading => _isLoading;

  void loadMore() async {
    if (_blogs[_blogs.length - 1] is Map<String, dynamic>) {
      _blogs.add(true);
      notifyListeners();
      _page++;
      Future.delayed(const Duration(seconds: 3), () async {
        Map<String, dynamic> result = await fetchData();

        _blogs.removeLast();
        _blogs.addAll(result['result']);
        notifyListeners();
      });
    }
  }
}
