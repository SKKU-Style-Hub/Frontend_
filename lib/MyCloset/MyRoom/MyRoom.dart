import 'package:flutter/material.dart';
import 'Userfeedinput1.dart';

int heart_yesno = 0;
Icon heart_icon = Icon(Icons.favorite_border, size: 25, color: Colors.black);

class MyRoom extends StatefulWidget {
  String user_id = "joohee09"; //예; joohee09
  //이것도 나중에 수정해야함
  MyRoom({Key key}) : super(key: key) {}
  _MyRoomState createState() {
    return _MyRoomState();
  }
}

class _MyRoomState extends State<MyRoom> {
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
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              bottom: 10,
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.user_id} 님의 옷장",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black12,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      left: 10,
                      right: 10,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "팔로워 ",
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        Text(
                          "125",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          " 팔로잉 ",
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        Text(
                          "92",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 5,
              bottom: 5,
              left: 10,
              right: 10,
            ),
            child: FlatButton(
              onPressed: () {
                //카메라, 갤러리 연결해서 가져오기!
              },
              minWidth: 400,
              height: 100,
              child: Stack(
                children: [
                  //사진
                  Positioned(
                    //top: 0,
                    //left: 0,
                    child: SizedBox(
                      height: 100,
                      width: 450,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Image.asset(
                          //저장된 프로필?기본사진 받아오기
                          "assets/images/friend_photo1.png",
                          fit: BoxFit.fitWidth,
                          height: 160,
                          //width: 400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              border:
                                  Border.all(width: 0.7, color: Colors.black),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              child: Text(
                                "로맨틱",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              border:
                                  Border.all(width: 0.7, color: Colors.black),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              child: Text(
                                "데일리",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              border:
                                  Border.all(width: 0.7, color: Colors.black),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              child: Text(
                                "페미닌",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: DefaultTabController(
                length: 7,
                child: Scaffold(
                  body: ListView(scrollDirection: Axis.vertical, children: [
                    FriendFeed(),
                  ]),
                  floatingActionButton: FloatingActionButton(
                    mini: true,
                    //foregroundColor: Colors.transparent,
                    elevation: 3,
                    disabledElevation: 6,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.add, color: Colors.black, size: 30),
                    onPressed: () {
                      //피드 만들기 버튼
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Userfeedinput1()),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ), //column의 끝!!!!
    );
  }
}

//myroom 내의 피드
class FriendFeed extends StatefulWidget {
  FriendFeed({Key key}) : super(key: key) {}

  _FriendFeedState createState() {
    return _FriendFeedState();
  }
}

class _FriendFeedState extends State<FriendFeed> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.0, top: 5.0, right: 15.0, bottom: 5),
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        //border: Border.all(width: 1, color: Colors.black12),
        /*boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 3,
            )
          ],*/
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //사진
          SizedBox(
            height: 300,
            child: Image.asset(
              "assets/images/friend_photo1.png",
            ),
          ),
          //좋아요, 댓글
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0, right: 1, left: 10, bottom: 0),
                child: FlatButton(
                  minWidth: 35,
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    setState(() {
                      if (heart_yesno == 0) {
                        heart_yesno = 1;
                        heart_icon = Icon(Icons.favorite,
                            color: Colors.red[400], size: 25);
                      } else {
                        heart_yesno = 0;
                        heart_icon = Icon(Icons.favorite_border,
                            color: Colors.black, size: 25);
                      }
                    });
                  },
                  child: heart_icon,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0, right: 10, left: 0, bottom: 0),
                child: FlatButton(
                  minWidth: 40,
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    //댓글창띄우면서 키보드도 같이 띄우기
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CommentOfFeed(
                                autofocus: true,
                              )),
                    );
                  },
                  child: Icon(Icons.mode_comment_outlined,
                      color: Colors.black, size: 25),
                ),
              ),
            ],
          ),
          //글
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 0, right: 10, left: 20, bottom: 3),
                child: Text("#NEW #신상 #출근룩 #OOTD",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14,
                    )),
              ),
            ],
          ),
          //댓글 다 보기
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 5, right: 10, left: 20, bottom: 5),
                //높이 수정..??ㅠㅠ
                child: InkWell(
                  onTap: () {
                    //댓글창띄우면서 키보드는 안 띄우기
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CommentOfFeed(
                                autofocus: false,
                              )),
                    );
                  },
                  child: Text("1개의 댓글 모두 보기",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//댓글화면
class CommentOfFeed extends StatefulWidget {
  String comment_for_feed;
  bool _autofocus = true;
  CommentOfFeed({Key key, bool autofocus}) : super(key: key) {
    this._autofocus = autofocus;
  }
  _CommentOfFeedState createState() {
    return _CommentOfFeedState();
  }
}

class _CommentOfFeedState extends State<CommentOfFeed> {
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: FlatButton(
                    minWidth: 0,
                    color: Colors.transparent,
                    padding: new EdgeInsets.all(0.0),
                    onPressed: () {
                      //pop넣기뒤로가기
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 32,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text("댓글",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: FlatButton(
                    minWidth: 0,
                    color: Colors.transparent,
                    padding: new EdgeInsets.all(0.0),
                    onPressed: () {
                      //댓글창의 보내는 버튼
                    },
                    child: Icon(
                      Icons.send_outlined,
                      color: Colors.black,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                //개개인의 댓글
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      child: Image.asset(
                        "assets/images/friend3_circle.png",
                        height: 80,
                      ),
                    ),
                    //댓글 쓴 사용자
                    Padding(
                      padding: EdgeInsets.only(
                        left: 0,
                        right: 5,
                      ),
                      child: Text("_KIWI",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                    ),
                    //댓글
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                      child: Text("잘 보고 가요!",
                          style: TextStyle(color: Colors.black, fontSize: 15)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //댓글 입력창
          Container(
            //width: 450,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Image.asset(
                    "assets/images/friend3_circle.png",
                    height: 35,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 60,
                    child: TextField(
                      //focusNode: NoKeyboardEditableTextFocusNode(),
                      autofocus: widget._autofocus,
                      expands: true,
                      minLines: null,
                      maxLines: null,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        counterStyle: TextStyle(
                          decorationStyle: TextDecorationStyle.solid,
                          color: Colors.blue,
                          fontSize: 16.0,
                        ),
                        //labelStyle: TextStyle(),
                        hintText: "댓글 달기...",
                        hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                        contentPadding: EdgeInsets.only(left: 2.0, top: 2.0),
                      ),
                      onChanged: (String str) {
                        setState(() {
                          //입력된 거 저장함
                          widget.comment_for_feed = str;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
