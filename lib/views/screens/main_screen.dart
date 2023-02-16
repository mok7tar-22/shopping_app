import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/controllers/shop/shop_cubit.dart';
import 'package:shopping_app/utils/app_constants.dart';
import 'package:shopping_app/views/screens/search_screen.dart';

import '../widgets/my_bottom_navigator_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text(AppConstants.shopAppTitle),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context) => SearchScreen()));
                  },
                  icon: const Icon(Icons.search)),


            ],
          ),
          body: cubit.screens[cubit.currentScreen],
          bottomNavigationBar: MyBottomNavigatorBar(),
        );
      },
    );
  }
}

