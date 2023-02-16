import 'package:flutter/material.dart';

class TextFieldAuth extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final Widget? suffixIcon;
  final String hintText;
  final bool? obscureText;

  const TextFieldAuth(
      {Key? key,
      required this.controller,
      this.obscureText,
      required this.validator,
      this.suffixIcon,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText ?? false,
        cursorColor: Colors.black,
        keyboardType: TextInputType.text,

        validator: (value) => validator(value),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
