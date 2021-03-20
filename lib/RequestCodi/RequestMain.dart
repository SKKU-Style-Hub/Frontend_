import 'package:flutter/material.dart';
import 'package:stylehub_flutter/Constants.dart';
import '../FittingRoom/FittingRoom.dart';
import '../Navigation.dart';
import 'RequestPage2.dart';
import 'RequestPage.dart';

class RequestMain extends StatefulWidget {
  @override
  _RequestMainState createState() => _RequestMainState();
}

class _RequestMainState extends State<RequestMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),

          Padding(
            padding: EdgeInsets.only(
              bottom: 5,
              right: 20,
              left: 30,
            ),
            child: Text("· 내가 보낸 코디 요청서", style: kPageTitleTextStyle),
          ),
          //here~~~
          Expanded(
            child: ListView(
              children: [
                MyCodiRequests(
                  explanation: "이 블라우스 아래에 무엇을\n입어야 할까요 ㅠㅠ 도와주세요",
                  year: 2020,
                  month: 12,
                  day: 27,
                  answer_num: 2,
                  heart_num: 7,
                  imagepath: "assets/request_codi/codi3.png",
                  index: 1,
                ),
                MyCodiRequests(
                  explanation: "이런 색 와이드 팬츠에 어울리는\n상의 추천해주세요!!",
                  year: 2020,
                  month: 11,
                  day: 3,
                  answer_num: 1,
                  heart_num: 5,
                  imagepath: "assets/request_codi/codi2.png",
                  index: 2,
                ),
                MyCodiRequests(
                  explanation: "어떤 바지가 잘 어울릴까요??",
                  year: 2020,
                  month: 11,
                  day: 3,
                  answer_num: 1,
                  heart_num: 10,
                  imagepath: "assets/request_codi/codi1.png",
                  index: 3,
                ),
              ],
            ),
          ),
          Center(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              disabledColor: Colors.black,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RequestPage(),
                    ));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: Text(
                  '코디 요청하기',
                  style: kButtonTextStyle,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  //widget만들 자리
  //내가 보낸 코디요청서들
  Widget MyCodiRequests(
      {String explanation,
      int year,
      int month,
      int day,
      int answer_num,
      int heart_num,
      String imagepath,
      int index}) {
    return InkWell(
      onTap: () {
        //코디요청서 눌렀을 때
        //피팅룸으로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Navigation(
                    selectedPosition: 3,
                    //fittingroom_select: index,
                  )),
        );
      },
      child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 10,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              border: Border.all(width: 1, color: Colors.black12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 3,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //이미지
                Padding(
                  padding: EdgeInsets.only(
                    left: 0,
                    right: 10,
                  ),
                  child: SizedBox(
                    height: 105,
                    width: 105,
                    child: Image.asset(
                      imagepath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //보낸 요청 문구
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        explanation,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Noto Sans',
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        //아이디 및 날짜
                        Text(
                          "보낸 날짜: ${year}.${month}.${day}",
                          style: TextStyle(
                            fontFamily: 'Noto Sans',
                            fontSize: 14,
                          ),
                        ),
                        //답변 개수
                        Padding(
                          padding: EdgeInsets.only(
                            right: 8,
                            left: 8,
                          ),
                          child: Text(
                            "답변 ${answer_num}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Noto Sans',
                              fontSize: 14,
                            ),
                          ),
                        ),
                        //좋아요 개수
                        Icon(Icons.favorite, color: Colors.red[400]),
                        Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                            left: 2,
                          ),
                          child: Text(
                            "${heart_num}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Noto Sans',
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

//모든 코디요청서들-예전에 만들어 놓은거
class EachCodiRequests extends StatefulWidget {
  String explanation;
  String user_id;
  int year;
  int month;
  int day;
  int answer_num;
  int heart_num;
  String imagepath;
  EachCodiRequests({
    Key key,
    this.explanation,
    this.user_id,
    this.year,
    this.month,
    this.day,
    this.answer_num,
    this.heart_num,
    this.imagepath,
  }) : super(key: key) {}
  _EachCodiRequestsState createState() {
    return _EachCodiRequestsState();
  }
}

class _EachCodiRequestsState extends State<EachCodiRequests> {
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //코디요청서 눌렀을 때
      },
      child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 10,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              border: Border.all(width: 1, color: Colors.black12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 3,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //이미지
                Padding(
                  padding: EdgeInsets.only(
                    left: 0,
                    right: 10,
                  ),
                  child: SizedBox(
                    height: 105,
                    width: 105,
                    child: Image.asset(
                      widget.imagepath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //보낸 요청 문구
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        widget.explanation,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Noto Sans',
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        //아이디 및 날짜
                        Text(
                          "${widget.user_id}님 / ${widget.year}.${widget.month}.${widget.day}",
                          style: TextStyle(
                            fontFamily: 'Noto Sans',
                            fontSize: 14,
                          ),
                        ),
                        //답변 개수
                        Padding(
                          padding: EdgeInsets.only(
                            right: 8,
                            left: 8,
                          ),
                          child: Text(
                            "답변 ${widget.answer_num}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Noto Sans',
                              fontSize: 14,
                            ),
                          ),
                        ),
                        //좋아요 개수
                        Icon(Icons.favorite, color: Colors.red[400]),
                        Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                            left: 2,
                          ),
                          child: Text(
                            "${widget.heart_num}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Noto Sans',
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
