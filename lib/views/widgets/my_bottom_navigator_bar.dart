import 'package:flutter/material.dart';
import 'package:shopping_app/controllers/shop/shop_cubit.dart';

class MyBottomNavigatorBar extends StatelessWidget {
  const MyBottomNavigatorBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (value) {
          ShopCubit.get(context).ChangeScreen(value);
        },

        currentIndex:  ShopCubit.get(context).currentScreen,
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      );
  }
}
