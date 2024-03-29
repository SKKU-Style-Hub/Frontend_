import 'package:dataclass/dataclass.dart';
import 'package:flutter/material.dart';
import 'package:codime/FittingRoom/FittingRoom.dart';

int categoryToType(String category) {
  //상의
  if (category == "탑" ||
      category == "블라우스" ||
      category == "니트웨어" ||
      category == "셔츠" ||
      category == "베스트" ||
      category == "상의") {
    return 1;
  }
  //하의
  if (category == "청바지" ||
      category == "팬츠" ||
      category == "스커트" ||
      category == "하의") {
    return 2;
  }
  //원피스
  if (category == "드레스" || category == "점프수트" || category == "원피스") {
    return 3;
  }
  //아우터
  if (category == "코트" ||
      category == "재킷" ||
      category == "점퍼" ||
      category == "패딩" ||
      category == "아우터") {
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

int categoryToProductType(String category) {
  //상의
  if (category.contains("탑") ||
      category.contains("블라우스") ||
      category.contains("니트웨어") ||
      category.contains("셔츠") ||
      category.contains("베스트") ||
      category.contains("상의")) {
    return 1;
  }
  //하의
  if (category.contains("청바지") ||
      category.contains("팬츠") ||
      category.contains("스커트") ||
      category.contains("하의")) {
    return 2;
  }
  //원피스
  if (category.contains("드레스") ||
      category.contains("점프수트") ||
      category.contains("원피스")) {
    return 3;
  }
  //아우터
  if (category.contains("코트") ||
      category.contains("재킷") ||
      category.contains("점퍼") ||
      category.contains("패딩") ||
      category.contains("아우터")) {
    return 4;
  }
  //신발
  if (category.contains("신발")) {
    return 5;
  }
  //가방
  if (category.contains("가방")) {
    return 6;
  }
  return 0;
}

String typeToCategory(int i) {
  //상의
  if (i == 1) {
    return "상의";
  }
  //하의
  if (i == 2) {
    return "하의";
  }
  //원피스
  if (i == 3) {
    return "원피스";
  }
  //아우터
  if (i == 4) {
    return "아우터";
  }
  //신발
  if (i == 5) {
    return "신발";
  }
  //가방
  if (i == 6) {
    return "가방";
  }
  return "상의";
}
