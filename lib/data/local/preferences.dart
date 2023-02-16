import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/views/screens/authentication/login_screen.dart';
import 'package:shopping_app/views/screens/boarding_screen.dart';
import 'package:shopping_app/views/screens/main_screen.dart';

class Preferences {
  static late SharedPreferences _preferences;

  static const language = 'language';
  static const lightTheme = "light";
  static const darkTheme = "dark";
  static const themes = 'theme';
  static const onBoard = 'ShowOnBoard';
  static const tokenKey = 'token';


  bool? showOnBoard = Preferences.getData(onBoard);
   static String? token= Preferences.getData(tokenKey);
  Widget startWidget(){
    if(showOnBoard !=null){
      if(token!=null) {
        return const MainScreen();
      } else {
        return const LoginScreen();
      }
    }else{
      return const BoardingScreen();

  }
  }



  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future saveThemePreference(ThemeMode theme) async {
    String themeMode;
    if (theme == ThemeMode.dark) {
      themeMode = lightTheme;
    } else {
      themeMode = darkTheme;
    }
    _preferences.setString(themes, themeMode);
  }

  static ThemeMode getThemePreference() {
    String theme = _preferences.getString(themes).toString();
    if (theme == lightTheme) {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }




  static dynamic getData(String key) {
    return _preferences.get(key);
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) return await _preferences.setString(key, value);
    if (value is int) return await _preferences.setInt(key, value);
    if (value is bool) return await _preferences.setBool(key, value);
    return await _preferences.setDouble(key, value);
  }

  static Future<bool> removeData(String key) async {
    return await _preferences.remove(key);
  }
}
