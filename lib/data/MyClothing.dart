import 'dart:convert';

import 'package:dataclass/dataclass.dart';
import 'package:flutter/cupertino.dart';

@dataClass
class MyClothing {
  int id;
  String clothingImgBase64;

  MyClothing({this.id, this.clothingImgBase64});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clothingImgBase64': clothingImgBase64,
    };
  }
}
