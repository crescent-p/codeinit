import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  const AuthField({
    super.key,
    required this.hintText,
    //defaluts to false
    this.obscureText = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is empty. Please fill it.";
        } else {
          return null;
        }
      },
    );
  }
}
