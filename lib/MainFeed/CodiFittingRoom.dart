import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:stylehub_flutter/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:drag_to_expand/drag_to_expand.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stylehub_flutter/RequestCodi/Checkcodi.dart';
import 'package:stylehub_flutter/data/MyClothing.dart';
import 'package:stylehub_flutter/data/MyClothingDatabase.dart';
import 'package:stylehub_flutter/data/ProductClothing.dart';
import 'package:stylehub_flutter/data/ProductClothingDatabase.dart';
import 'package:stylehub_flutter/components/ClothInfo.dart';
import 'package:stylehub_flutter/data/CodiClothing.dart';
import 'package:stylehub_flutter/data/AllCodiClothing.dart';
import 'package:stylehub_flutter/common/showToast.dart';
import 'dart:async';
import 'dart:math' as math;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'RawData.dart';
import 'package:stylehub_flutter/FittingRoom/showLinkDialog.dart';
import 'package:stylehub_flutter/FittingRoom/showSearchDialog.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stylehub_flutter/data/CategoryType.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'NormalItem.dart';
import 'NormalText.dart';
import 'GeneratedComponents.dart';

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
    "height": 200,
    "originalOffsetX": 113,
    "originalOffsetY": 30,
    "clothing": null, //MyClothing()이거나 ProductClothing()일 것
  },
  //하의
  {
    "image": "assets/images/sample_pants.png",
    "offsetX": 113,
    "offsetY": 155,
    "width": 200,
    "height": 230,
    "originalOffsetX": 113,
    "originalOffsetY": 155,
    "clothing": null,
  },
  //원피스
  {
    "image": null,
    "offsetX": 113,
    "offsetY": 30,
    "width": 250,
    "height": 250,
    "originalOffsetX": 113,
    "originalOffsetY": 30,
    "clothing": null,
  },
  //아우터
  {
    "image": null,
    "offsetX": 30,
    "offsetY": 0,
    "width": 220,
    "height": 240,
    "originalOffsetX": 30,
    "originalOffsetY": 0,
    "clothing": null,
  },
  //신발
  {
    "image": "assets/images/sample_shoes.png",
    "offsetX": 280,
    "offsetY": 280,
    "width": 80,
    "height": 90,
    "originalOffsetX": 280,
    "originalOffsetY": 280,
    "clothing": null,
  },
  //가방
  {
    "image": null,
    "offsetX": 280,
    "offsetY": 150,
    "width": 120,
    "height": 150,
    "originalOffsetX": 280,
    "originalOffsetY": 150,
    "clothing": null,
  },
];

List<MyClothing> myClosetListTop = [];
List<MyClothing> myClosetListBottom = [];
List<MyClothing> myClosetListOnepiece = [];
List<MyClothing> myClosetListOuter = [];
List<MyClothing> myClosetListAcc = [];

List<dynamic> codiRequestList = []; //일단 보여줄 코디요청list만들어놓음

double swipeStartY;
String swipeDirection;
double bottomSheetSize = 200;
var codiKey;
StylingRequest _stylingRequest;

