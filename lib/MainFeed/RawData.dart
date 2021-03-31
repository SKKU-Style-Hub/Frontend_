import 'package:stylehub_flutter/data/ProposedCodi.dart';
import 'MainFeed.dart';
import 'CodiFittingRoom.dart';
import 'package:flutter/material.dart';
import 'package:stylehub_flutter/components/ClothInfo.dart';
import 'package:stylehub_flutter/data/AllCodiClothing.dart';
import 'package:stylehub_flutter/data/MyClothing.dart';
import 'package:stylehub_flutter/data/CodiClothing.dart';
import 'package:stylehub_flutter/data/ProductClothing.dart';

//raw-data
MyClothing basictop =
    MyClothing(clothingImgBase64: "assets/images/basictop.png", category: "탑");
MyClothing basicbottom = MyClothing(
    clothingImgBase64: "assets/images/basicbottom.png", category: "팬츠");

//기본 style.wish.buy정보
ClothSbw codi1_swb = ClothSbw(
    buy_name: "minhee99",
    buy_path: 'assets/mainfeed_person/codi1_outer_buy.jpg',
    style_name: "roro_",
    style_path: "assets/mainfeed_person/codi1_outer_style.jpg",
    wish_name: "asdfas",
    wish_path: 'assets/mainfeed_person/codi1_outer_wish.jpg');
ClothSbw codi2_swb = ClothSbw(
    buy_name: "minhee99",
    buy_path: 'assets/mainfeed_person/codi1_outer_buy.jpg',
    style_name: "roro_",
    style_path: "assets/mainfeed_person/codi1_outer_style.jpg",
    wish_name: "asdfas",
    wish_path: 'assets/mainfeed_person/codi1_outer_wish.jpg');

ClothSbw codi1_outer = ClothSbw(
    buy_name: "minhee99",
    buy_path: 'assets/mainfeed_person/codi1_outer_buy.jpg',
    style_name: "roro_",
    style_path: "assets/mainfeed_person/codi1_outer_style.jpg",
    wish_name: "asdfas",
    wish_path: 'assets/mainfeed_person/codi1_outer_wish.jpg');
ClothSbw codi1_top = ClothSbw(
    buy_name: "chungha",
    buy_path: 'assets/mainfeed_person/codi1_top_buy.jpg',
    style_name: "sdfasd",
    style_path: "assets/mainfeed_person/codi1_top_style.jpg",
    wish_name: "lololo",
    wish_path: 'assets/mainfeed_person/codi1_top_wish.jpg');
ClothSbw codi1_bottom = ClothSbw(
    buy_name: "jipga",
    buy_path: 'assets/mainfeed_person/codi1_bottom_buy.jpg',
    style_name: "whfflek",
    style_path: "assets/mainfeed_person/codi1_bottom_style.jpg",
    wish_name: "wlsWKWK",
    wish_path: 'assets/mainfeed_person/codi1_bottom_wish.jpg');
ClothSbw codi1_bag = ClothSbw(
    buy_name: "skssnrnrp",
    buy_path: 'assets/mainfeed_person/codi1_bag_buy.jpg',
    style_name: "ahfmwl",
    style_path: "assets/mainfeed_person/codi1_bag_style.jpg",
    wish_name: "SHEKE",
    wish_path: 'assets/mainfeed_person/codi1_bag_wish.jpg');
ClothSbw codi1_shoes = ClothSbw(
    buy_name: "fkfkfk",
    buy_path: 'assets/mainfeed_person/codi1_shoes_buy.jpg',
    style_name: "dksehoO",
    style_path: "assets/mainfeed_person/codi1_shoes_style.jpg",
    wish_name: "ziziziI",
    wish_path: 'assets/mainfeed_person/codi1_shoes_wish.jpg');

ClothSbw codi2_outer = ClothSbw(
    wish_name: "minhee99",
    wish_path: 'assets/mainfeed_person/codi1_outer_buy.jpg',
    buy_name: "roro_",
    buy_path: "assets/mainfeed_person/codi1_outer_style.jpg",
    style_name: "asdfas",
    style_path: 'assets/mainfeed_person/codi1_outer_wish.jpg');
