import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Function validate;

  const AuthButton({
    Key? key,
    required this.text,
    required this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          validate();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text),
              const Icon(Icons.arrow_right_alt_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
