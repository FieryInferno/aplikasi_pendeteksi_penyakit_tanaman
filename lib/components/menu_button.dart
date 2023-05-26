import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../menu_model.dart';
import '../helpers.dart';

class MenuButton extends StatelessWidget {
  final String menu;
  final Widget destination;
  final IconData icon;

  const MenuButton({
    super.key,
    required this.menu,
    required this.destination,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuModel>(
      builder: (context, value, child) {
        return IconButton(
          onPressed: () {
            if (value.currentMenu != menu) {
              Provider.of<MenuModel>(context, listen: false).setMenu(menu);
              Helpers().redirectPage(context, destination);
            }
          },
          icon: Icon(
            icon,
            color: value.currentMenu == menu
                ? const Color(0xFF116531)
                : Colors.grey,
          ),
        );
      },
    );
  }
}