ClothSbw codi2_top = ClothSbw(
    wish_name: "chungha",
    wish_path: 'assets/mainfeed_person/codi1_top_buy.jpg',
    buy_name: "sdfasd",
    buy_path: "assets/mainfeed_person/codi1_top_style.jpg",
    style_name: "lololo",
    style_path: 'assets/mainfeed_person/codi1_top_wish.jpg');
ClothSbw codi2_bottom = ClothSbw(
    wish_name: "jipga",
    wish_path: 'assets/mainfeed_person/codi1_bottom_buy.jpg',
    buy_name: "whfflek",
    buy_path: "assets/mainfeed_person/codi1_bottom_style.jpg",
    style_name: "wlsWKWK",
    style_path: 'assets/mainfeed_person/codi1_bottom_wish.jpg');
ClothSbw codi2_bag = ClothSbw(
    wish_name: "skssnrnrp",
    wish_path: 'assets/mainfeed_person/codi1_bag_buy.jpg',
    buy_name: "ahfmwl",
    buy_path: "assets/mainfeed_person/codi1_bag_style.jpg",
    style_name: "SHEKE",
    style_path: 'assets/mainfeed_person/codi1_bag_wish.jpg');
ClothSbw codi2_shoes = ClothSbw(
    wish_name: "fkfkfk",
    wish_path: 'assets/mainfeed_person/codi1_shoes_buy.jpg',
    buy_name: "dksehoO",
    buy_path: "assets/mainfeed_person/codi1_shoes_style.jpg",
    style_name: "ziziziI",
    style_path: 'assets/mainfeed_person/codi1_shoes_wish.jpg');

ProposedCodi codiTotal1 = ProposedCodi(
  codiImage: 'assets/request_codi/received_codi1_total.png',
  top: ProposedCodiElement(
    xCoordinate: 143,
    yCoordinate: 55,
    brandName: "ZARA",
    price: 59000,
    clothSbw: codi1_top,
  ),
  bottom: ProposedCodiElement(
    xCoordinate: 143,
    yCoordinate: 145,
    brandName: "Theory",
    price: 68100,
    clothSbw: codi1_bottom,
  ),
  outer: ProposedCodiElement(
    xCoordinate: 48,
    yCoordinate: 85,
    brandName: "kuho",
    price: 389000,
    clothSbw: codi1_outer,
  ),
  shoes: ProposedCodiElement(
    xCoordinate: 150,
    yCoordinate: 230,
    brandName: "BROOKS",
    price: 108000,
    clothSbw: codi1_shoes,
  ),
  bag: ProposedCodiElement(
    xCoordinate: 48,
    yCoordinate: 200,
    brandName: "kuho plus",
    price: 38000,
    clothSbw: codi1_bag,
  ),
);
ProposedCodi codiTotal2 = ProposedCodi(
  codiImage: 'assets/request_codi/received_codi2_total.png',
  top: ProposedCodiElement(
    xCoordinate: 48,
    yCoordinate: 50,
    brandName: "ZARA",
    price: 59000,
    clothSbw: codi2_top,
  ),
  bottom: ProposedCodiElement(
    xCoordinate: 48,
    yCoordinate: 140,
    brandName: "8seconds",
    price: 59900,
    clothSbw: codi2_bottom,
  ),
  outer: ProposedCodiElement(
    xCoordinate: 140,
    yCoordinate: 65,
    brandName: "Beanpole",
    price: 129000,
    clothSbw: codi2_outer,
  ),
  shoes: ProposedCodiElement(
    xCoordinate: 200,
    yCoordinate: 150,
    brandName: "RePLAiN",
    price: 138000,
    clothSbw: codi2_shoes,
  ),
  bag: ProposedCodiElement(
    xCoordinate: 135,
    yCoordinate: 150,
    brandName: "RePLAiN",
    price: 80000,
    clothSbw: codi2_bag,
  ),
);
AllProposedCodi allProposedCodi1 = new AllProposedCodi(
    requestClothingImg: 'assets/images/sample_knit.png',
    proposedCodiList: [codiTotal1, codiTotal2],
    userId: "Yeji",
    userProfile:
        'https://img4.yna.co.kr/photo/cms/2019/05/02/02/PCM20190502000402370_P2.jpg',
    explanation:
        '이 회색 가디건과 어울리는 코디 전체를 추천해주세요! 저는 여성스럽고 단정한 스타일을 좋아해요. 그리고 하의는 편한 밴딩으로 되어있는 스커트였으면 좋겠어요.');

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
