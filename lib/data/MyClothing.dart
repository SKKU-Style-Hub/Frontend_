import 'dart:convert';

import 'package:dataclass/dataclass.dart';
import 'package:flutter/cupertino.dart';

@dataClass
class MyClothing {
  int index;
  String clothingImgBase64;

  MyClothing({this.index, this.clothingImgBase64});

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'clothingImgBase64': clothingImgBase64,
    };
  }
}
