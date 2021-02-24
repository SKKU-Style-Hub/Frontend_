import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:drag_to_expand/drag_to_expand.dart';
import 'package:stylehub_flutter/RequestCodi/Checkcodi.dart';
import 'package:stylehub_flutter/data/MyClothing.dart';
import 'package:stylehub_flutter/data/MyClothingDatabase.dart';
import 'ProductDetail.dart';
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/rendering.dart';

//화면에 이미 선택된 옷
String selected_top = "assets/images/sample_knit.png";
String selected_bottom = 'assets/images/sample_pants.png';
String selected_shoes = ""; //'assets/images/sample_shoes.png'
String selected_onepiece = 'assets/images/sample_shoes.png';
String selected_outer;
String selected_bag;
//아우터 배치는 어떤 식으로 해야될지 모르겠어서 안해놓음.

//첫 화면 배치offset
double top_offset_x = 113;
double top_offset_y = 30;
double bottom_offset_x = 113;
double bottom_offset_y = 155;
double shoes_offset_x = 280;
double shoes_offset_y = 280;
double onepiece_offset_x = 113;
double onepiece_offset_y = 30;
double outer_offset_x = -10;
double outer_offset_y = 30;
double bag_offset_x = 280;
double bag_offset_y = 150;

//어떤 옷인가요?//1이면 선택 0이면 선택x
int top_yesno = 1;
int bottom_yesno = 1;
int shoes_yesno = 1;
int outer_yesno = 0;
int onepiece_yesno = 0;
int bag_yesno = 0;

int select_index = 0; //0은 내옷장, 1은 코디들을 의미

double swipeStartY;
String swipeDirection;
double bottomsheet_size = 200;
Axis bottomsheet_axis = Axis.horizontal;

List<dynamic> recommended_top = [];
List<dynamic> recommended_pants = [];
List<dynamic> recommended_shoes = [];
List<dynamic> recommended_outer = [];
List<dynamic> recommended_onepiece = [];

List<MyClothing> mycloset_top = [];
List<MyClothing> mycloset_pants = [];
List<MyClothing> mycloset_shoes = [];
List<MyClothing> mycloset_outer = [];
List<MyClothing> mycloset_onepiece = [];

List<dynamic> codi1 = [];
List<dynamic> codi2 = [];
List<dynamic> codi3 = [];
List<dynamic> codis = [];

//코디 정보를 가지고 있느 객체
class Cloth_info {
  String imagepath;
  int price;
  String brandname;
  String clothname;
  Cloth_info(
      {String brandname, String clothname, String imagepath, int price}) {
    this.brandname = brandname;
    this.clothname = clothname;
    this.imagepath = imagepath;
    this.price = price;
  }
}

class Codi_clothes {
  Cloth_info top, bottom, shoes, outer, onepiece, bag;
  String total_path;

  //유무는 null로 판단
  Codi_clothes({
    this.top,
    this.bottom,
    this.shoes,
    this.outer,
    this.onepiece,
    this.bag,
    this.total_path,
  }) {}
}

class Codi_lists {
  List ai; //ai추천
  List user; //유저추천
  List shop; //판매자추천
  Codi_lists({this.ai, this.user, this.shop}) {}
}

class FittingRoomForm extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "피팅룸",
      home: Fittingroom(),
    );
  }
} //end of Myapp

class Fittingroom extends StatelessWidget {
  Fittingroom(
      {Key key,
      String selected_top1,
      String selected_bottom1,
      String selected_shoes1,
      String selected_onepiece1,
      String selected_outer1})
      : super(key: key) {
    selected_top = selected_top1;
    selected_bottom = selected_bottom1;
    selected_shoes = selected_shoes1;
    selected_onepiece = selected_onepiece1;
    selected_outer = selected_outer1;
    select_index = 0;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Image.asset(
            "assets/applogo.png",
            //width: 115,
            alignment: Alignment.center,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Fittingroom_main(),
    );
  }
}

class Fittingroom_main extends StatefulWidget {
  int selected_index_bycodi = 0;
  Fittingroom_main({int selected_index}) {
    if (selected_index != null) {
      //코디에서 넘어온 index
      selected_index_bycodi = selected_index;
    }
  }
  _Fittingroom_mainState createState() {
    top_offset_x = 113;
    top_offset_y = 30;
    bottom_offset_x = 113;
    bottom_offset_y = 155;
    shoes_offset_x = 280;
    shoes_offset_y = 280;
    if (CheckCodi.checkCodi == 1) select_index = 0;
    return _Fittingroom_mainState();
  }
}

