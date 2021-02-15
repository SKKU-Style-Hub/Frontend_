import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Navigation.dart';

class StartScreen extends StatefulWidget {
  _StartScreenState createState() {
    return _StartScreenState();
  }
}

class _StartScreenState extends State<StartScreen> {
  var opacityValue = 1.0;
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 450,
      child: Stack(
        children: [
          Positioned(
              child: Container(
            color: Colors.black,
          )),
          Positioned(
            width: 420,
            height: 800,
            child: InkWell(
              child: AnimatedOpacity(
                opacity: opacityValue,
                duration: Duration(seconds: 1),
                child: Image.asset("assets/images/SPLASH_image.png",
                    fit: BoxFit.fill),
              ),
              //child: Image.asset("assets/images/SPLASH_image.png", fit: BoxFit.cover),
              onTap: () {
                //다음화면으로 넘어가게
                setState(() {
                  opacityValue = 1.0;
                });
              },
              onLongPress: () {
                //시작화면으로 넘어가자!!!!!!!!!!!!!
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Navigation(),
                    ));
              },
            ),
          )
        ],
      ),
    ));
  }
}
