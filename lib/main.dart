import 'package:flutter/material.dart';
import 'package:aplikasi_pendeteksi_penyakit_tanaman/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SafeArea(
        child: Home(),
      ),
    );
  }
}
