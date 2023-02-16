import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_constants.dart';

class MyThemeData {
  // static const Color primaryColor = Color.fromARGB(255, 183, 147, 95);
  // static const Color primaryColorDark = Color.fromARGB(255, 20, 26, 46);
  // static const Color accentColorDark = Color.fromARGB(255, 250, 204, 29);
  static Color defaultColor  = Colors.blue;

  static final ThemeData lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        actionsIconTheme: IconThemeData(
            color: Colors.black
        ),
        titleTextStyle: TextStyle(color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 23,
        ),
        iconTheme: IconThemeData(color: Colors.black),
        ),
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        border:OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),),
        contentPadding: const EdgeInsetsDirectional.only(top: 5,start: 20),
        hintStyle: const TextStyle(color: Colors.black),
      ),
      brightness: Brightness.light,
      textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 18)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: defaultColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed
      ));



  static final ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black54,

      elevation: 0,

      actionsIconTheme: IconThemeData(
          color: Colors.white
      ),
      titleTextStyle: TextStyle(color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 23,
      ),
      iconTheme: IconThemeData(color: Colors.white),

    ),
      scaffoldBackgroundColor: Colors.black54,
      brightness: Brightness.dark,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black54,
          selectedItemColor: defaultColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed
      )
   );




}
