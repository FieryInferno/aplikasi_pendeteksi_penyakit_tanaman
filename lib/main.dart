import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/pages/home.dart';
import '/menu_model.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => MenuModel(),
        child: const MyApp(),
      ),
    );

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