void _capture() async {
  //요청 옷 보냄
  var renderObject = codiKey.currentContext.findRenderObject();
  if (renderObject.debugNeedsPaint) {
    await Future.delayed(const Duration(milliseconds: 20));
    return _capture();
  }
  if (renderObject is RenderRepaintBoundary) {
    RenderRepaintBoundary boundary = codiKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    //final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    final result =
        await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());

    //이미지: base64방식
    var bs64 = base64Encode(pngBytes);
    //각 옷의 위치
    //상의 -> 하의 -> 원피스 -> 아우터 -> 신발 -> 가방
    var componentsList = [];
    for (int i = 1; i <= 6; i++) {
      if (selectedClothList[i]["image"] != null) //이 때만 보내야함
      {
        double xPos =
            selectedClothList[i]["offsetX"] + selectedClothList[i]["width"] / 2;
        double yPos = selectedClothList[i]["offsetY"] +
            selectedClothList[i]["height"] / 2;
        int price = null;
        String brandName = null, link = null;
        if (selectedClothList[i]["clothing"] is ProductClothing) {
          price = selectedClothList[i]["clothing"].price;
          brandName = selectedClothList[i]["clothing"].brand;
          link = selectedClothList[i]["clothing"].detail_url;
        } else if (selectedClothList[i]["clothing"] is MyClothing) {
          //price랑 link는 없음
          brandName = selectedClothList[i]["clothing"].brandName;
        }
        componentsList.add({
          "brand": brandName,
          "xcordinate": xPos,
          "ycordinate": yPos,
          "clothingImage": selectedClothList[i]["image"],
          "tagResult": {"category": typeToCategory(i)}
        });
      } //end of if
    }
    //코디결과 보내기
    String url = "http://34.64.196.105:82/api/styling/response/create";
    final response = http.post(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "stylingPostId": 1,
          "components": componentsList,
          "requestorProfile": {
            "userNickname": _stylingRequest.userProfile.userNickname,
            "gender": _stylingRequest.userProfile.gender
          },
          "stylistProfile": {
            "userNickname": StyleHub.myNickname,
            "gender": StyleHub.myGender
          }
        }));

    if (result["isSuccess"] == true)
      showToast("이미지가 갤러리에 저장되었습니다.");
    else
      showToast("갤러리 저장에 실패했습니다.");
  } else {
    print("갤러리 저장에 실패했습니다.");
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

  final info1 = statuses[Permission.storage].toString();
}

void goToUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class CodiFittingRoom extends StatefulWidget {
  //rawdata
  ClothInfo requestClothInfo;
  StylingRequest stylingRequest;
  Post post;
  CodiFittingRoom(
      {Key key, this.requestClothInfo, this.stylingRequest, this.post})
      : super(key: key) {
    _stylingRequest = this.stylingRequest;
  }
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
            "assets/applogo.png",
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
      body: CodiFittingRoomMain(
        requestClothInfo: widget.requestClothInfo,
        stylingRequest: widget.stylingRequest,
        post: widget.post,
      ),
    );
  }
}

class CodiFittingRoomMain extends StatefulWidget {
  //rawdata
  ClothInfo requestClothInfo;
  StylingRequest stylingRequest;
  Post post;
  CodiFittingRoomMain(
      {Key key, this.requestClothInfo, this.stylingRequest, this.post})
      : super(key: key) {
    _stylingRequest = this.stylingRequest;
  }
  @override
  _CodiFittingRoomMainState createState() => _CodiFittingRoomMainState();
}

class _CodiFittingRoomMainState extends State<CodiFittingRoomMain> {
  DragToExpandController _dragToExpandController; //하단메뉴 drag
  int menuIndex = 0; //상위탭 내에서의 index
  int myClosetIndex = 1; //내 옷장 내에서의 index
  int allCodiClosetIndex = 0; //코디요청 첫화면에서의 index
  int codiClosetIndex = 0; //코디요청 두번째 화면에서의 index
  int contentType =
      0; //0: 옷들, 1: 삭제, 2: 상품정보, 3:코디요청첫번째화면(total), 4:코디요청두번째화면(상세코디요청)
  //5: link옷장, 6: 검색옷장
  int requestInfoClick = 1; //0: 클릭x, 1: 클릭o
  int codiMenuIndex = 0; //코디 요청 내에서의 메뉴index 0:AI 1:유저추천
  ProductClothing detailClothInfo; //내옷장 말고 코디상품일 때만 띄워야함
  AllCodiClothing mulcodiCloset;
  List<dynamic> myClosetListTotal = [];
  List<dynamic> linkClosetList = []; //링크로 연결한 옷의 모임. productclothing가지고 있다.

