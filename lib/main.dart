import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:image_pick/image_pick.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'Navigation.dart';
import 'package:http/http.dart' as http;

void main() async {
  runApp(StyleHub());
}

class StyleHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        buttonColor: Colors.black,
      ),
      home: AnimatedSplashScreen(
        duration: 2000,
        splashIconSize: 500,
        splash: Image.asset(
          "assets/images/SPLASH_image.png",
          height: 500,
        ),
        nextScreen: Navigation(
          selectedPosition: 0,
        ),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.black,
        pageTransitionType: PageTransitionType.scale,
      ),
    );
  }
}
