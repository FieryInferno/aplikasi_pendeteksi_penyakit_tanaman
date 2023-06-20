import 'package:aplikasi_pendeteksi_penyakit_tanaman/model/menu_model.dart';
import 'package:aplikasi_pendeteksi_penyakit_tanaman/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MenuModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Colors.white,
          ),
          useMaterial3: true,
        ),
        home: SafeArea(child: Home()),
      ),
    );
  }
}

void main() {
  testWidgets(
    'Logo dan Tulisan Daun Daunan',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.byType(Image), findsWidgets);

      final imageWidget = tester.widget<Image>(find.byType(Image));

      expect(imageWidget, const AssetImage('assets/images/logo.png'));
    },
  );
}
