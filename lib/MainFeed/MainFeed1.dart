import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stylehub_flutter/Constants.dart';
import 'package:speech_bubble/speech_bubble.dart';

class Codi_click {
  //코디화면에서 클릭했는지 안 클릭했는지를 나타내는 class
  int outer = 0, top = 0, bottom = 0, bag = 0, shoes = 0, all;
  Color circlebutton_color_outer = Colors.indigo;
  Color circlebutton_color_top = Colors.grey[800];
  Color circlebutton_color_bottom = Colors.grey[800];
  Color circlebutton_color_bag = Colors.grey[800];
  Color circlebutton_color_shoes = Colors.grey[800];
  Codi_click(
      {this.outer, this.top, this.bag, this.shoes, this.bottom, this.all}) {
    if (all != null) {
      outer = all;
      top = all;
      bottom = all;
      bag = all;
      shoes = all;
    }
    circlebutton_color_outer = Colors.indigo;
    circlebutton_color_top = Colors.grey[800];
    circlebutton_color_bottom = Colors.grey[800];
    circlebutton_color_bag = Colors.grey[800];
    circlebutton_color_shoes = Colors.grey[800];
  }
}

//stylingfeed에서 각 옷마다 style.buy.wish정보를 담고 있는 것
class Cloth_sbw {
  String style_path;
  String style_name;
  String buy_path;
  String buy_name;
  String wish_path;
  String wish_name;
  Cloth_sbw(
      {this.buy_name,
      this.buy_path,
      this.style_name,
      this.style_path,
      this.wish_name,
      this.wish_path}) {}
}

List bottom_size = [];

class MainFeed1 extends StatefulWidget {
  @override
  _MainFeed1State createState() => _MainFeed1State();
}

//클릭 초기화
Codi_click codi1 = Codi_click(all: 0);
Codi_click codi2 = Codi_click(all: 0);

//기본 style.wish.buy정보
Cloth_sbw codi1_swb = Cloth_sbw(
    buy_name: "minhee99",
    buy_path: 'assets/mainfeed_person/codi1_outer_buy.jpg',
    style_name: "roro_",
    style_path: "assets/mainfeed_person/codi1_outer_style.jpg",
    wish_name: "asdfas",
    wish_path: 'assets/mainfeed_person/codi1_outer_wish.jpg');
Cloth_sbw codi2_swb = Cloth_sbw(
    buy_name: "minhee99",
    buy_path: 'assets/mainfeed_person/codi1_outer_buy.jpg',
    style_name: "roro_",
    style_path: "assets/mainfeed_person/codi1_outer_style.jpg",
    wish_name: "asdfas",
    wish_path: 'assets/mainfeed_person/codi1_outer_wish.jpg');

class _MainFeed1State extends State<MainFeed1> {
  void initState() {
    codi1.outer = 1;
    codi2.outer = 1;
    super.initState();
  }

