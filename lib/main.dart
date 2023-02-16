import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/controllers/settings/setteings_cubit.dart';
import 'package:shopping_app/utils/my_theme_data%20.dart';
import 'controllers/shop/shop_cubit.dart';
import 'data/local/preferences.dart';
import 'data/remote/dio_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await Preferences.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
            ShopCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoriteData()),
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context , child) {
              return MaterialApp(
                title: 'shop app',
                debugShowCheckedModeBanner: false,
                theme: MyThemeData.lightTheme,
                darkTheme: MyThemeData.darkTheme,
                themeMode: SettingsCubit
                    .get(context)
                    .mode,
                home: Preferences().startWidget(),
              );
            },
          );
        },
      ),
    );
  }
}
