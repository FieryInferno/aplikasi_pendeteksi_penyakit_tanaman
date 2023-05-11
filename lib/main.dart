import 'package:flutter/material.dart';
import '/home.dart';
import '/pages/riwayat_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: SafeArea(child: Home()),
    );
  }
}
