import 'package:flutter/material.dart';
import 'Userfeedinput1.dart';

//style해준 유저아이디
String styledby_userid = "";

// 반환에 사용할 클래스
class ReturnValue {
  String result;
  ReturnValue({this.result});
}

// 데이터 전달에 사용할 클래스
class Arguments {
  String arg; // 전달에 사용할 데이터
  ReturnValue returnValue; //반환때 사용할 클래스
  Arguments({this.arg: '', this.returnValue});
}

class Userfeedinput3 extends StatefulWidget {
  Widget user_photo; //사진
  String user_comment;
  List<String> user_tags;
  Userfeedinput3({Key key, Widget user_photo}) : super(key: key) {
    this.user_photo = user_photo;
  }

  _Userfeedinput3State createState() {
    return _Userfeedinput3State();
  }
}

class _Userfeedinput3State extends State<Userfeedinput3> {
  Widget build(BuildContext context) {
    Arguments _returnsearch = new Arguments(arg: "haha");
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: FlatButton(
                      minWidth: 10,
                      color: Colors.transparent,
                      padding: new EdgeInsets.all(0.0),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.navigate_before,
                        color: Colors.black,
                        size: 32,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text("새 게시물",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    //child:
                    //    Icon(Icons.navigate_next, color: Colors.black, size: 35)
                    child: Text(
                      "공유",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  //사진
                  Padding(
                    //padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    child: FlatButton(
                      minWidth: 0,
                      color: Colors.transparent,
                      padding: EdgeInsets.all(0.0),
                      child: SizedBox(
                        height: 55,
                        width: 55,
                        child: Container(
                          child: widget.user_photo,
                        ),
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 0,
                                ),
                                content: InkWell(
                                  child: widget.user_photo,
                                  onTap: () {
                                    Navigator.pop(context);
                                    //Navigator.
                                  },
                                ),
                              );
                            });
                      },
                    ),
                  ),
                  //옆에 글 입력
                  Expanded(
                    child: Container(
                      height: 75,
                      child: TextField(
                        //focusNode: NoKeyboardEditableTextFocusNode(),
                        expands: true,
                        minLines: null,
                        maxLines: null,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          counterStyle: TextStyle(
                            decorationStyle: TextDecorationStyle.solid,
                            color: Colors.blue,
                            fontSize: 16.0,
                          ),
                          //labelStyle: TextStyle(),
                          hintText: "문구 입력...",
                          hintStyle:
                              TextStyle(fontSize: 13, color: Colors.black),
                          contentPadding: EdgeInsets.only(left: 2.0, top: 2.0),
                        ),
                        onChanged: (String str) {
                          setState(() {
                            //입력된 거 저장함
                            widget.user_comment = str;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //밑에 선
            Container(
              height: 0.5,
              color: Colors.black,
            ),
            //스타일링은 누구에게?
            Container(
              child: FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Styled by",
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    Row(
                      children: [
                        Builder(
                          builder: (BuildContext context) {
                            /*setState(() {
                                    styledby_userid = _returnsearch.returnValue.result;
                                  });*/
                            if (styledby_userid == null) {
                              return Container();
                            } else {
                              return Text(styledby_userid);
                            }
                          },
                        ),
                        Icon(Icons.navigate_next,
                            color: Colors.black, size: 25),
                      ],
                    ),
                  ],
                ),
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  //검색창으로 넘어가기
                  final result_tmp = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchUser(
                              arguments: Arguments(arg: "haha"),
                            )),
                  );
                  print('result is ${result_tmp}');
                  if (result_tmp != null) {
                    setState(() {
                      styledby_userid = result_tmp.returnValue.result;
                    });
                  }
                },
              ),
            ),
            //밑에 선
            Container(
              height: 0.5,
              color: Colors.black,
            ),
            //그냥 빈공간임. 클릭위해 만든겨
            Container(height: 450, color: Colors.white),
          ],
        ),
      ),
    ));
  }
}

class SearchUser extends StatefulWidget {
  final arguments;
  SearchUser({Key key, this.arguments}) : super(key: key) {}
  _SearchUserState createState() {
    return _SearchUserState();
  }
}

class _SearchUserState extends State<SearchUser> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 8),
          //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 250,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.black12,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 20,
                      ),
                      Container(
                        width: 200,
                        //color: Colors.black,
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: TextField(
                            minLines: 1,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "사람 검색...",
                              hintStyle:
                                  TextStyle(fontSize: 13, color: Colors.black),
                              contentPadding: EdgeInsets.only(
                                left: 10.0,
                                //bottom: 1.0,
                              ),
                            ),
                            onChanged: (String str) {
                              setState(() {
                                //입력된 거 저장함
                                styledby_userid = str;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FlatButton(
                minWidth: 0,
                child: Text("취소",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () {
                  //전화면으로 돌아가기
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        //styledby_userid 시작하는거대로 나타내기
        Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(0),
            children: [
              Container(
                height: 60,
                child: FlatButton(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  minWidth: 0,
                  onPressed: () {
                    //눌러서 이름 가져가기
                    Navigator.pop(
                        context,
                        Arguments(
                            returnValue: ReturnValue(result: styledby_userid)));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 45,
                        width: 45,
                        //유저사진
                        child: Image.asset(
                          "assets/images/friend3_circle.png",
                          height: 45,
                          width: 45,
                          //fit: BoxFit.fill,
                        ),
                      ),
                      //유저아이디
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          styledby_userid,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
