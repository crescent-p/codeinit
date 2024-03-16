import 'package:codeinit/core/theme/colors.dart';
import 'package:flutter/material.dart';

class AuthSignUpButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const AuthSignUpButton({super.key, required this.buttonText, required this.onPressed});

//we took an elavated button, removed the background and shadow and put it in a container. added gradient and curved the edges.

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppPallete.gradient1, AppPallete.gradient2],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
        ),
        child:  Text(
          buttonText,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
