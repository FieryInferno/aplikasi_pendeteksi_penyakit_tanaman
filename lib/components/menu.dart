import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/menu_model.dart';
import '/pages/home.dart';
import '/pages/blog_list.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuModel>(
      builder: (context, menu, child) {
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
                IconButton(
                  onPressed: () {
                    Provider.of<MenuModel>(context, listen: false)
                        .setMenu('home');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  icon: Icon(
                    Icons.home,
                    color: menu.currentMenu == 'home'
                        ? const Color(0xFF116531)
                        : Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<MenuModel>(context, listen: false)
                        .setMenu('blog');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BlogList()),
                    );
                  },
                  icon: Icon(
                    Icons.description,
                    color: menu.currentMenu == 'blog'
                        ? const Color(0xFF116531)
                        : Colors.grey,
                  ),
                ),
                const Icon(Icons.person, color: Colors.grey),
              ],
            ),
          ),
        );
      },
    );
  }
}
