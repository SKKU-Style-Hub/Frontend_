import 'package:flutter/material.dart';
//import 'package:stylehub_flutter/MainFeed/MainFeedComponents.dart';
import 'package:stylehub_flutter/data/CategoryType.dart';
import 'package:stylehub_flutter/main.dart';
import 'MainFeed.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stylehub_flutter/Constants.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'package:stylehub_flutter/MainFeed/CodiFittingRoom.dart';
import 'package:stylehub_flutter/components/ClothInfo.dart';
import 'package:stylehub_flutter/data/ProposedCodi.dart';
import 'RawData.dart';
import 'GeneratedComponents.dart';

//여기 인자를 바꾸고 아래로 넘어가자
class StylingCard extends StatefulWidget {
  Post post;
  bool isLiked;
  List<Comment> comments;
  StylingCard({Key key, this.post, this.isLiked = false, this.comments})
      : super(key: key) {}
  _StylingCardState createState() {
    return _StylingCardState();
  }
}

class _StylingCardState extends State<StylingCard> {
  bool isLiked = false;
  List<Comment> comments;

  @override
  void initState() {
    isLiked = widget.isLiked;

    if (widget.comments == null) {
      comments = [];
    } else {
      comments = widget.comments;
    }
  }

  Widget EachInfoButton(StylingResult stylingResult, int index) {
    return Positioned(
      //위치 정보를 넣어야 함
      top: stylingResult.components[index].ycordinate,
      left: stylingResult.components[index].xcordinate,
      child: Container(
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //말풍선
            Builder(
              builder: (BuildContext context) {
                if (stylingResult.codiClick == index) {
                  return InkWell(
                      onTap: () {},
                      child: SpeechBubble(
                        height: 45,
                        color: Colors.black,
                        nipLocation: NipLocation.BOTTOM,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              stylingResult.components[index].brand,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              //원래 가격인데 가격이 없어서 색깔로 넣음
                              stylingResult.components[index].color,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ));
                } else {
                  return Container(
                    height: 45,
                  );
                }
              },
            ),
            //원모양
            InkWell(
              onTap: () {
                setState(() {
                  stylingResult.codiClick = index;
                  //swb 변경 부분
                  //codi1_swb = codiTotal.clothList[index].clothSbw;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  color: stylingResult.codiClick != index
                      ? notClickedColor
                      : clickedColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  " ",
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget EachCodi(StylingResult stylingResult) {
    return Container(
      child: Stack(
        children: [
          Positioned(
              child: Image.network(
            stylingResult.stylingImage,
            fit: BoxFit.cover,
            width: 500,
          )),
          for (var i in [0, stylingResult.components.length - 1])
            Builder(builder: (BuildContext context) {
              if (stylingResult.components[i] != null) {
                return EachInfoButton(stylingResult, i);
              } else {
                return Container();
              }
            }),
        ],
      ),
    );
  }

  Widget goToCodiScreen({String requestClothingImg}) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                //피팅룸에 넘어갈 옷
                builder: (context) => CodiFittingRoom(
                  requestClothInfo: ClothInfo(
                    image: requestClothingImg,
                    type: 1,
                  ),
                ),
              ));
        },
        child: Center(child: Text("나도 코디하러가기")),
      ),
    );
  }

  Card StylingCardWidget(Post post) {
    List<Widget> pageViewChildren = [];

    pageViewChildren.add(Container(
        child: Image.network(
            post.content.stylingRequest.requestClothings[0].clothingImage)));
    for (int i = 0; i < post.content.stylingResult.length; i++) {
      pageViewChildren.add(Container(
          child: Image.network(post.content.stylingResult[i].stylingImage)));
    }
    //pageViewChildren.add(Container());
    int currentIndexPage = 0;
    final controller = PageController(initialPage: 0);
    final bottomController = PageController(initialPage: 0);

    return Card(
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: Colors.black,
      elevation: 7,
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage(post.userProfile.profileImage),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    post.userProfile.userNickname,
                    style: kHashtagTextStyle,
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  //goToCodiScreen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        //피팅룸에 넘어갈 옷
                        //여기 좀 더 수정 많이 해서 넘기자!!!!!
                        builder: (context) => CodiFittingRoom(
                          requestClothInfo: ClothInfo(
                            image: post.content.stylingRequest
                                .requestClothings[0].clothingImage,
                            type: categoryToType(post.content.stylingRequest
                                .requestClothings[0].tagResult.category),
                          ),
                          stylingRequest: post.content.stylingRequest,
                        ),
                      ));
                },
                child: Container(
                  height: 65,
                  margin: EdgeInsets.only(right: 15),
                  child: Image.asset('assets/images/icon_styling.png'),
                ),
              )
            ],
          ),
          GestureDetector(
            onDoubleTap: () {
              setState(() {
                isLiked = !isLiked;
              });
            },
            child: Container(
              height: 350,
              width: 300,
              child: PageView(
                //physics: BouncingScrollPhysics(),
                controller: controller,
                children: [
                  //첫번째 페이지
                  Container(
                      //요청한 옷 사진
                      child: Image.network(post.content.stylingRequest
                          .requestClothings[0].clothingImage)),
                  for (var i in post.content.stylingResult) EachCodi(i),
                  //goToCodiScreen(
                  //    requestClothingImg: tmpProposedCodi.requestClothingImg),
                ],
                onPageChanged: (int index) {
                  setState(() {
                    bottomController.jumpToPage(index);
                    currentIndexPage = index;
                    print(currentIndexPage);
                  });
                },
              ),
            ),
          ),
          pageViewChildren.length > 1
              ? SmoothPageIndicator(
                  controller: controller,
                  count: pageViewChildren.length,
                  effect: SlideEffect(dotHeight: 12, dotWidth: 12),
                )
              : Container(),
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
                                        itemCount: comments != null
                                            ? comments.length
                                            : 0,
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
          Text(
            '${post.userProfile.userNickname}님의 요청',
            style: kHashtagTextStyle,
          ),
          Container(
            //alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              post.content.stylingRequest.requestContent,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          Container(
            height: 100,
            width: 450,
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: bottomController,
              children: [
                Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: Text(
                        '옆으로 스크롤하여 추천된 코디를 확인해보세요.',
                        style: kTitleTextStyle,
                      ),
                    )),
                //밑에 buy유저, wish유저 등
                //첫번째코디 밑 사진
                /*Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: SwbInfo(
                      tmpProposedCodi.proposedCodiList[0].selectedClothSbw),
                ),
                //두번째코디 밑 사진
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: SwbInfo(
                      tmpProposedCodi.proposedCodiList[1].selectedClothSbw),
                ),*/
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    print(widget.post.userProfile.profileImage);
    if (widget.post.userProfile.profileImage == null) {
      widget.post.userProfile.profileImage =
          "https://user-images.githubusercontent.com/65387279/113335492-fc5c0f80-935f-11eb-8580-827b24162791.png";
    }
    return StylingCardWidget(widget.post);
  }
}
