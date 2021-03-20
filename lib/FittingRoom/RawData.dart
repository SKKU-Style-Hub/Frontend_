import 'package:flutter/material.dart';
import 'FittingRoom.dart';

ClothInfo top1 = ClothInfo(
    brandname: "프롬비기닝",
    image: "assets/images/top1.png",
    price: 30000,
    clothname: "21AS Victoria Sweatshirt",
    type: 1);
ClothInfo top2 = ClothInfo(
    brandname: "H&M",
    image: "assets/images/top2.png",
    price: 35000,
    clothname: "21SS Unisex Tricolor Fox Patch Classic Marin",
    type: 1);
ClothInfo top3 = ClothInfo(
    brandname: "H&M",
    image: "assets/images/sample_knit.png",
    price: 40000,
    clothname: "21SS Unisex Tricolor Fox Patch Classic Marin",
    type: 1);

//하의 배열 만들기
ClothInfo bottom1 = ClothInfo(
    brandname: "ROEM",
    image: "assets/images/sample_pants.png",
    price: 50000,
    clothname: "PANT NAME1",
    type: 2);
ClothInfo bottom2 = ClothInfo(
    brandname: "MUSINSA",
    image: "assets/images/received_codi2_bottom.png",
    price: 55000,
    clothname: "PANT NAME2",
    type: 2);
ClothInfo bottom3 = ClothInfo(
    brandname: "FOFOFO",
    image: "assets/images/received_codi1_bottom.png",
    price: 55000,
    clothname: "PANT NAME3",
    type: 2);

//신발 배열 만들기
ClothInfo shoes1 = ClothInfo(
    brandname: "SHOEEE",
    image: "assets/images/received_codi2_shoes.png",
    price: 70000,
    clothname: "SHOES NAME1",
    type: 5);
//가방
ClothInfo bag1 = ClothInfo(
    brandname: "SHOEEE",
    image: "assets/images/received_codi1_bag.png",
    price: 70000,
    clothname: "BAG NAME1",
    type: 6);
ClothInfo bag2 = ClothInfo(
    brandname: "SHOEEE",
    image: "assets/images/received_codi2_bag.png",
    price: 70000,
    clothname: "BAG NAME1",
    type: 6);
//아우터 배열 만들기
ClothInfo outer1 = ClothInfo(
    brandname: "SHOEEE",
    image: "assets/images/received_codi1_outer.png",
    price: 100000,
    clothname: "OUTER NAME1",
    type: 4);
ClothInfo outer2 = ClothInfo(
    brandname: "SHOEEE",
    image: "assets/images/received_codi2_outer.png",
    price: 100000,
    clothname: "OUTER NAME2",
    type: 4);
//원피스 배열 만들기
ClothInfo onepiece1 = ClothInfo(
    brandname: "POPOPOP",
    image: "assets/images/onepiece1.png",
    price: 80000,
    clothname: "ONEPIECE NAME1",
    type: 3);

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
