import 'package:aplikasi_pendeteksi_penyakit_tanaman/menu_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Current menu harusnya berubah',
    () {
      var menuModel = MenuModel();

      menuModel.setMenu('blog');

      expect(menuModel.currentMenu, 'blog');
    },
  );
}