  Widget swb_info(Cloth_sbw tmp) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //style
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 55,
                width: 55,
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    tmp.style_path,
                  ),
                  radius: 48,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: 2.0, top: 1.0, right: 2.0, bottom: 1.0),
                child: Text(" STYLE ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      backgroundColor: Colors.indigo,
                    )),
              ),
              //아이디
              Text(
                tmp.style_name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        //wish
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 55,
                width: 55,
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    tmp.wish_path,
                  ),
                  radius: 48,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: 2.0, top: 1.0, right: 2.0, bottom: 1.0),
                child: Text(" WISH ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      backgroundColor: Colors.green,
                    )),
              ),
              //아이디
              Text(
                tmp.wish_name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        //buy
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 55,
                width: 55,
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    tmp.buy_path,
                  ),
                  radius: 48,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: 2.0, top: 1.0, right: 2.0, bottom: 1.0),
                child: Text(" BUY ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      backgroundColor: Colors.red,
                    )),
              ),
              //아이디
              Text(
                tmp.buy_name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Card StylingCard() {
    List<Widget> pageViewChildren = [
      Container(child: Image.asset('assets/images/sample_knit.png')),
      Container(child: Image.asset('assets/images/sample_knit_styling1.png')),
      Container(child: Image.asset('assets/images/sample_knit_styling2.png')),
    ];
    int currentIndexPage = 0;
    final controller = PageController(initialPage: 0);
    final bottomController = PageController(initialPage: 0);

    Cloth_sbw codi1_outer = Cloth_sbw(
        buy_name: "minhee99",
        buy_path: 'assets/mainfeed_person/codi1_outer_buy.jpg',
        style_name: "roro_",
        style_path: "assets/mainfeed_person/codi1_outer_style.jpg",
        wish_name: "asdfas",
        wish_path: 'assets/mainfeed_person/codi1_outer_wish.jpg');
    Cloth_sbw codi1_top = Cloth_sbw(
        buy_name: "chungha",
        buy_path: 'assets/mainfeed_person/codi1_top_buy.jpg',
        style_name: "sdfasd",
        style_path: "assets/mainfeed_person/codi1_top_style.jpg",
        wish_name: "lololo",
        wish_path: 'assets/mainfeed_person/codi1_top_wish.jpg');
    Cloth_sbw codi1_bottom = Cloth_sbw(
        buy_name: "jipga",
        buy_path: 'assets/mainfeed_person/codi1_bottom_buy.jpg',
        style_name: "whfflek",
        style_path: "assets/mainfeed_person/codi1_bottom_style.jpg",
        wish_name: "wlsWKWK",
        wish_path: 'assets/mainfeed_person/codi1_bottom_wish.jpg');
    Cloth_sbw codi1_bag = Cloth_sbw(
        buy_name: "skssnrnrp",
        buy_path: 'assets/mainfeed_person/codi1_bag_buy.jpg',
        style_name: "ahfmwl",
        style_path: "assets/mainfeed_person/codi1_bag_style.jpg",
        wish_name: "SHEKE",
        wish_path: 'assets/mainfeed_person/codi1_bag_wish.jpg');
    Cloth_sbw codi1_shoes = Cloth_sbw(
        buy_name: "fkfkfk",
        buy_path: 'assets/mainfeed_person/codi1_shoes_buy.jpg',
        style_name: "dksehoO",
        style_path: "assets/mainfeed_person/codi1_shoes_style.jpg",
        wish_name: "ziziziI",
        wish_path: 'assets/mainfeed_person/codi1_shoes_wish.jpg');

    Cloth_sbw codi2_outer = Cloth_sbw(
        wish_name: "minhee99",
        wish_path: 'assets/mainfeed_person/codi1_outer_buy.jpg',
        buy_name: "roro_",
        buy_path: "assets/mainfeed_person/codi1_outer_style.jpg",
        style_name: "asdfas",
        style_path: 'assets/mainfeed_person/codi1_outer_wish.jpg');
    Cloth_sbw codi2_top = Cloth_sbw(
        wish_name: "chungha",
        wish_path: 'assets/mainfeed_person/codi1_top_buy.jpg',
        buy_name: "sdfasd",
        buy_path: "assets/mainfeed_person/codi1_top_style.jpg",
        style_name: "lololo",
        style_path: 'assets/mainfeed_person/codi1_top_wish.jpg');
    Cloth_sbw codi2_bottom = Cloth_sbw(
        wish_name: "jipga",
        wish_path: 'assets/mainfeed_person/codi1_bottom_buy.jpg',
        buy_name: "whfflek",
        buy_path: "assets/mainfeed_person/codi1_bottom_style.jpg",
        style_name: "wlsWKWK",
        style_path: 'assets/mainfeed_person/codi1_bottom_wish.jpg');
    Cloth_sbw codi2_bag = Cloth_sbw(
        wish_name: "skssnrnrp",
        wish_path: 'assets/mainfeed_person/codi1_bag_buy.jpg',
        buy_name: "ahfmwl",
        buy_path: "assets/mainfeed_person/codi1_bag_style.jpg",
        style_name: "SHEKE",
        style_path: 'assets/mainfeed_person/codi1_bag_wish.jpg');
    Cloth_sbw codi2_shoes = Cloth_sbw(
        wish_name: "fkfkfk",
        wish_path: 'assets/mainfeed_person/codi1_shoes_buy.jpg',
        buy_name: "dksehoO",
        buy_path: "assets/mainfeed_person/codi1_shoes_style.jpg",
        style_name: "ziziziI",
        style_path: 'assets/mainfeed_person/codi1_shoes_wish.jpg');

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
            height: 350,
            width: 300,
            child: PageView(
              //physics: BouncingScrollPhysics(),
              controller: controller,
              children: [
                //첫번째 페이지
                Container(child: Image.asset('assets/images/sample_knit.png')),
                //첫번째코디
                Container(
                  child: Stack(
                    children: [
                      Positioned(
                          child: Image.asset(
                        'assets/request_codi/received_codi1_total.png',
                        fit: BoxFit.cover,
                        width: 500,
                      )),
                      //1. 아우터
                      /*Positioned(
                        top: 0,
                        left: 0,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              codi1.bag = 0;
                              codi1.bottom = 0;
                              codi1.shoes = 0;
                              codi1.top = 0;
                              codi1.outer = 1;
                            });
                          },
                          child: Image.asset(
                              'assets/request_codi/received_codi1_outer.png',
                              width: 180,
                              fit: BoxFit.fitWidth),
                        ),
                      ),*/
                      //아우터의 원모양
                      Positioned(
                        top: 85,
                        left: 88,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              codi1.bag = 0;
                              codi1.bottom = 0;
                              codi1.shoes = 0;
                              codi1.top = 0;
                              codi1.outer = 1;
                              codi1.circlebutton_color_outer = Colors.indigo;
                              codi1.circlebutton_color_top = Colors.grey[800];
                              codi1.circlebutton_color_bottom =
                                  Colors.grey[800];
                              codi1.circlebutton_color_bag = Colors.grey[800];
                              codi1.circlebutton_color_shoes = Colors.grey[800];
                              codi1_swb = codi1_outer;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              color: codi1.circlebutton_color_outer,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              " ",
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                        ),
                      ),
                      //아우터 말풍선
                      Positioned(
                        top: 50,
                        left: 65,
                        child: Builder(
                          builder: (BuildContext context) {
                            if (codi1.outer == 1) {
                              return InkWell(
                                  onTap: () {},
                                  child: SpeechBubble(
                                    color: Colors.black,
                                    nipLocation: NipLocation.BOTTOM,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          "kuho",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "389,000원",
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
                              return Container();
                            }
                          },
                        ),
                      ),
                      //2. 상의 및 원피스
                      /*Positioned(
                        top: 0,
                        right: 42,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              codi1.bag = 0;
                              codi1.bottom = 0;
                              codi1.outer = 0;
                              codi1.shoes = 0;
                              codi1.top = 1;
                            });
                          },
                          child: Image.asset(
                              'assets/request_codi/received_codi1_top.png',
                              width: 130,
                              fit: BoxFit.fitWidth),
                        ),
                      ),*/
                      //상의 원모양
                      Positioned(
                        top: 65,
                        right: 103,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              codi1.bag = 0;
                              codi1.bottom = 0;
                              codi1.outer = 0;
                              codi1.shoes = 0;
                              codi1.top = 1;
                              codi1.circlebutton_color_top = Colors.indigo;
                              codi1.circlebutton_color_outer = Colors.grey[800];
                              codi1.circlebutton_color_bottom =
                                  Colors.grey[800];
                              codi1.circlebutton_color_bag = Colors.grey[800];
                              codi1.circlebutton_color_shoes = Colors.grey[800];
                              codi1_swb = codi1_top;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              color: codi1.circlebutton_color_top,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              " ",
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        right: 80,
                        child: Builder(builder: (context) {
                          if (codi1.top == 1) {
                            return InkWell(
                                onTap: () {},
                                child: SpeechBubble(
                                  color: Colors.black,
                                  nipLocation: NipLocation.BOTTOM,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "ZARA",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "59,000원",
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
                            return Container();
                          }
                        }),
                      ),
                      //3. 하의
                      /*Positioned(
                        top: 70,
                        right: 30,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              codi1.bag = 0;
                              codi1.outer = 0;
                              codi1.shoes = 0;
                              codi1.top = 0;
                              codi1.bottom = 1;
                            });
                          },
                          child: Image.asset(
                              'assets/request_codi/received_codi1_bottom.png',
                              width: 150,
                              fit: BoxFit.fitWidth),
                        ),
                      ),*/
                      Positioned(
                        top: 165,
                        right: 102,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              codi1.bag = 0;
                              codi1.outer = 0;
                              codi1.shoes = 0;
                              codi1.top = 0;
                              codi1.bottom = 1;
                              codi1.circlebutton_color_bottom = Colors.indigo;
                              codi1.circlebutton_color_outer = Colors.grey[800];
                              codi1.circlebutton_color_top = Colors.grey[800];
                              codi1.circlebutton_color_bag = Colors.grey[800];
                              codi1.circlebutton_color_shoes = Colors.grey[800];
                              codi1_swb = codi1_bottom;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              color: codi1.circlebutton_color_bottom,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              " ",
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 130,
                        right: 80,
                        child: Builder(builder: (context) {
                          if (codi1.bottom == 1) {
                            return InkWell(
                                onTap: () {},
                                child: SpeechBubble(
                                  color: Colors.black,
                                  nipLocation: NipLocation.BOTTOM,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "Theory",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "68,100원",
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
                            return Container();
                          }
                        }),
                      ),
                      //4. 가방
                      /*Positioned(
                        bottom: 0,
                        left: 40,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              codi1.bottom = 0;
                              codi1.outer = 0;
                              codi1.shoes = 0;
                              codi1.top = 0;
                              codi1.bag = 1;
                            });
                          },
                          child: Image.asset(
                              'assets/request_codi/received_codi1_bag.png',
                              width: 100,
                              fit: BoxFit.fitWidth),
                        ),
                      ),*/
                      Positioned(
                        bottom: 0,
                        left: 88,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              codi1.bottom = 0;
                              codi1.outer = 0;
                              codi1.shoes = 0;
                              codi1.top = 0;
                              codi1.bag = 1;
                              codi1.circlebutton_color_bag = Colors.indigo;
                              codi1.circlebutton_color_outer = Colors.grey[800];
                              codi1.circlebutton_color_top = Colors.grey[800];
                              codi1.circlebutton_color_bottom =
                                  Colors.grey[800];
                              codi1.circlebutton_color_shoes = Colors.grey[800];
                              codi1_swb = codi1_bag;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              color: codi1.circlebutton_color_bag,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              " ",
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        left: 65,
                        child: Builder(builder: (context) {
                          if (codi1.bag == 1) {
                            return InkWell(
                                onTap: () {},
                                child: SpeechBubble(
                                  color: Colors.black,
                                  nipLocation: NipLocation.BOTTOM,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "kuho plus",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "38,000원",
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
                            return Container();
                          }
                        }),
                      ),
                      //5. 신발
                      /*Positioned(
                        bottom: 0,
                        right: 60,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              codi1.bag = 0;
                              codi1.bottom = 0;
                              codi1.outer = 0;
                              codi1.top = 0;
                              codi1.shoes = 1;
                            });
                          },
                          child: Image.asset(
                              'assets/request_codi/received_codi1_shoes.png',
                              width: 100,
                              fit: BoxFit.fitWidth),
                        ),
                      ),*/
                      Positioned(
                        bottom: 0,
                        right: 88,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              codi1.bag = 0;
                              codi1.bottom = 0;
                              codi1.outer = 0;
                              codi1.top = 0;
                              codi1.shoes = 1;
                              codi1.circlebutton_color_shoes = Colors.indigo;
                              codi1.circlebutton_color_outer = Colors.grey[800];
                              codi1.circlebutton_color_top = Colors.grey[800];
                              codi1.circlebutton_color_bottom =
                                  Colors.grey[800];
                              codi1.circlebutton_color_bag = Colors.grey[800];
                              codi1_swb = codi1_shoes;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              color: codi1.circlebutton_color_shoes,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              " ",
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        right: 65,
                        child: Builder(builder: (context) {
                          if (codi1.shoes == 1) {
                            return InkWell(
                                onTap: () {},
                                child: SpeechBubble(
                                  color: Colors.black,
                                  nipLocation: NipLocation.BOTTOM,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "BROOKS",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "108,000원",
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
                            return Container();
                          }
                        }),
                      ),
                    ],
                  ),
                ),
                //두번째코디
                Container(
                  child: Stack(
                    children: [
                      Positioned(
                          child: Image.asset(
                        'assets/request_codi/received_codi2_total.png',
                        fit: BoxFit.cover,
                        width: 500,
                      )),
                      //1. 상의
                      Positioned(
                        top: 65,
                        right: 103,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              codi2.bag = 0;
                              codi2.bottom = 0;
                              codi2.shoes = 0;
                              codi2.top = 0;
                              codi2.outer = 1;
                              codi2.circlebutton_color_outer = Colors.indigo;
                              codi2.circlebutton_color_top = Colors.grey[800];
                              codi2.circlebutton_color_bottom =
                                  Colors.grey[800];
                              codi2.circlebutton_color_bag = Colors.grey[800];
                              codi2.circlebutton_color_shoes = Colors.grey[800];
                              codi2_swb = codi2_outer;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              color: codi2.circlebutton_color_outer,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              " ",
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        right: 80,
                        child: Builder(
                          builder: (BuildContext context) {
                            if (codi2.outer == 1) {
                              return InkWell(
                                  onTap: () {},
                                  child: SpeechBubble(
                                    color: Colors.black,
                                    nipLocation: NipLocation.BOTTOM,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          "Beanpole",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "129,000원",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                              ;
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                      //2. 상의 및 원피스
                      Positioned(
                        top: 85,
                        left: 88,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              codi2.bag = 0;
                              codi2.bottom = 0;
                              codi2.outer = 0;
                              codi2.shoes = 0;
                              codi2.top = 1;
                              codi2.circlebutton_color_top = Colors.indigo;
                              codi2.circlebutton_color_outer = Colors.grey[800];
                              codi2.circlebutton_color_bottom =
                                  Colors.grey[800];
                              codi2.circlebutton_color_bag = Colors.grey[800];
                              codi2.circlebutton_color_shoes = Colors.grey[800];
                              codi2_swb = codi2_top;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              color: codi2.circlebutton_color_top,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              " ",
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 65,
                        child: Builder(builder: (context) {
                          if (codi2.top == 1) {
                            return InkWell(
                                onTap: () {},
                                child: SpeechBubble(
                                  color: Colors.black,
                                  nipLocation: NipLocation.BOTTOM,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "ZARA",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "59,000원",
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
                            return Container();
                          }
                        }),
                      ),
                      //3. 하의
                      Positioned(
                        top: 167,
                        left: 88,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              codi2.bag = 0;
                              codi2.outer = 0;
                              codi2.shoes = 0;
                              codi2.top = 0;
                              codi2.bottom = 1;
                              codi2.circlebutton_color_bottom = Colors.indigo;
                              codi2.circlebutton_color_outer = Colors.grey[800];
                              codi2.circlebutton_color_top = Colors.grey[800];
                              codi2.circlebutton_color_bag = Colors.grey[800];
                              codi2.circlebutton_color_shoes = Colors.grey[800];
                              codi2_swb = codi2_bottom;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              color: codi2.circlebutton_color_bottom,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              " ",
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 130,
                        left: 67,
                        child: Builder(builder: (context) {
                          if (codi2.bottom == 1) {
                            return InkWell(
                                onTap: () {},
                                child: SpeechBubble(
                                  color: Colors.black,
                                  nipLocation: NipLocation.BOTTOM,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "8seconds",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "59,900원",
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
                            return Container();
                          }
                        }),
                      ),
                      //4. 가방
                      Positioned(
                        bottom: 90,
                        right: 110,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              codi2.bottom = 0;
                              codi2.outer = 0;
                              codi2.shoes = 0;
                              codi2.top = 0;
                              codi2.bag = 1;
                              codi2.circlebutton_color_bag = Colors.indigo;
                              codi2.circlebutton_color_outer = Colors.grey[800];
                              codi2.circlebutton_color_top = Colors.grey[800];
                              codi2.circlebutton_color_bottom =
                                  Colors.grey[800];
                              codi2.circlebutton_color_shoes = Colors.grey[800];
                              codi2_swb = codi2_bag;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              color: codi2.circlebutton_color_bag,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              " ",
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 143,
                        right: 88,
                        child: Builder(builder: (context) {
                          if (codi2.bag == 1) {
                            return InkWell(
                                onTap: () {},
                                child: SpeechBubble(
                                  color: Colors.black,
                                  nipLocation: NipLocation.BOTTOM,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "RePLAiN",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "80,000원",
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
                            return Container();
                          }
                        }),
                      ),
                      //5. 신발
                      Positioned(
                        bottom: 90,
                        right: 40,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              codi2.bag = 0;
                              codi2.bottom = 0;
                              codi2.outer = 0;
                              codi2.top = 0;
                              codi2.shoes = 1;
                              codi2.circlebutton_color_shoes = Colors.indigo;
                              codi2.circlebutton_color_outer = Colors.grey[800];
                              codi2.circlebutton_color_top = Colors.grey[800];
                              codi2.circlebutton_color_bottom =
                                  Colors.grey[800];
                              codi2.circlebutton_color_bag = Colors.grey[800];
                              codi2_swb = codi2_shoes;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              color: codi2.circlebutton_color_shoes,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              " ",
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 143,
                        right: 18,
                        child: Builder(builder: (context) {
                          if (codi2.shoes == 1) {
                            return InkWell(
                                onTap: () {},
                                child: SpeechBubble(
                                  color: Colors.black,
                                  nipLocation: NipLocation.BOTTOM,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "REPLAiN",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "138,000원",
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
                            return Container();
                          }
                        }),
                      ),
                    ],
                  ),
                ),
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
                //첫번째코디 밑 사진
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: swb_info(codi1_swb),
                ),
                //두번째코디 밑 사진
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: swb_info(codi2_swb),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                StylingCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
