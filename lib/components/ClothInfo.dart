import 'package:flutter/material.dart';

//코디 정보를 가지고 있느 class
class ClothInfo {
  String image;
  int price;
  String brandname;
  String clothname;
  String url;
  int type;
  ClothInfo(
      {this.brandname,
      this.clothname,
      this.image,
      this.price,
      this.type,
      this.url}) {}
}
