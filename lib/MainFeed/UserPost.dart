import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stylehub_flutter/Constants.dart';
import 'package:stylehub_flutter/main.dart';
import 'GeneratedComponents.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserPost extends StatefulWidget {
  String sid;
  String userNickname;
  String userProfileImg;
  List<String> postImgList;
  String postContent;
  List<Comments> comments;
  String postTime;
  bool isLiked;
  String myComment;
  UserPost(
      {String sid,
      String userNickname,
      String userProfileImg,
      List<String> postImgList,
      String postContent,
      List<Comments> comments,
      String postTime,
      bool isLiked,
      String myComment}) {
    this.sid = sid;
    this.userNickname = userNickname;
    this.userProfileImg = userProfileImg;
    this.postImgList = postImgList;
    this.postContent = postContent;
    this.comments = comments;
    this.postTime = postTime;
    this.isLiked = isLiked;
    this.myComment = myComment;
  }

  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  final controller = PageController(initialPage: 0);
  bool isLiked = false;
  String myComment;
  List<Comments> comments;
  getImages() {
    List<Widget> posts = [];
    for (String url in widget.postImgList) {
      posts.add(Container(
        child: Image.network(
          url,
          fit: BoxFit.fitHeight,
        ),
      ));
    }
    return posts;
  }

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
    myComment = widget.myComment;
    if (widget.comments == null) {
      comments = [];
    } else {
      comments = widget.comments;
    }
    if (widget.userProfileImg == null) {
      widget.userProfileImg =
          "https://user-images.githubusercontent.com/65387279/113335492-fc5c0f80-935f-11eb-8580-827b24162791.png";
    }
    if (widget.userNickname == null) {
      widget.userNickname = "jihye";
    }
  }

  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();
    String writingComment = "";
    if (widget.userProfileImg == null) {
      widget.userProfileImg =
          "https://user-images.githubusercontent.com/65387279/113335492-fc5c0f80-935f-11eb-8580-827b24162791.png";
    }
    if (widget.userNickname == null) {
      widget.userNickname = "jihye";
    }
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
                backgroundColor: Colors.transparent,
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
            child: GestureDetector(
              onDoubleTap: () {
                setState(() {
                  isLiked = !isLiked;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                width: 350,
                height: 300,
                child: PageView(
                  controller: controller,
                  children: getImages(),
                ),
              ),
            ),
          ),
          Center(
            child: widget.postImgList.length > 1
                ? SmoothPageIndicator(
                    controller: controller,
                    count: widget.postImgList.length,
                    effect: SlideEffect(dotHeight: 12, dotWidth: 12),
                  )
                : Container(),
          ),
          Row(
            children: [
              GestureDetector(
                child: Container(
                  height: 28,
                  child: isLiked
                      ? Image.asset(
                          'assets/images/heart_btn_clicked.png',
                        )
                      : Image.asset(
                          'assets/images/heart_btn_not_clicked.png',
                        ),
                  margin: EdgeInsets.all(15),
                ),
                onTap: () {
                  setState(() {
                    isLiked = !isLiked;
                    //send server
                  });
                },
              ),
              GestureDetector(
                child: Container(
                  height: 28,
                  child: Image.asset('assets/images/comments_btn.png'),
                  margin: EdgeInsets.symmetric(vertical: 15),
                ),
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      context: context,
                      builder: (BuildContext context) {
                        final commentController = TextEditingController();
                        String writingComment = "";
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                child: Text(
                                  "댓글",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              comments.isEmpty
                                  ? Container(
                                      child: Text(
                                        "첫 댓글을 남겨보세요!",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey[500]),
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 30),
                                    )
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: comments.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                CircleAvatar(
                                                  radius: 22,
                                                  backgroundImage: NetworkImage(
                                                      comments[index]
                                                          .userProfile
                                                          .profileImage),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      comments[index]
                                                          .userProfile
                                                          .userNickname,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      comments[index]
                                                          .commentContent,
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(color: Colors.grey))),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundImage:
                                          NetworkImage(StyleHub.myProfileImg),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      width: 280,
                                      child: TextField(
                                        controller: commentController,
                                        decoration: InputDecoration(
                                            hintText: "댓글 입력..."),
                                        onChanged: (value) {
                                          writingComment = value;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 18,
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        "게시",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.blue),
                                      ),
                                      onTap: () async {
                                        if (writingComment != null) {
                                          setState(() {
                                            comments.add(Comments(
                                                userProfile: UserProfile(
                                                    userNickname:
                                                        StyleHub.myNickname,
                                                    profileImage:
                                                        StyleHub.myProfileImg),
                                                commentContent:
                                                    writingComment));
                                          });
                                          String url =
                                              "http://34.64.196.105:82/api/comment/create";
                                          await http.post(url,
                                              headers: {
                                                'Content-type':
                                                    'application/json',
                                                'Accept': 'application/json',
                                                'Charset': 'utf-8'
                                              },
                                              body: jsonEncode({
                                                "feedId": widget.sid,
                                                "userProfile": {
                                                  "userNickname":
                                                      StyleHub.myNickname,
                                                  "profileImg":
                                                      StyleHub.myProfileImg,
                                                  "comment": writingComment
                                                },
                                              }));
                                          commentController.clear();
                                          FocusScope.of(context).unfocus();
                                        }
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      });
                },
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              widget.postContent,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text("${widget.postTime.substring(0, 10)}"),
          ),
          SizedBox(
            height: 7,
          ),
          myComment != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        StyleHub.myNickname,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        myComment,
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                )
              : Container(),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(StyleHub.myProfileImg),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 250,
                child: TextField(
                  controller: commentController,
                  decoration: InputDecoration(hintText: "댓글 입력..."),
                  onChanged: (value) {
                    writingComment = value;
                  },
                ),
              ),
              SizedBox(
                width: 18,
              ),
              GestureDetector(
                child: Text(
                  "게시",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
                onTap: () async {
                  if (writingComment != null) {
                    setState(() {
                      myComment = writingComment;
                      comments.add(Comments(
                          userProfile: UserProfile(
                              userNickname: StyleHub.myNickname,
                              profileImage: StyleHub.myProfileImg),
                          commentContent: writingComment));
                    });
                    String url = "http://34.64.196.105:82/api/comment/create";
                    await http.post(url,
                        headers: {
                          'Content-type': 'application/json',
                          'Accept': 'application/json',
                          'Charset': 'utf-8'
                        },
                        body: jsonEncode({
                          "feedId": widget.sid,
                          "userProfile": {
                            "userNickname": StyleHub.myNickname,
                            "profileImg": StyleHub.myProfileImg,
                            "comment": writingComment
                          },
                        }));
                    commentController.clear();
                    FocusScope.of(context).unfocus();
                    print(myComment);
                  }
                },
              )
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
