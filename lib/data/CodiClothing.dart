import 'MyClothing.dart';
import 'ProductClothing.dart';
import 'AllCodiClothing.dart';
import 'package:dataclass/dataclass.dart';
import 'package:flutter/cupertino.dart';

@dataClass
class CodiClothing {
  List<dynamic> codiClothes; //codi한 옷들이 배열로 들어옴
  String totalImg;//

  CodiClothing({this.codiClothes, this.totalImg});

  Map<String, dynamic> toMap() {
    return {
      'codiClothes': codiClothes,
      'totalImg': totalImg,
    };
  }
}
