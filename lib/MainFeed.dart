import 'package:flutter/material.dart';

//홈화면 친구피드
class Eachfriend {
  String name;
  String photopath;
  int heart_num;
  List<dynamic> comment_list;
  List<dynamic> tag_list;
  Eachfriend(
      {String name,
      String photopath,
      int heart_num,
      List comment_list,
      List tag_list}) {
    this.name = name;
    this.photopath = photopath;
    this.heart_num = heart_num;
    this.comment_list = comment_list;
    this.tag_list = tag_list;
  }
}

List<dynamic> Home_friends = [];

//홈화면 추천코디
class Codi {
  String imagepath;
  String explanation;
  Codi({String imagepath, String explanation}) {
    this.imagepath = imagepath;
    this.explanation = explanation;
  }
}

List<dynamic> Home_codis = [];

//홈화면 광고
class AD {
  String imagepath;
  AD({String imagepath}) {
    this.imagepath = imagepath;
  }
}

List<dynamic> Home_ads = [];

//홈화면 best상품
class Bestitem {
  String imagepath;
  String brandimagepath;
  Color brandcolor;
  String name;
  String color_name;
  int price;
  Bestitem({
    String imagepath,
    String brandimagepath,
    Color brandcolor,
    String name,
    String color_name,
    int price,
  }) {
    this.imagepath = imagepath;
    this.brandimagepath = brandimagepath;
    this.brandcolor = brandcolor;
    this.name = name;
    this.color_name = color_name;
    this.price = price;
  }
}

List<dynamic> Home_bestitems = [];

class MainFeed extends StatefulWidget {
  MainFeed({Key key, this.title}) : super(key: key) {}
  final String title;

  _MainFeedState createState() {
    return _MainFeedState();
  }
}

class _MainFeedState extends State<MainFeed> {
  @override
  Widget build(BuildContext context) {
    //초기화
    Home_ads = [];
    Home_bestitems = [];
    Home_codis = [];
    Home_friends = [];
    //홈화면 친구 받아오기
    Eachfriend friend1 = new Eachfriend(
        comment_list: ["멋져요!!", "사진을 어디서 찍었나요?!"],
        tag_list: ["데이트룩", "OOTD", "봄옷"],
        heart_num: 36,
        name: "juhee09",
        photopath: "assets/images/friend_photo1.png");
    Home_friends.add(friend1);
    Eachfriend friend2 = new Eachfriend(
        comment_list: [
          "옷장 잘 보고 있어요~",
          "셔츠가 너무 예쁘네요",
          "머리가 너무 예뻐요",
          "제 워너비 스타일입니다!"
        ],
        tag_list: [
          "데일리룩",
          "서점 데이트",
          "봄옷 개시"
        ],
        heart_num: 40,
        name: "dkanrjsk_",
        photopath: "assets/images/friend_photo2.png");
    Home_friends.add(friend2);
    Eachfriend friend3 = new Eachfriend(
        comment_list: [
          "니트 어때요??",
        ],
        tag_list: [
          "치마",
        ],
        heart_num: 15,
        name: "lalalala",
        photopath: "assets/images/friend_photo3.png");
    Home_friends.add(friend3);
    //홈화면 추천코디 받아오기
    Codi codi1 = new Codi(
      imagepath: "assets/images/home_codi1.png",
      explanation:
          "쌀쌀하고 하늘이 맑은 오늘, 이런 코디는 어떤가요?\n곧 다가올 봄을 기다리는 설레는 마음을 담은 원피스와 보온성까지 갖춘 롱 코트와 옷장 속 부츠를 매치한 완벽한 나들이 코디랍니다 :) ",
    );
    Home_codis.add(codi1);
    Codi codi2 = new Codi(
      imagepath: "assets/images/home_codi2.png",
      explanation: "맨투맨에 치마는 어떨까요?\n개강룩으로 딱이랍니다!",
    );
    Home_codis.add(codi2);
    //홈화면 광고 받아오기
    AD ad1 = new AD(imagepath: "assets/images/home_ad1.png");
    Home_ads.add(ad1);
    AD ad2 = new AD(imagepath: "assets/images/home_ad2.png");
    Home_ads.add(ad2);
    AD ad3 = new AD(imagepath: "assets/images/home_ad3.png");
    Home_ads.add(ad3);

    //홈화면 베스트상품 받아오기
    Bestitem bi1 = new Bestitem(
        imagepath: "assets/images/home_best1.png",
        brandimagepath: "assets/images/home_best1_brand.png",
        brandcolor: Colors.yellow[200],
        name: "엔젤 로고 에코백",
        color_name: "ivory",
        price: 19000);
    Home_bestitems.add(bi1);

    //listgeneratefor문을 위한 변수들
    int friend_num = Home_friends.length;
    int weather_num = 1;
    int codi_num = Home_codis.length;
    int ad_num = Home_ads.length;
    int item_num = Home_bestitems.length;
    int total_num = friend_num + weather_num + codi_num + ad_num + item_num;
    //-----------------------
    return Scaffold(
      //---------------start--------------
      body: ListView(
        scrollDirection: Axis.vertical,
        //다른 유저 화면
        children: List.generate(total_num, (idx) {
          if (idx < friend_num) {
            return FriendFeed(friend_index: idx);
          } else if (idx < friend_num + weather_num) {
            return WeatherFeed();
          } else if (idx < friend_num + weather_num + codi_num) {
            return CodiFeed(codi_index: idx - (friend_num + weather_num));
          } else if (idx < friend_num + weather_num + codi_num + ad_num) {
            return AdFeed(
                ad_index: idx - (friend_num + weather_num + codi_num));
          } else if (idx < total_num) {
            return BestitemFeed(
                bi_index: idx - (friend_num + weather_num + codi_num + ad_num));
          }
        }),
      ),
    );
  }
}

