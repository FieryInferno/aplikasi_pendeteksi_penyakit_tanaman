import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/menu_model.dart';
import '../components/menu_button.dart';
import '../pages/home.dart';
import '../pages/blog_list.dart';
import '../pages/profile/auth_view.dart';
import '../pages/profile/profile.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      margin: const EdgeInsets.only(top: 15),
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
          const MenuButton(
            menu: 'blog',
            destination: BlogList(),
            icon: Icons.description,
          ),
          Consumer<MenuModel>(
            builder: (context, value, child) {
              return FutureBuilder(
                future: value.isLogin,
                builder: (context, snapshot) {
                  return MenuButton(
                    menu: 'profile',
                    destination: snapshot.data != null
                        ? const Profile()
                        : const AuthView(),
                    icon: Icons.person,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
