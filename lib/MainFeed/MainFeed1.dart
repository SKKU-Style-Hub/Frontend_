import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stylehub_flutter/Constants.dart';

class MainFeed1 extends StatefulWidget {
  @override
  _MainFeed1State createState() => _MainFeed1State();
}

class _MainFeed1State extends State<MainFeed1> {
  Widget bottomTab(int index) {
    if (index == 0) {
      return Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            '옆으로 스크롤하여 추천된 코디를 확인해보세요.',
            style: kTitleTextStyle,
          ));
    } else {
      return Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Image.asset('assets/images/bottomlist.png'));
    }
  }

  Card StylingCard() {
    List<Widget> pageViewChildren = [
      Container(child: Image.asset('assets/images/sample_knit.png')),
      Container(child: Image.asset('assets/images/sample_knit_styling1.png')),
      Container(child: Image.asset('assets/images/sample_knit_styling2.png')),
    ];
    int currentIndexPage = 0;
    final controller = PageController(initialPage: 0);

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
              Container(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  children: [
                    Image.asset('assets/images/friend4_circle.png'),
                    Text(
                      'Yeji',
                      style: kHashtagTextStyle,
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 15),
                child: Image.asset('assets/images/icon_styling.png'),
              )
            ],
          ),
          Container(
            height: 300,
            width: 300,
            child: PageView(
              //physics: BouncingScrollPhysics(),
              controller: controller,
              children: [
                Container(child: Image.asset('assets/images/sample_knit.png')),
                Container(
                    child:
                        Image.asset('assets/images/sample_knit_styling1.png')),
                Container(
                    child:
                        Image.asset('assets/images/sample_knit_styling2.png')),
              ],
              onPageChanged: (int index) {
                setState(() {
                  currentIndexPage = index;
                  print(currentIndexPage);
                });
              },
            ),
          ),
          SmoothPageIndicator(
            controller: controller,
            count: pageViewChildren.length,
            effect: SlideEffect(dotHeight: 12, dotWidth: 12),
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
          Text(
            'Yeji님의 요청',
            style: kHashtagTextStyle,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              '이 회색 가디건과 어울리는 코디 전체를 추천해주세요! 저는 여성스럽고 단정한 스타일을 좋아해요. 그리고 하의는 편한 밴딩으로 되어있는 스커트였으면 좋겠어요.',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          bottomTab(1)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [StylingCard()],
      ),
    );
  }
}