class FriendFeed extends StatefulWidget {
  int friend_index;
  FriendFeed({Key key, int friend_index}) : super(key: key) {
    this.friend_index = friend_index;
  }

  _FriendFeedState createState() {
    return _FriendFeedState();
  }
}

class _FriendFeedState extends State<FriendFeed> {
  Widget build(BuildContext context) {
    String tagss = "";
    for (int i = 0;
        i < Home_friends[widget.friend_index].tag_list.length;
        i++) {
      tagss = tagss + "#" + Home_friends[widget.friend_index].tag_list[i] + " ";
    }
    return Container(
      margin: EdgeInsets.only(left: 5.0, top: 6.0, right: 5.0, bottom: 6.0),
      height: 540,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(width: 1, color: Colors.black12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 3,
            )
          ]),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 25, left: 300),
            child: Text(Home_friends[widget.friend_index].name.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Center(
            child: SizedBox(
              height: 350,
              child: Image.asset(
                Home_friends[widget.friend_index].photopath,
                //scale: 0.1,
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: 2.0, top: 1.0, right: 2.0, bottom: 1.0),
                      child: Icon(Icons.favorite),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 1.0, top: 1.0, right: 1.0, bottom: 1.0),
                      child: Text(
                          Home_friends[widget.friend_index]
                              .heart_num
                              .toString(),
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        //print("here");
                      },
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 3.0, top: 1.0, right: 2.0, bottom: 1.0),
                            child: Icon(Icons.comment_rounded),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 1.0, top: 1.0, right: 1.0, bottom: 1.0),
                            child: Text(
                                Home_friends[widget.friend_index]
                                    .comment_list
                                    .length
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                          ),
                        ],
                      ),
                    ),
                    /*Container(
                      margin: EdgeInsets.only(
                          left: 3.0, top: 1.0, right: 2.0, bottom: 1.0),
                      child: Icon(Icons.comment_rounded),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 1.0, top: 1.0, right: 1.0, bottom: 1.0),
                      child: Text(
                          Home_friends[widget.friend_index]
                              .comment_list
                              .length
                              .toString(),
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ),*/
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 1.0, top: 2.0, right: 1.0, bottom: 1.0),
                  child: Text(tagss,
                      style: TextStyle(
                        fontSize: 15,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CodiFeed extends StatefulWidget {
  int codi_index;
  CodiFeed({Key key, int codi_index}) : super(key: key) {
    this.codi_index = codi_index;
  }

  _CodiFeedState createState() {
    return _CodiFeedState();
  }
}

class _CodiFeedState extends State<CodiFeed> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5.0, top: 6.0, right: 5.0, bottom: 6.0),
      height: 580,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(width: 1, color: Colors.black12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 3,
            )
          ]),
      child: Stack(
        children: [
          Positioned(
            //top: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Home_codis[widget.codi_index].imagepath, //0은 path자리를 의미
                  //scale: 0.1,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            left: 25,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.baseline,
              //textBaseline: TextBaseline.alphabetic,
              children: [
                Container(
                  width: 340,
                  margin: EdgeInsets.only(
                      left: 1.0, top: 1.0, right: 1.0, bottom: 1.0),
                  child:
                      Text(Home_codis[widget.codi_index].explanation.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherFeed extends StatefulWidget {
  WeatherFeed({Key key}) : super(key: key) {}

  _WeatherFeedState createState() {
    return _WeatherFeedState();
  }
}

class _WeatherFeedState extends State<WeatherFeed> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5.0, top: 6.0, right: 5.0, bottom: 6.0),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        border: Border.all(width: 1, color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 3,
          )
        ],
      ),
      child: Stack(
        //mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.baseline,
        //textBaseline: TextBaseline.alphabetic,
        children: [
          Positioned(
            left: 30,
            //left: 120,
            top: 10,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 1.0, top: 1.0, right: 4.0, bottom: 1.0),
                  child: Text("TODAY",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 2.0, top: 1.0, right: 2.0, bottom: 1.0),
                  child: Text(" COLD ",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        backgroundColor: Colors.blue[800],
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 2.0, top: 1.0, right: 2.0, bottom: 1.0),
                  child: Text(" WINDY ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          backgroundColor: Colors.teal[100])),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 2.0, top: 1.0, right: 2.0, bottom: 1.0),
                  child: Text(" DRY ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          backgroundColor: Colors.amber[400])),
                ),
              ],
            ),
          ),
          Positioned(
            left: 30,
            top: 40,
            child: Text("오늘은\n꽃샘추위입니다.",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          Positioned(
            right: 18,
            top: 40,
            //bottom: 0,
            child: Row(
              children: [
                Text("7",
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                Text("°C",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AdFeed extends StatefulWidget {
  int ad_index;
  AdFeed({Key key, int ad_index}) : super(key: key) {
    this.ad_index = ad_index;
  }

  _AdFeedState createState() {
    return _AdFeedState();
  }
}

class _AdFeedState extends State<AdFeed> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5.0, top: 6.0, right: 5.0, bottom: 6.0),
      //height: 600,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(width: 1, color: Colors.black12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 3,
            )
          ]),
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              Home_ads[widget.ad_index].imagepath,
            ),
          )
        ],
      ),
    );
    /*return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.album),
            title: Text('The Enchanted Nightingale'),
            subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('BUY TICKETS'),
                onPressed: () {/* ... */},
              ),
              FlatButton(
                child: const Text('LISTEN'),
                onPressed: () {/* ... */},
              ),
            ],
          ),
        ],
      ),
    );*/
  }
}

