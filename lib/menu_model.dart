import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuModel extends ChangeNotifier {
  String currentMenu = 'home';

  void setMenu(String menu) {
    currentMenu = menu;
    notifyListeners();
  }

  Future<bool> get isLogin async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString('token') != null ? true : false;
  }
}
