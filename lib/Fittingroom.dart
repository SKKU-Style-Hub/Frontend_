import 'package:flutter/material.dart';
import 'package:drag_to_expand/drag_to_expand.dart';
import 'dart:async';
import 'dart:math' as math;

//화면에 이미 선택된 옷
String selected_top = "assets/images/sample_knit.png";
String selected_bottom = 'assets/images/sample_pants.png';
String selected_shoes = 'assets/images/sample_shoes.png';
String selected_onepiece = 'assets/images/sample_shoes.png';
String selected_outer;
//아우터 배치는 어떤 식으로 해야될지 모르겠어서 안해놓음.

//첫 화면 배치offset
Offset top_offset = Offset(130.0, 70.0);
Offset bottom_offset = Offset(130.0, 155.0);
Offset shoes_offset = Offset(240, 300);
Offset onepiece_offset = Offset(130.0, 70.0);

//어떤 옷인가요?//1이면 선택 0이면 선택x
int top_yesno = 1;
int bottom_yesno = 1;
int shoes_yesno = 1;
int onepiece_yesno = 0;

int select_index = 0; //0은 내옷장, 1은 제안상품을 의미

//배열들
List<String> mycloset_top = [
  'assets/images/top1.png',
  'assets/images/top2.png',
  'assets/images/top2.png',
];

List<String> mycloset_pants = [
  'assets/images/pants1.png',
  'assets/images/pants2.png',
  'assets/images/sample_pants.png'
];

List<String> mycloset_onepiece = [
  'assets/images/onepiece1.png',
  'assets/images/onepiece1.png',
  'assets/images/onepiece1.png',
];

List<String> mycloset_outer = [
  'assets/images/outer1.png',
  'assets/images/outer2.png',
  'assets/images/outer2.png',
];

List<String> mycloset_shoes = [
  'assets/images/sample_shoes.png',
  'assets/images/sample_shoes.png',
  'assets/images/sample_shoes.png',
];

List<String> recommend_top = [
  'assets/images/top1.png',
  'assets/images/top2.png',
  'assets/images/top2.png',
];

List<String> recommend_pants = [
  'assets/images/pants1.png',
  'assets/images/pants2.png',
  'assets/images/pants2.png',
];

List<String> recommend_onepiece = [
  'assets/images/onepiece1.png',
  'assets/images/onepiece1.png',
  'assets/images/onepiece1.png',
];

List<String> recommend_outer = [
  'assets/images/outer1.png',
  'assets/images/outer2.png',
  'assets/images/outer2.png',
];

List<String> recommend_shoes = [
  'assets/images/sample_shoes.png',
  'assets/images/sample_shoes.png',
  'assets/images/sample_shoes.png',
];

class Fittingroom_main extends StatefulWidget {
  Fittingroom_main({Key key}) : super(key: key) {}
  _Fittingroom_mainState createState() {
    return _Fittingroom_mainState();
  }
}

class _Fittingroom_mainState extends State<Fittingroom_main> {
  DragToExpandController _dragToExpandController2;
  List<Color> select_color = [Colors.black, Colors.grey[600]];

