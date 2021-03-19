import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylehub_flutter/Constants.dart';
import 'package:stylehub_flutter/MyCloset/MyRoom/MyRoom.dart';
import 'package:stylehub_flutter/MyCloset/TagResult/infoTypes.dart';
import 'package:stylehub_flutter/data/MyClothing.dart';
import 'package:stylehub_flutter/data/MyClothingDatabase.dart';
import 'package:stylehub_flutter/data/ProductClothing.dart';
import 'package:stylehub_flutter/data/ProductClothingDatabase.dart';
import 'package:tabbar/tabbar.dart';
import 'RegisterPage.dart';
import 'package:http/http.dart' as http;

class MyClosetPage extends StatefulWidget {
  @override
  _MyClosetPageState createState() => _MyClosetPageState();
}

class _MyClosetPageState extends State<MyClosetPage> {
  final controller = PageController();

  double containerHeight(String category, String length) {
    print(category + length);
    if (category == "탑" ||
        category == "블라우스" ||
        category == "캐주얼상의" ||
        category == "니트웨어" ||
        category == "셔츠" ||
        category == "베스트") {
      switch (length) {
        case '롱':
          return 230;
          break;
        case '노멀':
          return 190;
        case '크롭':
          return 170;
        // 마저 끝내기
      }
    }
    if (category == "코트" ||
        category == "재킷" ||
        category == "점퍼" ||
        category == "패딩" ||
        category == "드레스" ||
        category == "점프수트") {
      switch (length) {
        case '롱':
          return 300;
        case '맥시':
          return 250;
        case '노멀':
        case '미디':
        case '숏':
          return 220;
        case '니렝스':
          return 190;
        case '크롭':
        case '미니':
          return 170;
      }
    }
    if (category == "청바지" || category == " 팬츠" || category == "스커트") {
      switch (length) {
        case '긴':
        case '롱':
          return 270;
        case '크롭':
          return 220;
        case '니렝스':
          return 200;
        case '숏':
        case '미니':
          return 140;
      }
    }
    return 200;
  }

  void getStyling(String clothBase64) async {
    String url = "http://115.145.212.100:51122/post";
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    Map<String, dynamic> data = {
      'top_k': 15,
      'sex': 'WOMEN',
      'category': '상의',
      'image': clothBase64
    };
    http.Response response = await http
        .post(url, headers: headers, body: jsonEncode(data))
        .timeout(Duration(seconds: 180));
    //print(response.body);
    var result = json.decode(response.body);
    //print(result['Deep']['predictions_info'].length);
    for (int i = 0; i < 15; i++) {
      // ProductClothingDatabase.insertProduct(ProductClothing(
      //     request_num: 23,
      //     encoded_img: result['Deep']['predictions_info'][i]['encoded_img'],
      //     brand: result['Deep']['predictions_info'][i]['brand'],
      //     detail_url: result['Deep']['predictions_info'][i]['detail_url'],
      //     fashion_url: result['Deep']['predictions_info'][i]['fashion_url'],
      //     item_url: result['Deep']['predictions_info'][i]['item_url'],
      //     name: result['Deep']['predictions_info'][i]['name'],
      //     price: result['Deep']['predictions_info'][i]['price'],
      //     score: result['Deep']['predictions_info'][i]['score']));
      // int total = await ProductClothingDatabase.totalProductNum();
      // print(total);
      ProductClothingDatabase.insertProduct(ProductClothing(
        request_num: 100,
        encoded_img: result['DeepGraph']['topk'][i]['encoded_img'],
        brand: result['DeepGraph']['topk'][i]['brand'],
        detail_url: result['DeepGraph']['topk'][i]['detail_url'],
        fashion_url: result['DeepGraph']['topk'][i]['fashion_url'],
        item_url: result['DeepGraph']['topk'][i]['item_url'],
        name: result['DeepGraph']['topk'][i]['name'],
        price: result['DeepGraph']['topk'][i]['price'].toString(),
      ));
      int total = await ProductClothingDatabase.totalProductNum();
      print(total);
    }
  }

