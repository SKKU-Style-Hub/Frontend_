import 'dart:convert';
import '../MainFeed/GeneratedComponents.dart';
import 'package:flutter/material.dart';
import 'package:codime/Constants.dart';
import '../Navigation.dart';
import 'RequestPage.dart';
import 'package:http/http.dart' as http;
import 'package:codime/main.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RequestMain extends StatefulWidget {
  @override
  _RequestMainState createState() => _RequestMainState();
}

class _RequestMainState extends State<RequestMain> {
  List<StylingRequest> requests = [];
  void getRequestList() async {
    String url = "http://34.64.196.105:82/api/styling/request/list/my";
    var response = await http.post(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Charset': 'utf-8'
        },
        body: jsonEncode({
          "userProfile": {
            "userNickname": StyleHub.myNickname,
          },
        }));
    //print(response.body);
    var results = jsonDecode(response.body);
    //List<dynamic> list = jsonDecode(utf8.decode(response.bodyBytes));
    for (var result in results) {
      //print(result);
      StylingRequest tmp = StylingRequest.fromJson(result);
      setState(() {
        requests.add(tmp);
      });
    }
  }

  @override
  void initState() {
    getRequestList();
  }

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
            child: requests.length != 0
                ? ListView.builder(
                    itemCount: requests.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MyCodiRequests(
                          explanation: requests[index].requestContent,
                          year: int.parse(
                              requests[index].createdAt.substring(0, 4)),
                          month: int.parse(
                              requests[index].createdAt.substring(5, 7)),
                          day: int.parse(
                              requests[index].createdAt.substring(8, 10)),
                          answer_num: requests[index].resultCounter,
                          heart_num: requests[index].likeCounter,
                          imagepath:
                              requests[index].requestClothings[0].clothingImage,
                          index: index);
                    },
                  )
                : Center(
                    child: Text(
                    "작성한 코디 요청이 없습니다.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.grey),
                  )),
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
                    child: CachedNetworkImage(
                      imageUrl: imagepath,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //보낸 요청 문구
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Container(
                        width: 260,
                        child: Text(
                          explanation,
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Noto Sans',
                            fontSize: 15,
                          ),
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
  }) : super(key: key);
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
                    child: CachedNetworkImage(
                      imageUrl: widget.imagepath,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
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
