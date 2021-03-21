import 'package:flutter/material.dart';
import 'package:stylehub_flutter/components/ClothInfo.dart';
import 'package:stylehub_flutter/data/MyClothing.dart';

import 'FittingRoom.dart';

MyClothing top1 =
    MyClothing(clothingImgBase64: "assets/images/top1.png", category: "탑");
MyClothing top2 =
    MyClothing(clothingImgBase64: "assets/images/top2.png", category: "탑");
MyClothing top3 = MyClothing(
    clothingImgBase64: "assets/images/sample_knit.png", category: "탑");

//하의 배열 만들기
MyClothing bottom1 = MyClothing(
    clothingImgBase64: "assets/images/sample_pants.png", category: "팬츠");
MyClothing bottom2 = MyClothing(
    clothingImgBase64: "assets/images/received_codi2_bottom.png",
    category: "팬츠");
MyClothing bottom3 = MyClothing(
    clothingImgBase64: "assets/images/received_codi1_bottom.png",
    category: "팬츠");

//신발 배열 만들기
MyClothing shoes1 = MyClothing(
    clothingImgBase64: "assets/images/received_codi2_shoes.png",
    category: "신발");
//가방
MyClothing bag1 = MyClothing(
    clothingImgBase64: "assets/images/received_codi1_bag.png", category: "가방");
MyClothing bag2 = MyClothing(
    clothingImgBase64: "assets/images/received_codi2_bag.png", category: "가방");
//아우터 배열 만들기
MyClothing outer1 = MyClothing(
    clothingImgBase64: "assets/images/received_codi1_outer.png",
    category: "코트");
MyClothing outer2 = MyClothing(
    clothingImgBase64: "assets/images/received_codi2_outer.png",
    category: "코트");
//원피스 배열 만들기
MyClothing onepiece1 = MyClothing(
    clothingImgBase64: "assets/images/onepiece1.png", category: "드레스");

void putRawData() {
  myClosetListTop = [];
  myClosetListBottom = [];
  myClosetListAcc = [];
  myClosetListOuter = [];
  myClosetListOnepiece = [];

  myClosetListTop.add(top1);
  myClosetListTop.add(top2);
  myClosetListTop.add(top3);
  myClosetListTop.add(top1);
  myClosetListTop.add(top1);
  myClosetListTop.add(top1);
  myClosetListTop.add(top1);

  myClosetListBottom.add(bottom1);
  myClosetListBottom.add(bottom2);
  myClosetListBottom.add(bottom3);

  myClosetListAcc.add(shoes1);
  myClosetListAcc.add(bag1);
  myClosetListAcc.add(bag2);

  myClosetListOuter.add(outer1);
  myClosetListOuter.add(outer2);

  myClosetListOnepiece.add(onepiece1);
}
