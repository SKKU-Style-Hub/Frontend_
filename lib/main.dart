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
      home: StartScreen(),
    );
  }
}
