import 'package:flutter/material.dart';
import 'MainFeed.dart';

//raw-data
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
    proposedCodiList: [codiTotal1, codiTotal2],
    userId: "Yeji",
    explanation:
        '이 회색 가디건과 어울리는 코디 전체를 추천해주세요! 저는 여성스럽고 단정한 스타일을 좋아해요. 그리고 하의는 편한 밴딩으로 되어있는 스커트였으면 좋겠어요.');
