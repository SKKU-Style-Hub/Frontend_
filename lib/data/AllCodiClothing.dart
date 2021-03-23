import 'MyClothing.dart';
import 'ProductClothing.dart';
import 'CodiClothing.dart';
import 'package:dataclass/dataclass.dart';
import 'package:flutter/cupertino.dart';

@dataClass
class AllCodiClothing {
  List<dynamic> codiClothingList; //codiClothing객체들을 담음
  String codiImg; //코디 요청한 옷.대표이미지

  AllCodiClothing({this.codiClothingList, this.codiImg});

  Map<String, dynamic> toMap() {
    return {
      'codiClothingList': codiClothingList,
      'codiImg': codiImg,
    };
  }
}
