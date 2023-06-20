import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  Map<String, dynamic>? _user;

  set user(Map<String, dynamic>? user) {
    _user = user;
    notifyListeners();
  }

  Map<String, dynamic>? get user => _user;
}
