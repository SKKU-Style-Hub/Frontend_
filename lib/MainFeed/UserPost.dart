import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stylehub_flutter/Constants.dart';
import 'package:stylehub_flutter/main.dart';
import 'Comment.dart';

class UserPost extends StatefulWidget {
  String userNickname;
  String userProfileImg;
  List<String> postImgList;
  String postContent;
  List<Comment> comments;
  DateTime postTime;
  bool isLiked;
  String myComment;
  UserPost(
      {String userNickname,
      String userProfileImg,
      List<String> postImgList,
      String postContent,
      List<Comment> comments,
      DateTime postTime,
      bool isLiked,
      String myComment}) {
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
  List<Comment> comments;
  getImages() {
    List<Widget> posts = [];
    for (String url in widget.postImgList) {
      posts.add(Container(child: Image.network(url)));
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
  }

  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();
    String writingComment = "";
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
                width: 300,
                height: 300,
                child: PageView(
                  controller: controller,
                  children: getImages(),
                ),
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
                                                          .userProfileImg),
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
                                      onTap: () {
                                        if (writingComment != null) {
                                          setState(() {
                                            comments.add(Comment(
                                                userNickname:
                                                    StyleHub.myNickname,
                                                userProfileImg:
                                                    StyleHub.myProfileImg,
                                                commentContent:
                                                    writingComment));
                                          });
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
            child: Center(
              child: Text(
                widget.postContent,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text("${widget.postTime.month}월 ${widget.postTime.day}일"),
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
                onTap: () {
                  if (writingComment != null) {
                    setState(() {
                      myComment = writingComment;
                      comments.add(Comment(
                          userNickname: StyleHub.myNickname,
                          userProfileImg: StyleHub.myProfileImg,
                          commentContent: writingComment));
                    });
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