class BestitemFeed extends StatefulWidget {
  int bi_index;
  BestitemFeed({Key key, int bi_index}) : super(key: key) {
    this.bi_index = bi_index;
  }

  _BestitemFeedState createState() {
    return _BestitemFeedState();
  }
}

class _BestitemFeedState extends State<BestitemFeed> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5.0, top: 6.0, right: 5.0, bottom: 6.0),
      height: 580,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Home_bestitems[widget.bi_index].brandcolor,
              //borderRadius: BorderRadius.all(Radius.circular(20.0)),
              //border: Border.all(width: 1, color: Colors.black12),
            ),
            margin:
                EdgeInsets.only(left: 1.0, top: 1.0, right: 4.0, bottom: 1.0),
            child: Padding(
              child: Text("주간 Best 인기",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
              padding: EdgeInsets.only(top: 4, bottom: 4, left: 5, right: 5),
            ),
          ),
          Container(
            height: 530,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                border: Border.all(width: 1, color: Colors.black12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 3,
                  )
                ]),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 350,
                        child: Image.asset(
                            Home_bestitems[widget.bi_index].imagepath),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 315,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        child: Image.asset(
                            Home_bestitems[widget.bi_index].brandimagepath),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    right: 0,
                    left: 0,
                    bottom: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Home_bestitems[widget.bi_index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            )),
                      ],
                    )),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 95,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Home_bestitems[widget.bi_index].color_name,
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          Home_bestitems[widget.bi_index].price.toString() +
                              "원",
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
