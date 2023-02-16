import 'package:flutter/material.dart';

class ConstantsWidgets {


  static void getSnackBar(context, String title, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(title),
      backgroundColor: color,
    ));
  }
}
