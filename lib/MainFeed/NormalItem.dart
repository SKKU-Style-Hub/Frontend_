import 'package:flutter/material.dart';

Widget normalItem({String str}) {
  double width;
  int len_str = str.length;
  if (len_str <= 2) {
    width = 50;
  } else if (len_str == 3) {
    width = 60;
  } else if (len_str == 4) {
    width = 70;
  } else {
    width = 90;
  }
  return Container(
    margin: EdgeInsets.only(left: 5.0, top: 0.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(80)),
      border: Border.all(width: 1, color: Colors.black),
    ),
    width: width,
    height: 20,
    alignment: Alignment.center,
    child: Text(str, style: TextStyle(fontSize: 12, color: Colors.black)),
  );
}
