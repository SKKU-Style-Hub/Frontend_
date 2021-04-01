import 'package:flutter/material.dart';
import 'package:stylehub_flutter/MainFeed/MainFeedComponents.dart';
import 'package:stylehub_flutter/main.dart';
import 'MainFeed.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stylehub_flutter/Constants.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'package:stylehub_flutter/MainFeed/CodiFittingRoom.dart';
import 'package:stylehub_flutter/components/ClothInfo.dart';
import 'package:stylehub_flutter/data/ProposedCodi.dart';
import 'RawData.dart';

class StylingCard extends StatefulWidget {
  AllProposedCodi tmpAllCodi;
  bool isLiked;
  List<Comment> comments;
  StylingCard({Key key, this.tmpAllCodi, this.isLiked = false, this.comments})
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

  Widget EachInfoButton(ProposedCodi codiTotal, int index) {
    return Positioned(
      //위치 정보를 넣어야 함
      top: codiTotal.clothList[index].yCoordinate,
      left: codiTotal.clothList[index].xCoordinate,
      child: Container(
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //말풍선
            Builder(
              builder: (BuildContext context) {
                if (codiTotal.codiClick.clickint[index] == 1) {
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
                              codiTotal.clothList[index].brandName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              codiTotal.clothList[index].price.toString(),
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
                  codiTotal.codiClick.FocusOnThis(index);
                  //swb 변경 부분
                  //codi1_swb = codiTotal.clothList[index].clothSbw;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  color: codiTotal.codiClick.clickint[index] == 0
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

  Widget EachCodi(ProposedCodi codiTotal) {
    return Container(
      child: Stack(
        children: [
          Positioned(
              child: Image.asset(
            codiTotal.codiImage,
            fit: BoxFit.cover,
            width: 500,
          )),
          //1.상의
          Builder(builder: (BuildContext context) {
            if (codiTotal.clothList[1] != null) {
              return EachInfoButton(codiTotal, 1);
            } else {
              return Container();
            }
          }),
          //2.하의
          Builder(builder: (BuildContext context) {
            if (codiTotal.clothList[2] != null) {
              return EachInfoButton(codiTotal, 2);
            } else {
              return Container();
            }
          }),
          //3.원피스
          Builder(builder: (BuildContext context) {
            if (codiTotal.clothList[3] != null) {
              return EachInfoButton(codiTotal, 3);
            } else {
              return Container();
            }
          }),
          //4.아우터
          Builder(builder: (BuildContext context) {
            if (codiTotal.clothList[4] != null) {
              return EachInfoButton(codiTotal, 4);
            } else {
              return Container();
            }
          }),
          //5.신발
          Builder(builder: (BuildContext context) {
            if (codiTotal.clothList[5] != null) {
              return EachInfoButton(codiTotal, 5);
            } else {
              return Container();
            }
          }),
          //6.가방
          Builder(builder: (BuildContext context) {
            if (codiTotal.clothList[6] != null) {
              return EachInfoButton(codiTotal, 6);
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

  Card StylingCardWidget(AllProposedCodi tmpProposedCodi) {
    List<Widget> pageViewChildren = [];

    pageViewChildren
        .add(Container(child: Image.asset(tmpProposedCodi.requestClothingImg)));
    for (int i = 0; i < tmpProposedCodi.proposedCodiList.length; i++) {
      pageViewChildren.add(Container(
          child: Image.asset(tmpProposedCodi.proposedCodiList[i].codiImage)));
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
                    backgroundImage: NetworkImage(tmpProposedCodi.userProfile),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    tmpProposedCodi.userId,
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
                        builder: (context) => CodiFittingRoom(
                          requestClothInfo: ClothInfo(
                            image: tmpProposedCodi.requestClothingImg,
                            type: 1,
                          ),
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
                      child: Image.asset(tmpProposedCodi.requestClothingImg)),
                  for (var i in [
                    0,
                    tmpProposedCodi.proposedCodiList.length - 1
                  ])
                    EachCodi(tmpProposedCodi.proposedCodiList[i]),
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
          SmoothPageIndicator(
            controller: controller,
            count: pageViewChildren.length,
            effect: SlideEffect(dotHeight: 12, dotWidth: 12),
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
            '${tmpProposedCodi.userId}님의 요청',
            style: kHashtagTextStyle,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              tmpProposedCodi.explanation.toString(),
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
    return StylingCardWidget(widget.tmpAllCodi);
  }
}
