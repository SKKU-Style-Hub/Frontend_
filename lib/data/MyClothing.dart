import 'dart:convert';

import 'package:dataclass/dataclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:stylehub_flutter/MyCloset/TagResult/TagResult.dart';

@dataClass
class MyClothing {
  int id;
  String clothingImgPath;
  String clothingImgUrl;
  String clothingImgBase64;
  String category;
  String color;
  String colorDetail; //color hex code
  String print; // pattern
  String look; // style ex.casual
  String texture;
  String detail;
  String length;
  String sleeveLength;
  String neckLine;
  String fit;
  String shape;
  String brandName;

  MyClothing(
      {this.id,
      this.clothingImgPath,
      this.clothingImgUrl,
      this.clothingImgBase64,
      this.category,
      this.color,
      this.colorDetail,
      this.print,
      this.look,
      this.texture,
      this.detail,
      this.length,
      this.sleeveLength,
      this.neckLine,
      this.fit,
      this.shape,
      this.brandName});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clothingImgPath': clothingImgPath,
      'clothingImgUrl': clothingImgUrl,
      'clothingImgBase64': clothingImgBase64,
      'category': category,
      'color': color,
      'colorDetail': colorDetail,
      'print': print,
      'look': look,
      'texture': texture,
      'detail': detail,
      'length': length,
      'sleeveLength': sleeveLength,
      'neckLine': neckLine,
      'fit': fit,
      'shape': shape,
      'brandName': brandName
    };
  }
}