  Widget buildRow(Future<List<MyClothing>> list) {
    return FutureBuilder<List>(
      future: list,
      initialData: [],
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                reverse: true,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Container(
                          height: 30,
                          child: Image.asset('assets/hanger_hook.png'),
                        ),
                        GestureDetector(
                          onLongPress: () {
                            getStyling(snapshot.data[index].clothingImgBase64);
                          },
                          child: Container(
                              height: containerHeight(
                                  snapshot.data[index].category,
                                  snapshot.data[index].length),
                              width: 150,
                              padding: EdgeInsets.only(top: 15),
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Image.memory(
                                base64Decode(
                                    snapshot.data[index].clothingImgBase64),
                                fit: BoxFit.fill,
                              )),
                        ),
                      ]);
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //ProductClothingDatabase.clearProduct();
    //MyClothingDatabase.deleteClothing(4);
    //MyClothingDatabase.clearCloset();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                child: Text('MY 옷장', style: kPageTitleTextStyle),
              ),
            ],
          ),
          PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: TabbarHeader(
              indicatorColor: Colors.black,
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              controller: controller,
              tabs: [
                Tab(
                  text: '전체',
                ),
                Tab(
                  text: '상의',
                ),
                Tab(
                  text: '하의',
                ),
                Tab(
                  text: '원피스',
                ),
                Tab(
                  text: '아우터',
                )
              ],
            ),
          ),
          Expanded(
            child: TabbarContent(
              controller: controller,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Stack(
                        children: <Widget>[
                          Image.asset('assets/hanger.png'),
                          Container(
                              height: 250,
                              padding: EdgeInsets.only(top: 15),
                              child:
                                  buildRow(MyClothingDatabase.getMyCloset())),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            disabledColor: Colors.black,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                '행거 추가하기',
                                style: kButtonTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset('assets/wall_texture.png'),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 35, right: 25),
                              alignment: Alignment.bottomRight,
                              child: Image.asset('assets/storage.png'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Stack(
                        children: <Widget>[
                          Image.asset('assets/hanger.png'),
                          Container(
                            height: 200,
                            padding: EdgeInsets.only(top: 15),
                            child: buildRow(MyClothingDatabase.getTop()),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: RaisedButton(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            disabledColor: Colors.black,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                '행거 추가하기',
                                style: kButtonTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          //fit: StackFit.loose,
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset('assets/wall_texture.png'),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 35, right: 25),
                              alignment: Alignment.bottomRight,
                              child: Image.asset('assets/storage.png'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Stack(
                        children: <Widget>[
                          Image.asset('assets/hanger.png'),
                          Container(
                            height: 200,
                            padding: EdgeInsets.only(top: 15),
                            child: buildRow(MyClothingDatabase.getBottom()),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            disabledColor: Colors.black,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                '행거 추가하기',
                                style: kButtonTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          //fit: StackFit.loose,
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset('assets/wall_texture.png'),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 35, right: 25),
                              alignment: Alignment.bottomRight,
                              child: Image.asset('assets/storage.png'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Stack(
                        children: <Widget>[
                          Image.asset('assets/hanger.png'),
                          Container(
                            height: 200,
                            padding: EdgeInsets.only(top: 15),
                            child: buildRow(MyClothingDatabase.getOnePiece()),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            disabledColor: Colors.black,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                '행거 추가하기',
                                style: kButtonTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          //fit: StackFit.loose,
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset('assets/wall_texture.png'),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 35, right: 25),
                              alignment: Alignment.bottomRight,
                              child: Image.asset('assets/storage.png'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Stack(
                        children: <Widget>[
                          Image.asset('assets/hanger.png'),
                          Container(
                            height: 200,
                            padding: EdgeInsets.only(top: 15),
                            child: buildRow(MyClothingDatabase.getOuter()),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            disabledColor: Colors.black,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                '행거 추가하기',
                                style: kButtonTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          //fit: StackFit.loose,
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset('assets/wall_texture.png'),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 35, right: 25),
                              alignment: Alignment.bottomRight,
                              child: Image.asset('assets/storage.png'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
