import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:drag_to_expand/drag_to_expand.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stylehub_flutter/RequestCodi/Checkcodi.dart';
import 'package:stylehub_flutter/data/MyClothing.dart';
import 'package:stylehub_flutter/data/MyClothingDatabase.dart';
import 'package:stylehub_flutter/data/ProductClothing.dart';
import 'package:stylehub_flutter/data/ProductClothingDatabase.dart';
import 'package:stylehub_flutter/components/ClothInfo.dart';
import 'RawData.dart';
import 'dart:async';
import 'dart:math' as math;
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'package:fluttertoast/fluttertoast.dart';

//화면에 선택된 옷과 위치
////모든 순서는 1:top, 2:bottom, 3: onepiece, 4:outer, 5:shoes, 6:bag
List<Map<String, dynamic>> selectedClothList = [
  null,
  //상의
  {
    "image": "assets/images/sample_knit.png",
    "offsetX": 113,
    "offsetY": 30,
    "width": 180,
    "originalOffsetX": 113,
    "originalOffsetY": 30,
  },
  //하의
  {
    "image": "assets/images/sample_pants.png",
    "offsetX": 113,
    "offsetY": 155,
    "width": 200,
    "originalOffsetX": 113,
    "originalOffsetY": 155,
  },
  //원피스
  {
    "image": null,
    "offsetX": 113,
    "offsetY": 30,
    "width": 250,
    "originalOffsetX": 113,
    "originalOffsetY": 30,
  },
  //아우터
  {
    "image": null,
    "offsetX": 30,
    "offsetY": 0,
    "width": 220,
    "originalOffsetX": 30,
    "originalOffsetY": 0,
  },
  //신발
  {
    "image": "assets/images/sample_shoes.png",
    "offsetX": 280,
    "offsetY": 280,
    "width": 80,
    "originalOffsetX": 280,
    "originalOffsetY": 280,
  },
  //가방
  {
    "image": null,
    "offsetX": 280,
    "offsetY": 150,
    "width": 120,
    "originalOffsetX": 280,
    "originalOffsetY": 150,
  },
];

List<ClothInfo> userClosetListTop = [];
List<ClothInfo> userClosetListBottom = [];
List<ClothInfo> userClosetListOnepiece = [];
List<ClothInfo> userClosetListOuter = [];
List<ClothInfo> userClosetListAcc = [];

double swipeStartY;
String swipeDirection;
double bottomSheetSize = 200;
var codiKey;

_showToast(String info) {
  Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
}

void _capture() async {
  var renderObject = codiKey.currentContext.findRenderObject();
  if (renderObject.debugNeedsPaint) {
    print("Waiting for boundary to be painted.");
    await Future.delayed(const Duration(milliseconds: 20));
    return _capture();
  }
  if (renderObject is RenderRepaintBoundary) {
    RenderRepaintBoundary boundary = codiKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final result = await ImageGallerySaver.saveImage(
        byteData.buffer.asUint8List(),
        quality: 100);
    _showToast("이미지가 갤러리에 저장되었습니다.");
  } else {
    print("!");
  }
}

void saveCodi() {
  _capture();
}

_requestPermission() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.storage,
  ].request();

  final info = statuses[Permission.storage].toString();
}

void goToUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class CodiFittingRoom extends StatefulWidget {
  ClothInfo requestClothInfo;
  CodiFittingRoom({Key key, this.requestClothInfo}) : super(key: key);
  @override
  _CodiFittingRoomState createState() => _CodiFittingRoomState();
}

class _CodiFittingRoomState extends State<CodiFittingRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/applogo.png',
            alignment: Alignment.center,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  //actions
                  _capture();
                },
                child: Text(
                  "보내기",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
      body: CodiFittingRoomMain(requestClothInfo: widget.requestClothInfo),
    );
  }
}

class CodiFittingRoomMain extends StatefulWidget {
  //rawdata
  ClothInfo requestClothInfo;
  CodiFittingRoomMain({Key key, this.requestClothInfo}) : super(key: key);
  @override
  _CodiFittingRoomMainState createState() => _CodiFittingRoomMainState();
}

class _CodiFittingRoomMainState extends State<CodiFittingRoomMain> {
  DragToExpandController _dragToExpandController; //하단메뉴 drag
  int menuIndex = 0; //상위탭 내에서의 index
  int myClosetIndex = 1; //내 옷장 내에서의 index
  int contentType = 0; //0: 옷들, 1: 삭제, 2: 상품정보
  ClothInfo detailClothInfo;
  List<dynamic> userClosetListTotal = [];
  int requestInfoClick = 1; //0: 클릭x, 1: 클릭o

  void initState() {
    codiKey = new GlobalKey();
    _dragToExpandController = DragToExpandController();
    super.initState();
    _requestPermission();
    if (widget.requestClothInfo.image != null) {
      selectedClothList[widget.requestClothInfo.type]["image"] =
          widget.requestClothInfo.image;
    }
  }

  dispose() {
    _dragToExpandController.dispose();
    super.dispose();
  }

