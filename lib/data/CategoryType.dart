import 'package:dataclass/dataclass.dart';
import 'package:flutter/material.dart';
import 'package:stylehub_flutter/FittingRoom/FittingRoom.dart';

int categoryToType(String category) {
  //상의
  if (category == "탑" ||
      category == "블라우스" ||
      category == "니트웨어" ||
      category == "셔츠" ||
      category == "베스트") {
    return 1;
  }
  //하의
  if (category == "청바지" || category == "팬츠" || category == "스커트") {
    return 2;
  }
  //원피스
  if (category == "드레스" || category == "점프수트") {
    return 3;
  }
  //아우터
  if (category == "코트" ||
      category == "재킷" ||
      category == "점퍼" ||
      category == "패딩") {
    return 4;
  }
  //신발
  if (category == "신발") {
    return 5;
  }
  //가방
  if (category == "가방") {
    return 6;
  }
  return 0;
}
