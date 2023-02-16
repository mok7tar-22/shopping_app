import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';

import '../text_field_auth.dart';

class SignUpForm extends StatelessWidget {
  final bool visible;
  final Function changeVisibility;
  final GlobalKey<FormState> form;
  final TextEditingController email, password, user,phone;

  const SignUpForm({
    required this.form,
    required this.email,
    required this.password,
    required this.user,
    required this.visible,
    required this.changeVisibility,
    required this.phone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldAuth(
              controller: user,
              validator: (value) {
                if (value.toString().isNotEmpty &&
                    value.toString().trim().length > 5) {
                  return null;
                } else {
                  return "please enter user name five character at least";
                }
              },
              hintText: "User Name"),
          TextFieldAuth(
              controller: email,
              validator: (value) {
                if (value != null &&
                    value.isNotEmpty &&
                    EmailValidator.validate(value)) {
                  return null;
                } else {
                  return "Please enter valid email.";
                }
              },
              hintText: 'Email'),
          TextFieldAuth(
              controller: password,
              obscureText: visible,
              validator: (value) {
                if (value != null && value.length >= 6) {
                  return null;
                } else {
                  return "Please enter 6 characters at least.";
                }
              },

              suffixIcon: IconButton(
                  onPressed: () {
                    changeVisibility();
                  },
                  icon: visible
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility)),
              hintText: "Password"),
          TextFieldAuth(
              controller: phone,
              validator: (value) {
                if (value != null && value.length >= 11) {
                  return null;
                } else {
                  return "Please enter 11 characters at least.";
                }
              },

              suffixIcon: const Icon(Icons.phone),
              hintText: "Phone"),
        ],
      ),
    );
  }
}
