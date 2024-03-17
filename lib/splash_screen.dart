import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:codeinit/core/theme/colors.dart';
import 'package:codeinit/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          splash: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                LottieBuilder.asset('asssets/animations/splash.json'),
              ],
            ),
          ),
          duration: 3000,
          splashIconSize: 400,
          backgroundColor: AppPallete.backgroundColor,
          nextScreen: const MyApp()),
    );
  }
}