  @override
  void initState() {
    _dragToExpandController2 = DragToExpandController();
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    select_index = 0;
    return Stack(
      children: <Widget>[
        //화면에 상의
        Positioned(
          child: Image.asset('assets/images/background_ui.png'),
        ),
        new Positioned(
          key: GlobalKey(),
          left: top_offset.dx,
          top: top_offset.dy,
          child: Draggable(
            child: Image.asset(
              selected_top,
              width: 180,
              height: 180,
              fit: BoxFit.contain,
              //colorBlendMode: BlendMode.srcOut,
            ),
            feedback: Image.asset(
              selected_top,
              width: 180,
              height: 180,
              fit: BoxFit.contain,
              //colorBlendMode: BlendMode.srcOut,
            ),
            childWhenDragging: Text(" "),
            onDragEnd: (DraggableDetails details) {
              setState(() {
                print(details.offset);
                //print(details.offset);
                top_offset = details.offset;
                print(top_offset);
                print(top_offset.distance);
                //print(top_offset.distance);
              });
            },
          ),
        ),
        //화면에 하의
        new Positioned(
          key: GlobalKey(),
          left: bottom_offset.dx,
          top: bottom_offset.dy,
          child: Draggable(
            child: Image.asset(
              selected_bottom,
              width: 200,
              height: 270,
              colorBlendMode: BlendMode.srcOut,
              fit: BoxFit.contain,
            ),
            feedback: Image.asset(
              selected_bottom,
              width: 200,
              height: 270,
              colorBlendMode: BlendMode.srcOut,
              fit: BoxFit.contain,
            ),
            childWhenDragging: Text(" "),
            onDragEnd: (DraggableDetails details) {
              setState(() {
                bottom_offset = details.offset;
                print(bottom_offset.dx);
                print(bottom_offset.dy);
              });
            },
          ),
        ),
        //화면에 신발
        new Positioned(
          key: GlobalKey(),
          left: shoes_offset.dx,
          top: shoes_offset.dy,
          child: Draggable(
            child: Image.asset(
              selected_shoes,
              width: 150,
              height: 203,
              colorBlendMode: BlendMode.srcOut,
            ),
            feedback: Image.asset(
              selected_shoes,
              width: 150,
              height: 203,
              colorBlendMode: BlendMode.srcOut,
              //fit: BoxFit.fitHeight,
            ),
            //childWhenDragging: Text(" "),
            onDragEnd: (DraggableDetails details) {
              setState(() {
                shoes_offset = details.offset;
                print(shoes_offset.dx);
                print(shoes_offset.dy);
              });
            },
          ),
        ),
        //-------------bottomsheet---------------
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: DragToExpand(
                controller: _dragToExpandController2,
                minSize: 0,
                maxSize: 200,
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
                  height: 40,
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
                        child: Row(
                          children: [
                            InkWell(
                                key: Key("mycloset"),
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      left: 5.0,
                                      top: 5.0,
                                      right: 5.0,
                                      bottom: 5.0),
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                        width: 1, color: select_color[0]),
                                  ),
                                  child: Column(
                                    //key: Key("mycloset"),
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("내 옷장",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: select_color[0],
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    select_index = 0;
                                    if (select_index == 0) {
                                      select_color[0] = Colors.black;
                                      select_color[1] = Colors.grey[600];
                                    } else {
                                      select_color[0] = Colors.grey[600];
                                    }
                                  });
                                }),
                            InkWell(
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      left: 5.0,
                                      top: 5.0,
                                      right: 5.0,
                                      bottom: 5.0),
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                        width: 1, color: select_color[1]),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("제안상품",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: select_color[1],
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    select_index = 1;
                                    if (select_index == 1) {
                                      select_color[1] = Colors.black;
                                      select_color[0] = Colors.grey[600];
                                    } else {
                                      select_color[1] = Colors.grey[600];
                                    }
                                  });
                                }),
                          ],
                        ),
                      )),
                ),
                //------------tab아래에 들어갈 내용
                child: Container(
                    color: Colors.transparent,
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        //kind_of_cloth = 0;
                        if (select_index == 0) {
                          //내옷장에서 받아오기
                          return Container(
                              //width: 300,
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
                                        //icon: Text("제안 상품"),
                                        child: Text('상의',
                                            style: TextStyle(fontSize: 15.0)),
                                      ),
                                      Tab(
                                        child: Text('하의',
                                            style: TextStyle(fontSize: 15.0)),
                                      ),
                                      Tab(
                                        //icon: Icon(Icons.looks_3),
                                        child: Text('원피스',
                                            style: TextStyle(fontSize: 15.0)),
                                      ),
                                      Tab(
                                        child: Text('아우터',
                                            style: TextStyle(fontSize: 15.0)),
                                      ),
                                      Tab(
                                        child: Text('신발',
                                            style: TextStyle(fontSize: 15.0)),
                                      ),
                                    ],
                                  ),
                                  body: TabBarView(
                                    children: <Widget>[
                                      //------------------top
                                      ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(
                                            mycloset_top.length, (idx) {
                                          return RaisedButton(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(18)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 5,
                                                      blurRadius: 3,
                                                    )
                                                  ]),
                                              child: Image.asset(
                                                mycloset_top[idx],
                                                width: 150,
                                                height: 203,
                                                colorBlendMode:
                                                    BlendMode.srcOut,
                                              ),
                                            ),
                                            color: Colors.transparent,
                                            elevation: 0.0,
                                            splashColor: Colors.blueGrey,
                                            onPressed: () {
                                              setState(() {
                                                selected_top =
                                                    mycloset_top[idx];
                                              });
                                            },
                                          );
                                        }),
                                      ),
                                      //-------------pants
                                      ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(
                                            mycloset_pants.length, (idx) {
                                          return RaisedButton(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(18)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 5,
                                                      blurRadius: 3,
                                                    )
                                                  ]),
                                              child: Image.asset(
                                                mycloset_pants[idx],
                                                width: 150,
                                                height: 203,
                                                colorBlendMode:
                                                    BlendMode.srcOut,
                                              ),
                                            ),
                                            color: Colors.transparent,
                                            elevation: 0.0,
                                            splashColor: Colors.blueGrey,
                                            onPressed: () {
                                              setState(() {
                                                selected_bottom =
                                                    mycloset_pants[idx];
                                              });
                                            },
                                          );
                                        }),
                                      ),
                                      //-------------onepiece
                                      ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(
                                            mycloset_onepiece.length, (idx) {
                                          return RaisedButton(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(18)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 5,
                                                      blurRadius: 3,
                                                    )
                                                  ]),
                                              child: Image.asset(
                                                mycloset_onepiece[idx],
                                                width: 150,
                                                height: 203,
                                                colorBlendMode:
                                                    BlendMode.srcOut,
                                              ),
                                            ),
                                            color: Colors.transparent,
                                            elevation: 0.0,
                                            splashColor: Colors.blueGrey,
                                            onPressed: () {
                                              setState(() {
                                                selected_top =
                                                    mycloset_onepiece[idx];
                                              });
                                            },
                                          );
                                        }),
                                      ),
                                      //-----------outer
                                      ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(
                                            mycloset_outer.length, (idx) {
                                          return RaisedButton(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(18)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 5,
                                                      blurRadius: 3,
                                                    )
                                                  ]),
                                              child: Image.asset(
                                                mycloset_outer[idx],
                                                width: 150,
                                                height: 203,
                                                colorBlendMode:
                                                    BlendMode.srcOut,
                                              ),
                                            ),
                                            color: Colors.transparent,
                                            elevation: 0.0,
                                            splashColor: Colors.blueGrey,
                                            onPressed: () {
                                              setState(() {
                                                selected_outer =
                                                    mycloset_outer[idx];
                                              });
                                            },
                                          );
                                        }),
                                      ),
                                      //--------------shoes
                                      ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(
                                            mycloset_shoes.length, (idx) {
                                          return RaisedButton(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(18)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 5,
                                                      blurRadius: 3,
                                                    )
                                                  ]),
                                              child: Image.asset(
                                                mycloset_shoes[idx],
                                                width: 150,
                                                height: 203,
                                                colorBlendMode:
                                                    BlendMode.srcOut,
                                              ),
                                            ),
                                            color: Colors.transparent,
                                            elevation: 0.0,
                                            splashColor: Colors.blueGrey,
                                            onPressed: () {
                                              setState(() {
                                                selected_shoes =
                                                    mycloset_shoes[idx];
                                              });
                                            },
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        } else if (select_index == 1) {
                          //제안상품에서 받아오기
                          return Container(
                              //width: 300,
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
                                        //icon: Text("제안 상품"),
                                        child: Text('상의',
                                            style: TextStyle(fontSize: 15.0)),
                                      ),
                                      Tab(
                                        child: Text('하의',
                                            style: TextStyle(fontSize: 15.0)),
                                      ),
                                      Tab(
                                        //icon: Icon(Icons.looks_3),
                                        child: Text('원피스',
                                            style: TextStyle(fontSize: 15.0)),
                                      ),
                                      Tab(
                                        child: Text('아우터',
                                            style: TextStyle(fontSize: 15.0)),
                                      ),
                                      Tab(
                                        child: Text('신발',
                                            style: TextStyle(fontSize: 15.0)),
                                      ),
                                    ],
                                  ),
                                  body: TabBarView(
                                    children: <Widget>[
                                      //------------------top
                                      ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(
                                            recommend_top.length, (idx) {
                                          return RaisedButton(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(18)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 5,
                                                      blurRadius: 3,
                                                    )
                                                  ]),
                                              child: Image.asset(
                                                recommend_top[idx],
                                                width: 150,
                                                height: 203,
                                                colorBlendMode:
                                                    BlendMode.srcOut,
                                              ),
                                            ),
                                            color: Colors.transparent,
                                            elevation: 0.0,
                                            splashColor: Colors.blueGrey,
                                            onPressed: () {
                                              setState(() {
                                                selected_top =
                                                    recommend_top[idx];
                                              });
                                            },
                                          );
                                        }),
                                      ),
                                      //-------------pants
                                      ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(
                                            recommend_pants.length, (idx) {
                                          return RaisedButton(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(18)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 5,
                                                      blurRadius: 3,
                                                    )
                                                  ]),
                                              child: Image.asset(
                                                recommend_pants[idx],
                                                width: 150,
                                                height: 203,
                                                colorBlendMode:
                                                    BlendMode.srcOut,
                                              ),
                                            ),
                                            color: Colors.transparent,
                                            elevation: 0.0,
                                            splashColor: Colors.blueGrey,
                                            onPressed: () {
                                              setState(() {
                                                selected_bottom =
                                                    recommend_pants[idx];
                                              });
                                            },
                                          );
                                        }),
                                      ),
                                      //-------------onepiece
                                      ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(
                                            recommend_onepiece.length, (idx) {
                                          return RaisedButton(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(18)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 5,
                                                      blurRadius: 3,
                                                    )
                                                  ]),
                                              child: Image.asset(
                                                recommend_onepiece[idx],
                                                width: 150,
                                                height: 203,
                                                colorBlendMode:
                                                    BlendMode.srcOut,
                                              ),
                                            ),
                                            color: Colors.transparent,
                                            elevation: 0.0,
                                            splashColor: Colors.blueGrey,
                                            onPressed: () {
                                              setState(() {
                                                selected_top =
                                                    recommend_onepiece[idx];
                                              });
                                            },
                                          );
                                        }),
                                      ),
                                      //-----------outer
                                      ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(
                                            recommend_outer.length, (idx) {
                                          return RaisedButton(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(18)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 5,
                                                      blurRadius: 3,
                                                    )
                                                  ]),
                                              child: Image.asset(
                                                recommend_outer[idx],
                                                width: 150,
                                                height: 203,
                                                colorBlendMode:
                                                    BlendMode.srcOut,
                                              ),
                                            ),
                                            color: Colors.transparent,
                                            elevation: 0.0,
                                            splashColor: Colors.blueGrey,
                                            onPressed: () {
                                              setState(() {
                                                selected_outer =
                                                    recommend_outer[idx];
                                              });
                                            },
                                          );
                                        }),
                                      ),
                                      //--------------shoes
                                      ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(
                                            recommend_shoes.length, (idx) {
                                          return RaisedButton(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(18)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 5,
                                                      blurRadius: 3,
                                                    )
                                                  ]),
                                              child: Image.asset(
                                                recommend_shoes[idx],
                                                width: 150,
                                                height: 203,
                                                colorBlendMode:
                                                    BlendMode.srcOut,
                                              ),
                                            ),
                                            color: Colors.transparent,
                                            elevation: 0.0,
                                            splashColor: Colors.blueGrey,
                                            onPressed: () {
                                              setState(() {
                                                selected_shoes =
                                                    recommend_shoes[idx];
                                              });
                                            },
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        }
                      },
                    )
                    //child: BottomTab(
                    //  select_index: select_index,
                    //),
                    ),
              )),
        ),
      ],
    );
  }
}

