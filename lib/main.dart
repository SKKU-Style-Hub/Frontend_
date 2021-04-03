import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginScreen.dart';
import 'Navigation.dart';

void main() async {
  runApp(StyleHub());
}

class StyleHub extends StatefulWidget {
  static String myNickname;
  static String myProfileImg;
  static String myGender;
  @override
  _StyleHubState createState() => _StyleHubState();
}

class _StyleHubState extends State<StyleHub> {
  bool isLoggedIn = true;

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      StyleHub.myNickname = prefs.getString('userNickname');
      StyleHub.myProfileImg = prefs.getString('userProfileImg');
      StyleHub.myGender = prefs.getString('userGender');
    });
  }

  _checkAccessToken() async {
    var token = await AccessTokenStore.instance.fromStore();
    if (token.refreshToken == null) {
      setState(() {
        isLoggedIn = false;
      });
    } else {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  @override
  void initState() {
    _checkAccessToken();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        buttonColor: Colors.black,
      ),
      home: AnimatedSplashScreen(
        duration: 1500,
        splashIconSize: 500,
        splash: Image.asset(
          "assets/images/SPLASH_image.png",
          height: 500,
        ),
        nextScreen: Navigation(
          selectedPosition: 0,
        ),
        /*nextScreen: isLoggedIn
            ? Navigation(
                selectedPosition: 0,
              )
            : LoginScreen(),*/
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.black,
        pageTransitionType: PageTransitionType.scale,
      ),
    );
  }
}
