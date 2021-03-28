import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Comment.dart';
import 'CreatePost.dart';
import 'RawData.dart';
import 'StylingCard.dart';
import 'UserPost.dart';

Color notClickedColor = Colors.grey[800]; //선택하지 않은 버튼의 색깔
Color clickedColor = Colors.indigo; //선택된 색깔

class MainFeed extends StatefulWidget {
  @override
  _MainFeedState createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeed> {
  String myNickname;
  String myProfileImg;
  ScrollController scrollController = ScrollController();
  bool showActionButton = true;

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      myNickname = prefs.getString('userNickname');
      myProfileImg = prefs.getString('userProfileImg');
    });
  }

  addListener() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          showActionButton = false;
        });
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          showActionButton = true;
        });
      }
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    addListener();
    return Scaffold(
      floatingActionButton: Visibility(
        visible: showActionButton,
        child: FloatingActionButton(
          child: Icon(Icons.create),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreatePost()));
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: scrollController,
              children: [
                StylingCard(
                  tmpAllCodi: allProposedCodi1,
                  myNickname: myNickname,
                  myProfileImg: myProfileImg,
                  isLiked: false,
                ),
                UserPost(
                  myNickname: myNickname,
                  myProfileImg: myProfileImg,
                  userNickname: "ddd",
                  userProfileImg:
                      "https://www.ui4u.go.kr/depart/img/content/sub03/img_con03030100_01.jpg",
                  postImgList: [
                    "https://image.ajunews.com/content/image/2021/03/05/20210305085249990180.png",
                    "https://image.ajunews.com/content/image/2021/03/05/20210305085249990180.png",
                  ],
                  postContent:
                      "ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ",
                  comments: [
                    Comment(
                        userNickname: "eee",
                        userProfileImg:
                            "https://image.ajunews.com/content/image/2021/03/05/20210305085249990180.png",
                        commentContent: "아이유 예쁘다")
                  ],
                  postTime: DateTime(2021, 3, 29, 17, 30),
                  isLiked: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
