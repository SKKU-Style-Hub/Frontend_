import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stylehub_flutter/Constants.dart';

class UserPost extends StatefulWidget {
  String userNickname;
  String userProfileImg;
  List<String> postImgList;
  String postContent;
  UserPost(
      {String userNickname,
      String userProfileImg,
      List<String> postImgList,
      String postContent}) {
    this.userNickname = userNickname;
    this.userProfileImg = userProfileImg;
    this.postImgList = postImgList;
    this.postContent = postContent;
  }

  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  final controller = PageController(initialPage: 0);

  getImages() {
    List<Widget> posts = [];
    for (String url in widget.postImgList) {
      posts.add(Container(child: Image.network(url)));
    }
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: Colors.black,
      elevation: 7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(widget.userProfileImg),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                widget.userNickname,
                style: kHashtagTextStyle,
              )
            ],
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              width: 300,
              height: 300,
              child: PageView(
                controller: controller,
                children: getImages(),
              ),
            ),
          ),
          Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: widget.postImgList.length,
              effect: SlideEffect(dotHeight: 12, dotWidth: 12),
            ),
          ),
          Row(
            children: [
              Container(
                child: Image.asset(
                  'assets/images/heart_btn.png',
                ),
                padding: EdgeInsets.all(10),
              ),
              Container(
                child: Image.asset('assets/images/comments_btn.png'),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Text(
                widget.postContent,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
