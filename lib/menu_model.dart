import 'package:flutter/material.dart';

class MenuModel extends ChangeNotifier {
  String currentMenu = 'home';

  void setMenu(String menu) {
    currentMenu = menu;
    notifyListeners();
  }
}