//만들었지만 안쓴거ㅠㅠ

class Intabclass extends StatefulWidget {
  String path1, path2, path3;
  Intabclass({String path1, String path2, String path3}) {
    this.path1 = path1;
    this.path2 = path2;
    this.path3 = path3;
  }
  _IntabclassState createState() {
    return _IntabclassState();
  }
}

class _IntabclassState extends State<Intabclass> {
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        RaisedButton(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(18)),
                border: Border.all(width: 1, color: Colors.black12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 3,
                  )
                ]),
            child: Image.asset(
              widget.path1,
              width: 150,
              height: 203,
              colorBlendMode: BlendMode.srcOut,
              //fit: BoxFit.fitHeight,
            ),
          ),
          color: Colors.transparent,
          elevation: 0.0,
          splashColor: Colors.blueGrey,
          onPressed: () {
            setState(() {
              selected_top = widget.path1;
            });
          },
        ),
        RaisedButton(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(18)),
                border: Border.all(width: 1, color: Colors.black12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 3,
                  )
                ]),
            child: Image.asset(
              widget.path2,
              width: 150,
              height: 203,
              colorBlendMode: BlendMode.srcOut,
              //fit: BoxFit.fitHeight,
            ),
          ),
          color: Colors.transparent,
          elevation: 0.0,
          splashColor: Colors.blueGrey,
          onPressed: () {
            // Perform some action
            print("------");
            setState(() {
              selected_top = widget.path2;
            });
          },
        ),
        RaisedButton(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(18)),
                border: Border.all(width: 1, color: Colors.black12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 3,
                  )
                ]),
            child: Image.asset(
              widget.path3,
              width: 150,
              height: 203,
              colorBlendMode: BlendMode.srcOut,
              //fit: BoxFit.fitHeight,
            ),
          ),
          color: Colors.transparent,
          elevation: 0.0,
          splashColor: Colors.blueGrey,
          onPressed: () {
            setState(() {
              selected_top = widget.path3;
            });
          },
        ),
      ],
    );
  }
}

class Tabitem extends StatefulWidget {
  int classification = 0; //0(상의),1(하의),2(아우터),3(원피스),4(신발)
  int order;
  Tabitem({Key key, int classification, int order}) : super(key: key) {
    this.classification = classification;
    this.order = order;
  }
  _TabitemState createState() {
    return _TabitemState();
  }
}

class _TabitemState extends State<Tabitem> {
  Widget build(BuildContext context) {
    String tabitem_path = mycloset_top[widget.order];
    return RaisedButton(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(18)),
            border: Border.all(width: 1, color: Colors.black12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 3,
              )
            ]),
        child: Image.asset(
          tabitem_path,
          width: 150,
          height: 203,
          colorBlendMode: BlendMode.srcOut,
          //fit: BoxFit.fitHeight,
        ),
      ),
      color: Colors.transparent,
      elevation: 0.0,
      splashColor: Colors.blueGrey,
      onPressed: () {
        setState(() {
          selected_top = tabitem_path;
        });
      },
    );
  }
}
