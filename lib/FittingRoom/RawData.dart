import 'package:flutter/material.dart';
import 'package:stylehub_flutter/components/ClothInfo.dart';
import 'package:stylehub_flutter/data/AllCodiClothing.dart';
import 'package:stylehub_flutter/data/MyClothing.dart';
import 'package:stylehub_flutter/data/CodiClothing.dart';
import 'package:stylehub_flutter/data/ProductClothing.dart';
import 'package:stylehub_flutter/FittingRoom/FittingRoom.dart';

MyClothing basictop =
    MyClothing(clothingImgBase64: "assets/images/basictop.png", category: "탑");
MyClothing basicbottom = MyClothing(
    clothingImgBase64: "assets/images/basicbottom.png", category: "팬츠");

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

ProductClothing codi1Top = ProductClothing(
  encoded_img: "assets/request_codi/received_codi1_top.png",
);
ProductClothing codi1Bottom = ProductClothing(
  encoded_img: "assets/request_codi/received_codi1_bottom.png",
);
ProductClothing codi1Outer = ProductClothing(
  encoded_img: "assets/request_codi/received_codi1_outer.png",
);
ProductClothing codi1Bag = ProductClothing(
  encoded_img: "assets/request_codi/received_codi1_bag.png",
);
ProductClothing codi1Shoes = ProductClothing(
  encoded_img: "assets/request_codi/received_codi1_shoes.png",
);

ProductClothing codi2Top = ProductClothing(
  encoded_img: "assets/request_codi/received_codi2_top.png",
);
ProductClothing codi2Bottom = ProductClothing(
  encoded_img: "assets/request_codi/received_codi2_bottom.png",
);
ProductClothing codi2Outer = ProductClothing(
  encoded_img: "assets/request_codi/received_codi2_outer.png",
);
ProductClothing codi2Bag = ProductClothing(
  encoded_img: "assets/request_codi/received_codi2_bag.png",
);
ProductClothing codi2Shoes = ProductClothing(
  encoded_img: "assets/request_codi/received_codi2_shoes.png",
);

CodiClothing tmpCodi1 = CodiClothing();
CodiClothing tmpCodi2 = CodiClothing();

AllCodiClothing tmpAllCodi = AllCodiClothing();

void putRawData() {
  //내옷장 rawdata
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
  //코디요청 rawdata
  tmpCodi1.codiClothes = [];
  tmpCodi2.codiClothes = [];
  //일단은 productclothing에 카테고리 분류가 없으니까 인덱스에 맞게 넣어두자
  tmpCodi1.codiClothes.add(null);
  tmpCodi1.codiClothes.add(codi1Top); //1
  tmpCodi1.codiClothes.add(codi1Bottom); //2
  tmpCodi1.codiClothes.add(null); //3
  tmpCodi1.codiClothes.add(codi1Outer); //4
  tmpCodi1.codiClothes.add(codi1Shoes); //5
  tmpCodi1.codiClothes.add(codi1Bag); //6
  tmpCodi1.totalImg = "assets/request_codi/received_codi1_total.png";

  tmpCodi2.codiClothes.add(null);
  tmpCodi2.codiClothes.add(codi2Top);
  tmpCodi2.codiClothes.add(codi2Bottom);
  tmpCodi2.codiClothes.add(null);
  tmpCodi2.codiClothes.add(codi2Outer);
  tmpCodi2.codiClothes.add(codi2Shoes);
  tmpCodi2.codiClothes.add(codi2Bag);
  tmpCodi2.totalImg = "assets/request_codi/received_codi2_total.png";

  tmpAllCodi.codiClothingListAI = [];
  tmpAllCodi.codiClothingListUser = [];
  tmpAllCodi.codiClothingListUser.add(tmpCodi1);
  tmpAllCodi.codiClothingListUser.add(tmpCodi2);
  tmpAllCodi.codiImg = "assets/request_codi/codi1.png";
}
