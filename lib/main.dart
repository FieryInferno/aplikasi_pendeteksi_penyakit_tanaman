import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/home.dart';
import '../model/menu_model.dart';
import '../model/blog_model.dart';
import '../model/comment_model.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MenuModel()),
          ChangeNotifierProvider(create: (context) => BlogModel()),
          ChangeNotifierProvider(
            create: (context) => CommentModel(),
          )
        ],
        child: const MyApp(),
      ),
    );

Future<void> get isLogin async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  if (Jwt.isExpired(preferences.getString('token').toString())) {
    preferences.clear();
  }
}

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
      home: SafeArea(
        child: FutureBuilder(
          future: isLogin,
          builder: (context, snapshot) => Home(),
        ),
      ),
    );
  }
}
