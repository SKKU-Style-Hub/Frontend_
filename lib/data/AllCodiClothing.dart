import 'MyClothing.dart';
import 'ProductClothing.dart';
import 'CodiClothing.dart';
import 'package:dataclass/dataclass.dart';
import 'package:flutter/cupertino.dart';

@dataClass
class AllCodiClothing {
  List<dynamic> codiClothingListAI; //codiClothing for AI객체들을 담음
  List<dynamic> codiClothingListUser; //codiClothing for User객체들을 담음
  String codiImg; //코디 요청한 옷.대표이미지

  AllCodiClothing(
      {this.codiClothingListAI, this.codiClothingListUser, this.codiImg});

  Map<String, dynamic> toMap() {
    return {
      'codiClothingListAI': codiClothingListAI,
      'codiClothingListUser': codiClothingListUser,
      'codiImg': codiImg,
    };
  }
}
