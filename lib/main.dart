import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:stylehub_flutter/Startscreen.dart';
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
        //primaryColor: Colors.black,
        buttonColor: Colors.black,
      ),
      home: AnimatedSplashScreen(
        duration: 2000,
        splashIconSize: 500,
        splash: Image.asset(
          "assets/images/SPLASH_image.png",
          height: 500,
        ),
        nextScreen: Navigation(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.black,
      ),
    );
  }
}
