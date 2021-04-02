import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylehub_flutter/Constants.dart';
import 'package:stylehub_flutter/data/MyClothing.dart';
import 'package:stylehub_flutter/data/MyClothingDatabase.dart';
import 'package:tabbar/tabbar.dart';

class ChooseClothingPage extends StatefulWidget {
  @override
  _ChooseClothingPageState createState() => _ChooseClothingPageState();
}

class _ChooseClothingPageState extends State<ChooseClothingPage> {
  final controller = PageController();
  ScrollController scrollController = ScrollController();

  String getType(String category) {
    if (category == "탑" ||
        category == "블라우스" ||
        category == "캐주얼상의" ||
        category == "니트웨어" ||
        category == "셔츠" ||
        category == "베스트") {
      return '상의';
    }
    if (category == "청바지" || category == "팬츠" || category == "스커트") {
      return '하의';
    }
    return '기타';
  }

  double containerHeight(String category, String length) {
    //print(category + length);
    if (getType(category) == '상의') {
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
    if (getType(category) == '기타') {
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
    if (getType(category) == '하의') {
      switch (length) {
        case '긴':
        case '롱':
          return 320;
        case '크롭':
          return 220;
        case '니렝스':
          return 150;
        case '숏':
        case '미니':
          return 140;
      }
    }
    return 200;
  }

  Widget buildRow(Future<List<MyClothing>> list) {
    return FutureBuilder<List>(
      future: list,
      initialData: [],
      builder: (context, snapshot) {
        if (scrollController.hasClients) {
          print("hasClients");
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
        return snapshot.hasData
            ? ListView.builder(
                reverse: true,
                shrinkWrap: true,
                controller: scrollController,
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
                          onTap: () {
                            print("${snapshot.data[index].id}");
                            Navigator.pop(
                              context,
                              snapshot.data[index],
                            );
                          },
                          child: Container(
                              height: containerHeight(
                                  snapshot.data[index].category,
                                  snapshot.data[index].length),
                              width: 150,
                              padding: EdgeInsets.only(top: 15),
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Image.file(
                                File(snapshot.data[index].clothingImgPath),
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/applogo.png',
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
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
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset('assets/wall_texture.png'),
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
                        child: Stack(
                          //fit: StackFit.loose,
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset('assets/wall_texture.png'),
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
                        child: Stack(
                          //fit: StackFit.loose,
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset('assets/wall_texture.png'),
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
                        child: Stack(
                          //fit: StackFit.loose,
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset('assets/wall_texture.png'),
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
                            padding: EdgeInsets.only(top: 15),
                            child: buildRow(MyClothingDatabase.getOuter()),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Stack(
                          //fit: StackFit.loose,
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset('assets/wall_texture.png'),
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