  void initState() {
    codiKey = new GlobalKey();
    _dragToExpandController = DragToExpandController();
    //getCloset();
    //getProduct();
    super.initState();
    _requestPermission();
    if (widget.requestClothInfo != null &&
        widget.requestClothInfo.image != null) {
      selectedClothList[widget.requestClothInfo.type]["image"] =
          widget.requestClothInfo.image;
    }
  }

  dispose() {
    _dragToExpandController.dispose();
    //super.dispose();
  }

  void getCloset() async {
    //남의 옷장 가져오기
    String url = "http://34.64.196.105:82/api/closet/read/others";
    final response = await http.post(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "othersProfile": {
            "userNickname": widget.stylingRequest.userProfile.userNickname
          },
        }));
    var result = jsonDecode(utf8.decode(response.bodyBytes)); //한국어 포함
    //순회하며 각자의 type에 맞는 closet에 넣어주기
    for (int i = 0; i < result["clothingArray"].length; i++) {
      var thisCloth = result["clothingArray"][i];
      String category = "상의"; //기본이 상의라고 생각
      if (thisCloth["tagResult"]["category"] != null) {
        category = thisCloth["tagResult"]["category"];
      }
      MyClothing thisClothing = MyClothing(
        id: thisCloth["clothingId"],
        clothingImgPath: thisCloth["clothingImage"],
        brandName: thisCloth["tagResult"]["brandName"],
      );
      if (categoryToType(category) == 1) //상의
      {
        myClosetListTop.add(thisClothing);
      } else if (categoryToType(category) == 2) //하의
      {
        myClosetListBottom.add(thisClothing);
      } else if (categoryToType(category) == 3) //원피스
      {
        myClosetListOnepiece.add(thisClothing);
      } else if (categoryToType(category) == 4) //아우터
      {
        myClosetListOuter.add(thisClothing);
      } else if (categoryToType(category) >= 5) //신발 or 가방
      {
        myClosetListAcc.add(thisClothing);
      }
    }
    if (myClosetListTop.isNotEmpty) {
      selectedClothList[1]["image"] = myClosetListTop[0].clothingImgPath;
    }
    if (myClosetListBottom.isNotEmpty) {
      selectedClothList[2]["image"] = myClosetListBottom[0].clothingImgPath;
    }
    myClosetListTop.insert(0, basictop);
    myClosetListBottom.insert(0, basicbottom);
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  void getProduct() async {
    //나중에 코디넣을 때 다시 확인하자//각 옷에 대한 딥러닝결과 가져오는 것
    //codi1_ai = await ProductClothingDatabase.getRecoResult(21);
  }

  String convert(String filePath) {
    final bytes = File(filePath).readAsBytesSync();
    return base64Encode(bytes);
  }

  //-----------------Widget-----------------
  Widget deleteScreen() {
    return Container(
      height: bottomSheetSize == 200 ? 130 : 280,
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
          if (detailClothInfo is ProductClothing) //내옷장상품 아닐 때만 상품정보 띄우기
            Row(
              children: [
                Container(
                  /*decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.indigo, width: 2)),*/
                  padding: EdgeInsets.all(5),
                  child: detailClothInfo.encoded_img != null
                      ? detailClothInfo.encoded_img.contains("https")
                          ? Image.network(
                              detailClothInfo.encoded_img,
                              width: 120,
                              height: 120,
                              fit: BoxFit.contain,
                            )
                          : detailClothInfo.encoded_img.contains(".")
                              ? Image.asset(
                                  detailClothInfo.encoded_img,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.contain,
                                )
                              : Image.memory(
                                  base64Decode(detailClothInfo.encoded_img),
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.contain
                                  //height: 100,
                                  //fit: BoxFit.scaleDown,
                                  )
                      : Container(),
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
                          detailClothInfo.brand != null
                              ? Text(detailClothInfo.brand,
                                  style: TextStyle(color: Colors.black))
                              : Container(),
                          detailClothInfo.name != null
                              ? Text(detailClothInfo.name,
                                  style: TextStyle(color: Colors.black))
                              : Container(),
                          detailClothInfo.price != null
                              ? Text("${detailClothInfo.price}원",
                                  style: TextStyle(color: Colors.black))
                              : Container(),
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
                              border:
                                  Border.all(color: Colors.indigo, width: 2)),
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
                              border:
                                  Border.all(color: Colors.indigo, width: 2)),
                          child: InkWell(
                            onTap: () {
                              if (detailClothInfo.detail_url != null) {
                                goToUrl(detailClothInfo.detail_url);
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
            )
          else
            Container(
              height: bottomSheetSize == 200 ? 150 : 300,
              child: Center(
                child: Text("해당 상품은 옷 정보가 없습니다."),
              ),
            ),
        ],
      ),
    );
  }

  Widget clothWidget({MyClothing myClothing}) {
    return InkWell(
      onTap: () {
        //클릭시에 위에 옷 바뀌도록
        setState(() {
          selectedClothList[categoryToType(myClothing.category)]["image"] =
              myClothing.clothingImgPath;
          selectedClothList[categoryToType(myClothing.category)]["clothing"] =
              myClothing;
          if (categoryToType(myClothing.category) == 1 ||
              categoryToType(myClothing.category) == 2) //상의 or 하의
          {
            selectedClothList[3]["image"] = null;
          } else if (categoryToType(myClothing.category) == 3) //원피스
          {
            selectedClothList[1]["image"] = null;
            selectedClothList[2]["image"] = null;
          }
        });
      },
      onLongPress: () {
        setState(() {
          //옷 꾹 눌렀을 때. 내 옷장의 옷은 변하는 것 없도록
          //contentType = 2;
          //detailClothInfo = clothInfo;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 5.0, top: 5.0, right: 5.0, bottom: 5.0),
        height: 100,
        decoration: myClothing.clothingImgPath ==
                selectedClothList[categoryToType(myClothing.category)]["image"]
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
                child: myClothing.clothingImgPath.contains("https")
                    ? Image.network(myClothing.clothingImgPath,
                        width: bottomSheetSize == 200 ? 100 : 120,
                        fit: BoxFit.contain)
                    : myClothing.clothingImgPath.contains(".")
                        ? Image.asset(myClothing.clothingImgPath,
                            width: bottomSheetSize == 200 ? 100 : 120,
                            fit: BoxFit.contain)
                        : Image.memory(base64Decode(myClothing.clothingImgPath),
                            width: bottomSheetSize == 200 ? 100 : 120,
                            fit: BoxFit.contain
                            //height: 100,
                            //fit: BoxFit.scaleDown,
                            ),
              ),
            ),
            //선택된 옷일 때 here보이게끔
            myClothing.clothingImgPath ==
                    selectedClothList[categoryToType(myClothing.category)]
                        ["image"]
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
        color: Colors.transparent,
        height: 300,
        child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(
            myClosetListTotal[myClosetIndex - 1].length,
            (idx) {
              return clothWidget(
                  myClothing: myClosetListTotal[myClosetIndex - 1][idx]);
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
            myClosetListTotal[myClosetIndex - 1].length,
            (idx) {
              return clothWidget(
                  myClothing: myClosetListTotal[myClosetIndex - 1][idx]);
            },
          ),
        );
      }),
    );
  }

  Widget myClosetMenuElement({int index, String typeName}) {
    //상의 하의 이름element
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
    return Container(
        color: Colors.white60,
        child: Column(
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
        ));
  }

  //가져오는 옷
  Widget linkScreen() {
    if (contentType == 2) {
      return detailScreen();
    }
    return Container(
        color: Colors.white60,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                showLinkDialog(context);
              },
              child: Icon(Icons.cloud_upload_rounded, size: 25),
            ),
            //메뉴에 따른 옷 보이기
            linkScreenContent(),
          ],
        ));
  }

  Widget linkWidget({ProductClothing productClothing}) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedClothList[categoryToProductType(productClothing.category)]
              ["image"] = productClothing.encoded_img;
          selectedClothList[categoryToProductType(productClothing.category)]
              ["clothing"] = productClothing;
          if (categoryToProductType(productClothing.category) == 1 ||
              categoryToProductType(productClothing.category) == 2) //상의 or 하의
          {
            selectedClothList[3]["image"] = null;
          } else if (categoryToProductType(productClothing.category) == 3) //원피스
          {
            selectedClothList[1]["image"] = null;
            selectedClothList[2]["image"] = null;
          }
        });
      },
      onLongPress: () {
        setState(() {
          //옷 꾹 눌렀을 때. 상품정보 보이도록
          //contentType = 2;
          //detailClothInfo = clothInfo;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 5.0, top: 5.0, right: 5.0, bottom: 5.0),
        height: 100,
        decoration: productClothing.encoded_img ==
                selectedClothList[
                    categoryToProductType(productClothing.category)]["image"]
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
                child: productClothing.encoded_img.contains("https")
                    ? Image.network(productClothing.encoded_img,
                        width: bottomSheetSize == 200 ? 100 : 120,
                        fit: BoxFit.contain)
                    : productClothing.encoded_img.contains(".")
                        ? Image.asset(productClothing.encoded_img,
                            width: bottomSheetSize == 200 ? 100 : 120,
                            fit: BoxFit.contain)
                        : Image.memory(
                            base64Decode(productClothing.encoded_img),
                            width: bottomSheetSize == 200 ? 100 : 120,
                            fit: BoxFit.contain
                            //height: 100,
                            //fit: BoxFit.scaleDown,
                            ),
              ),
            ),
            //선택된 옷일 때 here보이게끔
            productClothing.encoded_img ==
                    selectedClothList[
                            categoryToProductType(productClothing.category)]
                        ["image"]
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

  Widget linkScreenContent() {
    if (contentType == 1) //삭제를 위한 움직임
    {
      return deleteScreen();
    }
    if (bottomSheetSize == 350) {
      return Container(
        color: Colors.transparent,
        height: 300,
        child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(
            linkClosetList.length,
            (idx) {
              return linkWidget(productClothing: linkClosetList[idx]);
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
            linkClosetList.length,
            (idx) {
              return linkWidget(productClothing: linkClosetList[idx]);
            },
          ),
        );
      }),
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
            child: InkWell(
              onTap: () {
                if (selectedClothList[type]["clothing"] is MyClothing) {
                  //null을 보내자
                  setState(() {
                    detailClothInfo = null;
                    contentType = 2;
                  });
                } else {
                  //product일 때는 보내지 말자
                  setState(() {
                    detailClothInfo = selectedClothList[type]["clothing"];
                    contentType = 2;
                  });
                }
              },
              child: Draggable(
                //이미지는 모두 clothingImgpath에 있는 것으로
                child: SizedBox(
                  width: selectedClothList[type]["width"].toDouble(),
                  child: selectedClothList[type]["image"].contains("https")
                      ? Image.network(selectedClothList[type]["image"],
                          width: selectedClothList[type]["width"].toDouble(),
                          fit: BoxFit.fitWidth)
                      : selectedClothList[type]["image"].contains(".")
                          ? Image.asset(selectedClothList[type]["image"],
                              width:
                                  selectedClothList[type]["width"].toDouble(),
                              fit: BoxFit.fitWidth)
                          : Image.memory(
                              base64Decode(selectedClothList[type]["image"]),
                              width:
                                  selectedClothList[type]["width"].toDouble(),
                              fit: BoxFit.fitWidth
                              //fit: BoxFit.contain
                              //height: 100,
                              //fit: BoxFit.scaleDown,
                              ),
                ),
                feedback: SizedBox(
                  width: selectedClothList[type]["width"].toDouble(),
                  child: selectedClothList[type]["image"].contains("https")
                      ? Image.network(selectedClothList[type]["image"],
                          width: selectedClothList[type]["width"].toDouble(),
                          fit: BoxFit.fitWidth)
                      : selectedClothList[type]["image"].contains(".")
                          ? Image.asset(selectedClothList[type]["image"],
                              width:
                                  selectedClothList[type]["width"].toDouble(),
                              fit: BoxFit.fitWidth)
                          : Image.memory(
                              base64Decode(selectedClothList[type]["image"]),
                              width:
                                  selectedClothList[type]["width"].toDouble(),
                              fit: BoxFit.fitWidth
                              //fit: BoxFit.contain
                              //height: 100,
                              //fit: BoxFit.scaleDown,
                              ),
                ),
                childWhenDragging: Container(),
                onDragEnd: (DraggableDetails details) {
                  setState(() {
                    //다시 생길 때는 원래 자리로
                    if (selectedClothList[type]["image"] != null) {
                      selectedClothList[type]["offsetX"] = details.offset.dx;
                      selectedClothList[type]["offsetY"] =
                          details.offset.dy - 80;
                    }
                  });
                },
                data: type,
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget totalTabElement(String name, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          menuIndex = index;
          if (index == 1) {
            contentType = 3;
          }
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
          decoration: index == menuIndex
              ? BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                )
              : BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  border: Border.all(width: 1, color: Colors.black),
                ),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: index == menuIndex ? Colors.white : Colors.black,
            ),
          )),
    );
  }

  Widget totalTabSpecialElement(String name, Function func) {
    return InkWell(
      onTap: () {
        func();
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
            name,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          )),
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
              totalTabElement("유저 옷장", 0),
              //totalTabElement("코디 요청", 1),
              totalTabElement("옷 가져오기", 2),
              //totalTabElement("옷 검색하기", 3),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    myClosetListTotal = [];
    //myClosetListTotal는 index0부터 시작함을 까먹지 말기
    myClosetListTotal.add(myClosetListTop);
    myClosetListTotal.add(myClosetListBottom);
    myClosetListTotal.add(myClosetListOnepiece);
    myClosetListTotal.add(myClosetListOuter);
    myClosetListTotal.add(myClosetListAcc);
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
                  //하의
                  draggableWidget(type: 2),
                  //상의
                  draggableWidget(type: 1),
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
          //요청자의 item list 띄우기
          Positioned(
            top: 15,
            left: 5,
            //child: Expanded(
            child: Row(
              children: [
                Text("ITEM: ", style: normalTS),
                Container(
                  width: 150,
                  height: 25,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                          widget.stylingRequest.requestItems.length, (idx) {
                        return normalItem(
                            str: widget.stylingRequest.requestItems[idx]);
                      })),
                ),
              ],
            ),
            //),
          ),
          //요청자의 style list 띄우기
          Positioned(
            top: 15,
            left: MediaQuery.of(context).size.width / 2,
            //child: Expanded(
            child: Row(
              children: [
                Text("STYLE: ", style: normalTS),
                Container(
                  width: 150,
                  height: 25,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                          widget.stylingRequest.requestStyle.length, (idx) {
                        return normalItem(
                            str: widget.stylingRequest.requestStyle[idx]);
                      })),
                ),
              ],
            ),
            //),
          ),
          //요청자의 요청 아이콘 요청정보 띄우기
          Positioned(
            top: 40,
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
                                  widget.post.content.stylingRequest
                                      .requestContent,
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
                  _dragToExpandController.toggle();
                } else if (swipeDirection == "Up") {
                  setState(() {
                    bottomSheetSize = 350;
                  });
                } else if (swipeDirection == "Down") {
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
                        color: Colors.white60,
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
                          } else if (menuIndex == 2) {
                            return Column(
                              children: [linkScreen()],
                            );
                          }
                          /*else if (menuIndex == 3) {
                            return Column(
                              children: [searchScreen()],
                            );
                          }*/
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
