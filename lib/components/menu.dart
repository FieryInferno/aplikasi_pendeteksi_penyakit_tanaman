import 'package:flutter/material.dart';
import '/components/menu_button.dart';
import '/pages/home.dart';
import '/pages/blog_list.dart';
import '/pages/auth_view.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Container(
        height: 62,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MenuButton(
              menu: 'home',
              destination: Home(),
              icon: Icons.home,
            ),
            MenuButton(
              menu: 'blog',
              destination: BlogList(),
              icon: Icons.description,
            ),
            const MenuButton(
              menu: 'profile',
              destination: AuthView(),
              icon: Icons.person,
            ),
          ],
        ),
      ),
    );
  }
}