class _Fittingroom_mainState extends State<Fittingroom_main> {
  DragToExpandController _dragToExpandController2;
  List<Color> select_color = [Colors.black, Colors.grey[600]];

  @override
  void initState() {
    //select_index = 0;

    select_index = widget.selected_index_bycodi; //1 or 2 or 3
    if (select_index == 0) //내 옷장
    {
    } else if (select_index >= 1) //코디1
    {
      if (codis[select_index - 1][0].top != null) {
        selected_top = codis[select_index - 1][0].top.imagepath;
        top_yesno = 1;
        print("top");
      } else {
        top_yesno = 0;
      }
      if (codis[select_index - 1][0].bottom != null) {
        selected_bottom = codis[select_index - 1][0].bottom.imagepath;
        bottom_yesno = 1;
      } else {
        bottom_yesno = 0;
      }
      if (codis[select_index - 1][0].shoes != null) {
        selected_shoes = codis[select_index - 1][0].shoes.imagepath;
        shoes_yesno = 1;
      } else {
        shoes_yesno = 0;
      }
      if (codis[select_index - 1][0].outer != null) {
        selected_outer = codis[select_index - 1][0].outer.imagepath;
        outer_yesno = 1;
      } else {
        outer_yesno = 0;
      }
      if (codis[select_index - 1][0].onepiece != null) {
        selected_onepiece = codis[select_index - 1][0].onepiece.imagepath;
        onepiece_yesno = 1;
      } else {
        onepiece_yesno = 0;
      }
      if (codis[select_index - 1][0].bag != null) {
        selected_bag = codis[select_index - 1][0].bag.imagepath;
        bag_yesno = 1;
      } else {
        bag_yesno = 0;
      }
    }
    _dragToExpandController2 = DragToExpandController();

    getCloset();
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  void getCloset() async {
    mycloset_top = await MyClothingDatabase.getTop();
    mycloset_pants = await MyClothingDatabase.getBottom();
    mycloset_onepiece = await MyClothingDatabase.getOnePiece();
    mycloset_outer = await MyClothingDatabase.getOuter();

    selected_top = mycloset_top[0].clothingImgBase64;
    selected_bottom = mycloset_pants[2].clothingImgBase64;
    //selected_shoes = mycloset_onepiece[0].clothingImgBase64;
  }

  Widget build(BuildContext context) {
    //getCloset();
    print(build);

    ///여기다가 배열에 추가하는 코드 넣기
    ///recommended_top = [];
    recommended_pants = [];
    recommended_shoes = [];
    recommended_outer = [];
    recommended_onepiece = [];
    //상의 배열 만들기
    Cloth_info top1 = Cloth_info(
        brandname: "프롬비기닝",
        imagepath: "assets/images/top1.png",
        price: 30000,
        clothname: "21AS Victoria Sweatshirt");
    Cloth_info top2 = Cloth_info(
        brandname: "H&M",
        imagepath: "assets/images/top2.png",
        price: 35000,
        clothname: "21SS Unisex Tricolor Fox Patch Classic Marin");
    recommended_top.add(top1);
    recommended_top.add(top2);
    //하의 배열 만들기
    Cloth_info bottom1 = Cloth_info(
        brandname: "ROEM",
        imagepath: "assets/images/sample_pants.png",
        price: 50000,
        clothname: "PANT NAME1");
    Cloth_info bottom2 = Cloth_info(
        brandname: "MUSINSA",
        imagepath: "assets/images/pants1.png",
        price: 55000,
        clothname: "PANT NAME2");
    Cloth_info bottom3 = Cloth_info(
        brandname: "FOFOFO",
        imagepath: "assets/images/pants2.png",
        price: 55000,
        clothname: "PANT NAME3");
    recommended_pants.add(bottom1);
    recommended_pants.add(bottom2);
    recommended_pants.add(bottom3);
    //신발 배열 만들기
    Cloth_info shoes1 = Cloth_info(
        brandname: "SHOEEE",
        imagepath: "assets/images/sample_shoes.png",
        price: 70000,
        clothname: "SHOES NAME1");
    recommended_shoes.add(shoes1);
    //아우터 배열 만들기
    Cloth_info outer1 = Cloth_info(
        brandname: "SHOEEE",
        imagepath: "assets/images/outer1.png",
        price: 100000,
        clothname: "OUTER NAME1");
    Cloth_info outer2 = Cloth_info(
        brandname: "SHOEEE",
        imagepath: "assets/images/outer2.png",
        price: 100000,
        clothname: "OUTER NAME2");
    recommended_outer.add(outer1);
    recommended_outer.add(outer2);
    //원피스 배열 만들기
    Cloth_info onepiece1 = Cloth_info(
        brandname: "POPOPOP",
        imagepath: "assets/images/onepiece1.png",
        price: 80000,
        clothname: "ONEPIECE NAME1");
    recommended_onepiece.add(onepiece1);

    //코디 배열 만들기
    codi1 = [];
    codi2 = [];
    codi3 = [];
    Codi_clothes codi1_1 = Codi_clothes(
        top: Cloth_info(
            imagepath: "assets/request_codi/received_codi1_top.png",
            price: 147250,
            brandname: "MAISON KITSUNE",
            clothname:
                "21SS ★황민현 착용★ Unisex Tee-Shirt Double Fox Head Patch - Ivory"),
        outer: Cloth_info(
            imagepath: "assets/request_codi/received_codi1_outer.png",
            price: 147250,
            brandname: "MAISON KITSUNE",
            clothname:
                "21SS ★황민현 착용★ Unisex Tee-Shirt Double Fox Head Patch - Ivory"),
        bottom: Cloth_info(
            imagepath: "assets/request_codi/received_codi1_bottom.png",
            price: 147250,
            brandname: "MAISON KITSUNE",
            clothname:
                "21SS ★황민현 착용★ Unisex Tee-Shirt Double Fox Head Patch - Ivory"),
        shoes: Cloth_info(
            imagepath: "assets/request_codi/received_codi1_shoes.png",
            price: 147250,
            brandname: "MAISON KITSUNE",
            clothname:
                "21SS ★황민현 착용★ Unisex Tee-Shirt Double Fox Head Patch - Ivory"),
        total_path: "assets/request_codi/received_codi1_total.png",
        bag: Cloth_info(
            imagepath: "assets/request_codi/received_codi1_bag.png",
            price: 147250,
            brandname: "MAISON KITSUNE",
            clothname:
                "21SS ★황민현 착용★ Unisex Tee-Shirt Double Fox Head Patch - Ivory"));
    Codi_clothes codi1_2 = Codi_clothes(
        top: Cloth_info(
            imagepath: "assets/request_codi/received_codi2_top.png",
            price: 147250,
            brandname: "MAISON KITSUNE",
            clothname:
                "21SS ★황민현 착용★ Unisex Tee-Shirt Double Fox Head Patch - Ivory"),
        outer: Cloth_info(
            imagepath: "assets/request_codi/received_codi2_outer.png",
            price: 147250,
            brandname: "MAISON KITSUNE",
            clothname:
                "21SS ★황민현 착용★ Unisex Tee-Shirt Double Fox Head Patch - Ivory"),
        bottom: Cloth_info(
            imagepath: "assets/request_codi/received_codi2_bottom.png",
            price: 147250,
            brandname: "MAISON KITSUNE",
            clothname:
                "21SS ★황민현 착용★ Unisex Tee-Shirt Double Fox Head Patch - Ivory"),
        shoes: Cloth_info(
            imagepath: "assets/request_codi/received_codi2_shoes.png",
            price: 147250,
            brandname: "MAISON KITSUNE",
            clothname:
                "21SS ★황민현 착용★ Unisex Tee-Shirt Double Fox Head Patch - Ivory"),
        total_path: "assets/request_codi/received_codi2_total.png",
        bag: Cloth_info(
            imagepath: "assets/request_codi/received_codi2_bag.png",
            price: 147250,
            brandname: "MAISON KITSUNE",
            clothname:
                "21SS ★황민현 착용★ Unisex Tee-Shirt Double Fox Head Patch - Ivory"));
    codi1.add(codi1_1);
    codi1.add(codi1_2);
    Codi_clothes codi2_1 = Codi_clothes(
      top: Cloth_info(
          imagepath: "assets/images/sample_knit.png",
          price: 147250,
          brandname: "MAISON KITSUNE",
          clothname:
              "21SS ★황민현 착용★ Unisex Tee-Shirt Double Fox Head Patch - Ivory"),
      bottom: Cloth_info(
          imagepath: "assets/images/sample_pants.png",
          price: 147250,
          brandname: "MAISON KITSUNE",
          clothname:
              "21SS ★황민현 착용★ Unisex Tee-Shirt Double Fox Head Patch - Ivory"),
      shoes: Cloth_info(
          imagepath: "assets/images/sample_shoes.png",
          price: 147250,
          brandname: "MAISON KITSUNE",
          clothname:
              "21SS ★황민현 착용★ Unisex Tee-Shirt Double Fox Head Patch - Ivory"),
    );
    codi2.add(codi2_1);
    Codi_clothes codi3_1 = Codi_clothes(
      top: Cloth_info(
          imagepath: "assets/images/top2.png",
          price: 147250,
          brandname: "MAISON KITSUNE",
          clothname:
              "21SS ★황민현 착용★ Unisex Tee-Shirt Double Fox Head Patch - Ivory"),
      bottom: Cloth_info(
          imagepath: "assets/images/pants3.png",
          price: 147250,
          brandname: "MAISON KITSUNE",
          clothname:
              "21SS ★황민현 착용★ Unisex Tee-Shirt Double Fox Head Patch - Ivory"),
      shoes: Cloth_info(
          imagepath: "assets/images/sample_shoes.png",
          price: 147250,
          brandname: "MAISON KITSUNE",
          clothname:
              "21SS ★황민현 착용★ Unisex Tee-Shirt Double Fox Head Patch - Ivory"),
    );
    codi3.add(codi3_1);

    codis = [codi1, codi2, codi3];

    //Scaffold 시작
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //배경
          Positioned(
            child: Image.asset('assets/images/background_ui.png'),
          ),

          //화면에 하의
          draggablewidget(
            offset_x: bottom_offset_x,
            offset_y: bottom_offset_y,
            type: 2,
            selected_imagepath: selected_bottom,
            width_: 180,
            //height_: 320,
          ),
          //화면에 상의
          draggablewidget(
            offset_x: top_offset_x,
            offset_y: top_offset_y,
            type: 1,
            selected_imagepath: selected_top,
            width_: 180,
            //height_: 190,
          ),
          //화면에 신발
          draggablewidget(
            offset_x: shoes_offset_x,
            offset_y: shoes_offset_y,
            type: 5,
            selected_imagepath: selected_shoes,
            width_: 80,
            //height_: 150,
          ),
          //화면에 아우터
          draggablewidget(
            offset_x: outer_offset_x,
            offset_y: outer_offset_y,
            type: 4,
            selected_imagepath: selected_outer,
            width_: 220,
            //height_: 150,
          ),
          //화면에 가방
          draggablewidget(
            offset_x: bag_offset_x,
            offset_y: bag_offset_y,
            type: 6,
            selected_imagepath: selected_bag,
            width_: 120,
            //height_: 150,
          ),
          //-------------bottomsheet---------------
          Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onVerticalDragStart: (details) {
                  swipeStartY = details.globalPosition.dy;
                },
                onVerticalDragUpdate: (details) {
                  setState(() {
                    swipeDirection = (details.globalPosition.dy < swipeStartY)
                        ? "Up"
                        : "Down";
                  });
                },
                onVerticalDragEnd: (details) {
                  if (swipeDirection == "Down" && bottomsheet_size == 200) {
                    print("한번더 내려가게");
                    _dragToExpandController2.toggle();
                  }
                  if (swipeDirection == "Up") {
                    bottomsheet_size = 350;
                    bottomsheet_axis = Axis.vertical;
                  } else if (swipeDirection == "Down") {
                    bottomsheet_size = 200;
                    bottomsheet_axis = Axis.horizontal;
                  }
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DragToExpand(
                      controller: _dragToExpandController2,
                      minSize: 0,
                      maxSize: bottomsheet_size,
                      baseSide: BaseSide.bottom,
                      toggleOnTap: true,
                      draggable: Container(
                        height: 40,
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0))),
                            child: Center(
                              child: Text(
                                '다른 옷 가져오기',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      ),
                      draggableWhenOpened: Container(
                        height: 100,
                        width: 10,
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0))),
                            child: Center(
                              //=-------first tab menu start---------
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  firsttabmenu(
                                      name: "내 옷장", index: 0), //0은 내 옷장 의미
                                  firsttabmenu(
                                      name: "codi1",
                                      index: 1,
                                      imagepath:
                                          "assets/request_codi/received_codi1_top.png"), //1은 코디 1 의미
                                  firsttabmenu(
                                      name: "codi2",
                                      index: 2,
                                      imagepath:
                                          "assets/images/sample_knit.png"), //2은 코디 2 의미
                                  firsttabmenu(
                                      name: "codi3",
                                      index: 3,
                                      imagepath:
                                          "assets/images/top2.png"), //2은 코디 3 의미
                                ],
                              ),
                            )),
                      ),
                      //------------tab아래에 들어갈 내용
                      child: Container(
                        color: Colors.transparent,
                        child: Builder(
                          // ignore: missing_return
                          builder: (BuildContext context) {
                            if (select_index >= 1) {
                              //codi에서 받아온 거는 123순서라..
                              //코디 요청서 결과에서 받아오기
                              List intab_widgets_0 = [
                                intabWidget_codiForm(
                                  codi_list: [],
                                ),
                                intabWidget_codiForm(
                                  codi_list: codis[select_index - 1],
                                ),
                                intabWidget_codiForm(
                                  codi_list: [],
                                ),
                              ];
                              return tabWidget_codi(
                                  intab_widgets: intab_widgets_0);
                            } else if (select_index == 0) {
                              //내옷장에서 받아오기
                              List intab_widgets_1 = [
                                intabWidget_myclosetForm(
                                  recommended_list: mycloset_top,
                                  what_type: 1,
                                ),
                                //-------------pants
                                intabWidget_myclosetForm(
                                  recommended_list: mycloset_pants,
                                  what_type: 2,
                                ),
                                //-------------onepiece
                                intabWidget_myclosetForm(
                                  recommended_list: mycloset_onepiece,
                                  what_type: 3,
                                ),
                                //-----------outer
                                intabWidget_myclosetForm(
                                  recommended_list: mycloset_outer,
                                  what_type: 4,
                                ),
                                //--------------shoes
                                intabWidget_myclosetForm(
                                  recommended_list: mycloset_shoes,
                                  what_type: 5,
                                )
                              ];
                              return tabWidget_mycloset(
                                  intab_widgets: intab_widgets_1);
                            }
                          },
                        ),
                      ),
                    )),
              )),
        ],
      ),
    );
  }

  //here

  Widget intabWidget_codiForm({List codi_list}) {
    return GestureDetector(
      onVerticalDragStart: (details) {
        setState(() {
          swipeStartY = details.globalPosition.dy;
        });
      },
      onVerticalDragUpdate: (details) {
        setState(() {
          swipeDirection =
              (details.globalPosition.dy < swipeStartY) ? "Up" : "Down";
        });
      },
      onVerticalDragEnd: (details) {
        setState(() {
          if (swipeDirection == "Down" && bottomsheet_size == 200) {
            print("한번더 내려가게");
            _dragToExpandController2.toggle();
          }
          if (swipeDirection == "Down") {
            bottomsheet_size = 200;
            bottomsheet_axis = Axis.horizontal;
            print("Down");
          }
          if (swipeDirection == "Up") {
            bottomsheet_size = 350;
            bottomsheet_axis = Axis.vertical;
            print("up");
          }
        });
      },
      child: intabWidget_codi(codi_list: codi_list),
    );
  }

  //codi위젯을 listview로 나타낸 것
  Widget intabWidget_codi({List codi_list}) {
    if (bottomsheet_axis == Axis.horizontal) {
      return ListView(
        scrollDirection: bottomsheet_axis,
        children: List.generate(codi_list.length, (idx) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: InkWell(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  border: Border.all(width: 1, color: Colors.black26),
                ),
                child: Image.asset(
                  codi_list[idx].total_path == null
                      ? codi_list[idx].top.imagepath
                      : codi_list[idx].total_path,
                  width: 150,
                  height: 203,
                  colorBlendMode: BlendMode.srcOut,
                ),
              ),
              onTap: () async {
                //누르면 화면상에서 바뀌게 하자!!!!!!
                setState(() {
                  if (codi_list[idx].top != null) //상의
                  {
                    selected_top = codi_list[idx].top.imagepath;
                    top_yesno = 1;
                  } else {
                    top_yesno = 0;
                  }
                  if (codi_list[idx].bottom != null) //하의
                  {
                    selected_bottom = codi_list[idx].bottom.imagepath;
                    bottom_yesno = 1;
                  } else {
                    bottom_yesno = 0;
                  }
                  if (codi_list[idx].onepiece != null) //원피스
                  {
                    selected_onepiece = codi_list[idx].onepiece.imagepath;
                    onepiece_yesno = 1;
                  } else {
                    onepiece_yesno = 0;
                  }
                  if (codi_list[idx].outer != null) //아우터
                  {
                    selected_outer = codi_list[idx].outer.imagepath;
                    outer_yesno = 1;
                  } else {
                    outer_yesno = 0;
                  }
                  if (codi_list[idx].shoes != null) //신발
                  {
                    selected_shoes = codi_list[idx].shoes.imagepath;
                    shoes_yesno = 1;
                  } else {
                    shoes_yesno = 0;
                  }
                  if (codi_list[idx].bag != null) //가방
                  {
                    selected_bag = codi_list[idx].bag.imagepath;
                    bag_yesno = 1;
                  } else {
                    bag_yesno = 0;
                  }
                });
              },
              onLongPress: () {
                //옷 이미지, 가격, 이름 받아오기
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      List tmp = [];
                      if (codi_list[idx].top != null) //상의
                      {
                        tmp.add(codi_list[idx].top);
                      }
                      if (codi_list[idx].bottom != null) //하의
                      {
                        tmp.add(codi_list[idx].bottom);
                      }
                      if (codi_list[idx].onepiece != null) //원피스
                      {
                        tmp.add(codi_list[idx].onepiece);
                      }
                      if (codi_list[idx].outer != null) //아우터
                      {
                        tmp.add(codi_list[idx].outer);
                      }
                      if (codi_list[idx].shoes != null) //신발
                      {
                        tmp.add(codi_list[idx].shoes);
                      }
                      if (codi_list[idx].bag != null) //가방
                      {
                        tmp.add(codi_list[idx].bag);
                      }
                      return AlertDialog(
                        content: ProductDetail(
                          codi_clothes: tmp,
                        ),
                      );
                    });
              },
            ),
          );
        }),
      );
    }
    if (bottomsheet_axis == Axis.vertical) {
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(codi_list.length, (idx) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  border: Border.all(width: 1, color: Colors.black26),
                ),
                child: Image.asset(
                  codi_list[idx].total_path == null
                      ? codi_list[idx].top.imagepath
                      : codi_list[idx].total_path,
                  width: 150,
                  height: 203,
                  colorBlendMode: BlendMode.srcOut,
                ),
              ),
              onTap: () async {
                //누르면 화면상에서 바뀌게 하자!!!!!!
                setState(() {
                  if (codi_list[idx].top.imagepath != null) //상의
                  {
                    selected_top = codi_list[idx].top.imagepath;
                    top_yesno = 1;
                  } else {
                    top_yesno = 0;
                  }
                  if (codi_list[idx].bottom.imagepath != null) //하의
                  {
                    selected_bottom = codi_list[idx].bottom.imagepath;
                    bottom_yesno = 1;
                  } else {
                    bottom_yesno = 0;
                  }
                  if (codi_list[idx].onepiece.imagepath != null) //원피스
                  {
                    selected_onepiece = codi_list[idx].onepiece.imagepath;
                    onepiece_yesno = 1;
                  } else {
                    onepiece_yesno = 0;
                  }
                  if (codi_list[idx].outer.imagepath != null) //아우터
                  {
                    selected_outer = codi_list[idx].outer.imagepath;
                    outer_yesno = 1;
                  } else {
                    outer_yesno = 0;
                  }
                  if (codi_list[idx].shoes.imagepath != null) //신발
                  {
                    selected_shoes = codi_list[idx].shoes.imagepath;
                    shoes_yesno = 1;
                  } else {
                    shoes_yesno = 0;
                  }
                  if (codi_list[idx].bag.imagepath != null) //가방
                  {
                    selected_bag = codi_list[idx].bag.imagepath;
                    bag_yesno = 1;
                  } else {
                    bag_yesno = 0;
                  }
                });
              },
              onLongPress: () {
                //옷 이미지, 가격, 이름 받아오기
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      List tmp = [];
                      if (codi_list[idx].top != null) //상의
                      {
                        tmp.add(codi_list[idx].top);
                      }
                      if (codi_list[idx].bottom != null) //하의
                      {
                        tmp.add(codi_list[idx].bottom);
                      }
                      if (codi_list[idx].onepiece != null) //원피스
                      {
                        tmp.add(codi_list[idx].onepiece);
                      }
                      if (codi_list[idx].outer != null) //아우터
                      {
                        tmp.add(codi_list[idx].outer);
                      }
                      if (codi_list[idx].shoes != null) //신발
                      {
                        tmp.add(codi_list[idx].shoes);
                      }
                      if (codi_list[idx].bag != null) //가방
                      {
                        tmp.add(codi_list[idx].bag);
                      }
                      return AlertDialog(
                        content: ProductDetail(
                          codi_clothes: tmp,
                        ),
                      );
                    });
              },
            ),
          );
        }),
      );
    }
  }

  Widget intabWidget_myclosetForm({int what_type, List recommended_list}) {
    return GestureDetector(
      onVerticalDragStart: (details) {
        setState(() {
          swipeStartY = details.globalPosition.dy;
        });
      },
      onVerticalDragUpdate: (details) {
        setState(() {
          swipeDirection =
              (details.globalPosition.dy < swipeStartY) ? "Up" : "Down";
        });
      },
      onVerticalDragEnd: (details) {
        setState(() {
          if (swipeDirection == "Down" && bottomsheet_size == 200) {
            print("한번더 내려가게");
            _dragToExpandController2.toggle();
          }
          if (swipeDirection == "Up") {
            bottomsheet_size = 350;
            bottomsheet_axis = Axis.vertical;
          } else if (swipeDirection == "Down") {
            bottomsheet_size = 200;
            bottomsheet_axis = Axis.horizontal;
          }
        });
      },
      child: intabWidget_mycloset(
          recommended_list: recommended_list, what_type: what_type),
    );
  }

  //하위 탭의 옷들 listview로 나타낸 것
  Widget intabWidget_mycloset({int what_type, List recommended_list}) {
    if (bottomsheet_axis == Axis.horizontal) {
      return ListView(
          scrollDirection: bottomsheet_axis,
          children: List.generate(recommended_list.length, (idx) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    border: Border.all(width: 1, color: Colors.black26),
                  ),
                  child: Image.memory(
                    base64Decode(recommended_list[idx].clothingImgBase64),
                    width: 100,
                    height: 100,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                onTap: () async {
                  setState(() {
                    if (what_type == 1) //상의
                    {
                      selected_top = recommended_list[idx].clothingImgBase64;
                    } else if (what_type == 2) //하의
                    {
                      selected_bottom = recommended_list[idx].clothingImgBase64;
                    } else if (what_type == 3) //원피스
                    {
                      selected_onepiece =
                          recommended_list[idx].clothingImgBase64;
                    } else if (what_type == 4) //하의
                    {
                      selected_outer = recommended_list[idx].clothingImgBase64;
                    } else if (what_type == 5) //신발
                    {
                      selected_shoes = recommended_list[idx].clothingImgBase64;
                    }
                  });
                },
              ),
            );
          }));
    } else {
      return GridView.count(
          crossAxisCount: 3,
          children: List.generate(recommended_list.length, (idx) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    border: Border.all(width: 1, color: Colors.black26),
                  ),
                  child: Image.memory(
                    base64Decode(recommended_list[idx].clothingImgBase64),
                    width: 100,
                    height: 100,
                    fit: BoxFit.scaleDown,
                    //colorBlendMode: BlendMode.srcOut,
                  ),
                ),
                onTap: () async {
                  setState(() {
                    if (what_type == 1) //상의
                    {
                      selected_top = recommended_list[idx].clothingImgBase64;
                    } else if (what_type == 2) //하의
                    {
                      selected_bottom = recommended_list[idx].clothingImgBase64;
                    } else if (what_type == 3) //원피스
                    {
                      selected_onepiece =
                          recommended_list[idx].clothingImgBase64;
                    } else if (what_type == 4) //하의
                    {
                      selected_outer = recommended_list[idx].clothingImgBase64;
                    } else if (what_type == 5) //신발
                    {
                      selected_shoes = recommended_list[idx].clothingImgBase64;
                    }
                  });
                },
                // onLongPress: () {
                //   //옷 이미지, 가격, 이름 받아오기
                //   showDialog(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return AlertDialog(
                //           content: ProductDetail(
                //             codi_clothes: [
                //               Cloth_info(
                //                   imagepath: recommended_list[idx].imagepath,
                //                   brandname: recommended_list[idx].brandname,
                //                   clothname: recommended_list[idx].clothname,
                //                   price: recommended_list[idx].price)
                //             ],
                //           ),
                //         );
                //       });
                // },
              ),
            );
          }));
    }
  }

  //코디관련 하위탭
  Widget tabWidget_codi({List intab_widgets}) {
    return Container(
        height: 200,
        color: Colors.transparent,
        child: DefaultTabController(
          length: 3, //유저, ai, 판매자
          child: Scaffold(
            appBar: TabBar(
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              //indicatorSize: TabBarIndicatorSize.label,
              tabs: const <Widget>[
                Tab(
                  child: Text("AI", style: TextStyle(fontSize: 15.0)),
                ),
                Tab(
                  child: Text('유저', style: TextStyle(fontSize: 15.0)),
                ),
                Tab(
                  //icon: Icon(Icons.looks_3),
                  child: Text('판매자', style: TextStyle(fontSize: 15.0)),
                ),
              ],
            ),
            body: TabBarView(
              children: <Widget>[
                //------------------코디1
                intab_widgets[0],
                //-------------코디2
                intab_widgets[1],
                //-------------코디3
                intab_widgets[2],
              ],
            ),
          ),
        ));
  }

  //내옷장 관련 하위탭
  Widget tabWidget_mycloset({List intab_widgets}) {
    return Container(
        height: 200,
        color: Colors.transparent,
        child: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: TabBar(
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              //indicatorSize: TabBarIndicatorSize.label,
              tabs: const <Widget>[
                Tab(
                  child: Text("상의", style: TextStyle(fontSize: 15.0)),
                ),
                Tab(
                  child: Text('하의', style: TextStyle(fontSize: 15.0)),
                ),
                Tab(
                  //icon: Icon(Icons.looks_3),
                  child: Text('원피스', style: TextStyle(fontSize: 15.0)),
                ),
                Tab(
                  child: Text('아우터', style: TextStyle(fontSize: 15.0)),
                ),
                Tab(
                  child: Text('신발', style: TextStyle(fontSize: 15.0)),
                ),
              ],
            ),
            body: TabBarView(
              children: <Widget>[
                //------------------top
                intab_widgets[0],
                //-------------pants
                intab_widgets[1],
                //-------------onepiece
                intab_widgets[2],
                //-----------outer
                intab_widgets[3],
                //--------------shoes
                intab_widgets[4],
              ],
            ),
          ),
        ));
  }

  //draggablewidget
  Widget draggablewidget(
      {double offset_x,
      double offset_y,
      int type,
      String selected_imagepath,
      double width_,
      double height_}) {
    int yesno = 0;
    if (type == 1 && top_yesno == 1) {
      yesno = 1;
    } else if (type == 2 && bottom_yesno == 1) {
      yesno = 1;
    } else if (type == 3 && onepiece_yesno == 1) {
      yesno = 1;
    } else if (type == 4 && outer_yesno == 1) {
      yesno = 1;
    } else if (type == 5 && shoes_yesno == 1) {
      yesno = 1;
    } else if (type == 6 && bag_yesno == 1) {
      yesno = 1;
    }
    if (yesno == 1) {
      return Positioned(
        left: offset_x,
        top: offset_y,
        child: Draggable(
          child: SizedBox(
            width: width_,
            child: Image.memory(
              base64Decode(selected_imagepath),
              width: width_,
              height: height_,
              fit: BoxFit.fitWidth,
              //colorBlendMode: BlendMode.srcOut,
            ),
          ),
          feedback: Image.memory(
            base64Decode(selected_imagepath),
            width: width_,
            height: height_,
            fit: BoxFit.fitWidth,
            //colorBlendMode: BlendMode.srcOut,
          ),
          childWhenDragging: Text(" "),
          onDragEnd: (DraggableDetails details) {
            setState(() {
              if (type == 1) //상의
              {
                top_offset_x = details.offset.dx;
                top_offset_y = details.offset.dy - 80;
              } else if (type == 2) //하의
              {
                bottom_offset_x = details.offset.dx;
                bottom_offset_y = details.offset.dy - 80;
              } else if (type == 3) //원피스
              {
                onepiece_offset_x = details.offset.dx;
                onepiece_offset_y = details.offset.dy - 80;
              } else if (type == 4) //아우터
              {
                outer_offset_x = details.offset.dx;
                outer_offset_y = details.offset.dy - 80;
              } else if (type == 5) //신발
              {
                shoes_offset_x = details.offset.dx;
                shoes_offset_y = details.offset.dy - 80;
              } else if (type == 6) //가방
              {
                bag_offset_x = details.offset.dx;
                bag_offset_y = details.offset.dy - 80;
              }
            });
          },
        ),
      );
    } else {
      return Container();
    }
  }

  Widget firsttabmenu({String name, int index, String imagepath}) {
    return InkWell(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 5.0, top: 5.0, right: 5.0, bottom: 5.0),
          height: 100,
          width: 100,
          decoration: select_index == index
              ? BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(width: 1, color: Colors.black),
                )
              : BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(width: 1, color: Colors.grey[600]),
                ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imagepath != null
                  ? SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.asset(
                        imagepath,
                      ),
                    )
                  : Container(),
              Text(name,
                  style: select_index == index
                      ? TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )
                      : TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        )),
            ],
          ),
        ),
        onTap: () {
          setState(() {
            select_index = index;
          });
        });
  }
}