  Widget deleteScreen() {
    return Container(
      height: 130,
      width: 330,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                    text: "삭제하려면  ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
                TextSpan(
                    text: "여기에",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
                        decorationThickness: 2)),
                TextSpan(
                    text: "  끌어다 놓으세요.",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          Icon(
            Icons.delete_forever_outlined,
            size: 60,
          ),
        ],
      ),
    );
  }

  //detailClothInfo에 넣어놓은 옷의 상품정보
  Widget detailScreen() {
    return Container(
      color: Colors.white60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("  상품 정보",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  )),
              InkWell(
                onTap: () {
                  setState(() {
                    contentType = 0;
                  });
                },
                child: Icon(Icons.close, size: 25),
              ),
            ],
          ),
          Container(
            width: 500,
            child: Divider(
              color: Colors.black,
              thickness: 2,
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Image.asset(
                  detailClothInfo.image,
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: 230,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.indigo, width: 2)),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Text(detailClothInfo.brandname,
                            style: TextStyle(color: Colors.black)),
                        Text(detailClothInfo.clothname,
                            style: TextStyle(color: Colors.black)),
                        Text("${detailClothInfo.price}원",
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.indigo, width: 2)),
                        child: Text(" 위시리스트 ",
                            style: TextStyle(color: Colors.black)),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.indigo, width: 2)),
                        child: InkWell(
                          onTap: () {
                            if (detailClothInfo.url != null) {
                              goToUrl(detailClothInfo.url);
                            }
                          },
                          child: Text(" 구매하기 ",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget clothWidget({ClothInfo clothInfo}) {
    return InkWell(
      onTap: () {
        //클릭시에 위에 옷 바뀌도록
        setState(() {
          selectedClothList[clothInfo.type]["image"] = clothInfo.image;
        });
      },
      onLongPress: () {
        setState(() {
          contentType = 2;
          detailClothInfo = clothInfo;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 5.0, top: 5.0, right: 5.0, bottom: 5.0),
        height: 100,
        decoration:
            clothInfo.image == selectedClothList[clothInfo.type]["image"]
                ? BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    border: Border.all(color: Colors.indigo, width: 2.5))
                : null,
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: bottomSheetSize == 200 ? 100 : 120,
                child: Image.asset(clothInfo.image,
                    width: bottomSheetSize == 200 ? 100 : 120,
                    fit: BoxFit.contain),
              ),
            ),
            //선택된 옷일 때 here보이게끔
            clothInfo.image == selectedClothList[clothInfo.type]["image"]
                ? Center(
                    child: Text("    Select!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget myClosetContent({int myClosetIndex}) {
    if (contentType == 1) //삭제를 위한 움직임
    {
      return deleteScreen();
    }
    if (bottomSheetSize == 350) {
      return Container(
        height: 300,
        child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(
            userClosetListTotal[myClosetIndex - 1].length,
            (idx) {
              return clothWidget(
                  clothInfo: userClosetListTotal[myClosetIndex - 1][idx]);
            },
          ),
        ),
      );
    }
    return Container(
      height: 150,
      // ignore: missing_return
      child: Builder(builder: (context) {
        return ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(
            userClosetListTotal[myClosetIndex - 1].length,
            (idx) {
              return clothWidget(
                  clothInfo: userClosetListTotal[myClosetIndex - 1][idx]);
            },
          ),
        );
      }),
    );
  }

  Widget myClosetMenuElement({int index, String typeName}) {
    return InkWell(
      onTap: () {
        setState(() {
          myClosetIndex = index;
        });
      },
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 5.0, top: 5.0, right: 5.0, bottom: 5.0),
          height: 30,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: myClosetIndex == index
                ? Border(
                    bottom: BorderSide(
                      color: Colors.indigo,
                      width: 3,
                    ),
                  )
                : null,
          ),
          child: Text(
            "  " + typeName + "  ",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          )),
    );
  }

  Widget myCloset() {
    if (contentType == 2) {
      return detailScreen();
    }
    //
    return Column(
      children: [
        //내옷장에서 위의 메뉴들
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            myClosetMenuElement(index: 1, typeName: "상의"),
            myClosetMenuElement(index: 2, typeName: "하의"),
            myClosetMenuElement(index: 3, typeName: "원피스"),
            myClosetMenuElement(index: 4, typeName: "아우터"),
            myClosetMenuElement(index: 5, typeName: "ACC"),
          ],
        ),
        //메뉴에 따른 옷 보이기
        myClosetContent(myClosetIndex: myClosetIndex),
      ],
    );
  }

  Widget draggableWidget({int type}) {
    //움직이는 위젯
    //type은 1: 상의 2: 하의...임을 나타냄. 위 참조
    return Builder(
      builder: (context) {
        if (selectedClothList[type]["image"] != null) {
          return Positioned(
            left: selectedClothList[type]["offsetX"].toDouble(),
            top: selectedClothList[type]["offsetY"].toDouble(),
            child: Draggable(
              child: SizedBox(
                width: selectedClothList[type]["width"].toDouble(),
                child: Image.asset(selectedClothList[type]["image"],
                    width: selectedClothList[type]["width"].toDouble(),
                    fit: BoxFit.fitWidth),
              ),
              feedback: SizedBox(
                width: selectedClothList[type]["width"].toDouble(),
                child: Image.asset(selectedClothList[type]["image"],
                    width: selectedClothList[type]["width"].toDouble(),
                    fit: BoxFit.fitWidth),
              ),
              childWhenDragging: Container(),
              onDragEnd: (DraggableDetails details) {
                setState(() {
                  selectedClothList[type]["offsetX"] = details.offset.dx;
                  selectedClothList[type]["offsetY"] = details.offset.dy - 80;
                });
              },
              data: type,
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget totalTab() {
    if (contentType == 2) //상품정보일 때
    {
      return Container();
    }
    return Row(
      children: [
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    menuIndex = 0;
                  });
                },
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      left: 5.0,
                      right: 5.0,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                    child: Text(
                      "유저 옷장",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    userClosetListTotal = [];
    //rawdata
    putRawData();
    //myClosetListTotal는 index0부터 시작함을 까먹지 말기
    userClosetListTotal.add(userClosetListTop);
    userClosetListTotal.add(userClosetListBottom);
    userClosetListTotal.add(userClosetListOnepiece);
    userClosetListTotal.add(userClosetListOuter);
    userClosetListTotal.add(userClosetListAcc);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //캡쳐할 범위
          RepaintBoundary(
            key: codiKey,
            child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  //배경
                  Positioned(
                    child: Image.asset('assets/images/background_ui.png'),
                  ),
                  //상의
                  draggableWidget(type: 1),
                  //하의
                  draggableWidget(type: 2),
                  //원피스
                  draggableWidget(type: 3),
                  //아우터
                  draggableWidget(type: 4),
                  //신발
                  draggableWidget(type: 5),
                  //가방
                  draggableWidget(type: 6),
                ],
              ),
            ),
          ),
          //요청자의 요청 아이콘 요청정보 띄우기
          Positioned(
            top: 25,
            right: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (requestInfoClick == 0) {
                        requestInfoClick = 1;
                      } else {
                        requestInfoClick = 0;
                      }
                    });
                  },
                  icon: Icon(
                    Icons.wysiwyg,
                    size: 40,
                  ),
                ),
                requestInfoClick == 1
                    ? Container(
                        padding: EdgeInsets.only(top: 10),
                        child: SpeechBubble(
                          height: 100,
                          color: Colors.black,
                          nipLocation: NipLocation.TOP_RIGHT,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SingleChildScrollView(
                                  child: Container(
                                width: 100,
                                child: Text(
                                  "요청정보입니다루룰루루루룰루라랄라라랄 예쁜 코디 부탁드립니다룰루",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                              IconButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    setState(() {
                                      requestInfoClick = 0;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ))
                    : Container(),
              ],
            ),
          ),
          //하단메뉴 bottomsheet
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onVerticalDragStart: (details) {
                swipeStartY = details.globalPosition.dy;
              },
              onVerticalDragUpdate: (details) {
                setState(() {
                  swipeDirection =
                      (details.globalPosition.dy < swipeStartY) ? "Up" : "Down";
                });
              },
              onVerticalDragEnd: (details) {
                if (swipeDirection == "Down" && bottomSheetSize == 200) {
                  print("toggle");
                  _dragToExpandController.toggle();
                } else if (swipeDirection == "Up") {
                  print("up");
                  setState(() {
                    bottomSheetSize = 350;
                  });
                } else if (swipeDirection == "Down") {
                  print("down");
                  setState(() {
                    bottomSheetSize = 200;
                  });
                }
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: DragToExpand(
                      controller: _dragToExpandController,
                      minSize: 0,
                      //길이 크게할 때 여기를 건드리자
                      maxSize: bottomSheetSize,
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
                                'More Clothes',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      ),
                      draggableWhenOpened: Container(
                        height: 40,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0))),
                          child: totalTab(),
                        ),
                      ),
                      //여기에는 아래에 들어갈 내용
                      child: DragTarget(
                        builder:
                            // ignore: missing_return
                            (context, List<int> candidateData, rejectedData) {
                          if (menuIndex == 0) //내 옷장일 때
                          {
                            return Column(
                              children: [myCloset()],
                            );
                          }
                        },
                        //들어온 상태. 이때는 화면 다르게
                        onWillAccept: (data) {
                          setState(() {
                            contentType = 1;
                          });
                          return true;
                        },
                        //accept한 상태. 삭제하자
                        onAccept: (data) {
                          setState(() {
                            selectedClothList[data]["image"] = null;
                            selectedClothList[data]["offsetX"] =
                                selectedClothList[data]["originalOffsetX"];
                            selectedClothList[data]["offsetY"] =
                                selectedClothList[data]["originalOffsetY"];
                            contentType = 0;
                          });
                        },
                        //다시 떠날 때
                        onLeave: (object) {
                          setState(() {
                            contentType = 0;
                          });
                        },
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}
