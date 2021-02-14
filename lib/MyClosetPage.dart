import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylehub_flutter/Constants.dart';
import 'package:tabbar/tabbar.dart';

import 'RegisterPage.dart';

class MyClosetPage extends StatefulWidget {
  @override
  _MyClosetPageState createState() => _MyClosetPageState();
}

class _MyClosetPageState extends State<MyClosetPage> {
  final controller = PageController();

  Container buildRow(double _height, int imgOffset) {
    return Container(
      height: _height,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 250,
            width: 150,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(
              'images/hanger_cloth${index + imgOffset}.png',
              fit: BoxFit.fitHeight,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(12),
          child: Text('MY 옷장', style: kPageTitleTextStyle),
        ),
        PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: TabbarHeader(
            indicatorColor: Colors.black,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            controller: controller,
            tabs: [
              Tab(
                text: '전체',
              ),
              Tab(
                text: '상의',
              ),
              Tab(
                text: '하의',
              ),
              Tab(
                text: '원피스',
              ),
              Tab(
                text: 'ACC',
              )
            ],
          ),
        ),
        Expanded(
          child: TabbarContent(
            controller: controller,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        Image.asset('assets/hanger.png'),
                        Container(
                          padding: EdgeInsets.only(top: 15),
                          child: buildRow(200, 1),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          disabledColor: Colors.black,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              '행거 추가하기',
                              style: kButtonTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        //fit: StackFit.loose,
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset('assets/wall_texture.png'),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 35, right: 25),
                            alignment: Alignment.bottomRight,
                            child: Image.asset('assets/storage.png'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        Image.asset('assets/hanger.png'),
                        Container(
                          padding: EdgeInsets.only(top: 15),
                          child: buildRow(200, 1),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          disabledColor: Colors.black,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              '행거 추가하기',
                              style: kButtonTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        //fit: StackFit.loose,
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset('assets/wall_texture.png'),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 35, right: 25),
                            alignment: Alignment.bottomRight,
                            child: Image.asset('assets/storage.png'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        Image.asset('assets/hanger.png'),
                        Container(
                          padding: EdgeInsets.only(top: 15),
                          child: buildRow(200, 1),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          disabledColor: Colors.black,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              '행거 추가하기',
                              style: kButtonTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        //fit: StackFit.loose,
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset('assets/wall_texture.png'),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 35, right: 25),
                            alignment: Alignment.bottomRight,
                            child: Image.asset('assets/storage.png'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        Image.asset('assets/hanger.png'),
                        Container(
                          padding: EdgeInsets.only(top: 15),
                          child: buildRow(200, 1),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          disabledColor: Colors.black,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              '행거 추가하기',
                              style: kButtonTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        //fit: StackFit.loose,
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset('assets/wall_texture.png'),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 35, right: 25),
                            alignment: Alignment.bottomRight,
                            child: Image.asset('assets/storage.png'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        Image.asset('assets/hanger.png'),
                        Container(
                          padding: EdgeInsets.only(top: 15),
                          child: buildRow(200, 1),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          disabledColor: Colors.black,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              '행거 추가하기',
                              style: kButtonTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        //fit: StackFit.loose,
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset('assets/wall_texture.png'),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 35, right: 25),
                            alignment: Alignment.bottomRight,
                            child: Image.asset('assets/storage.png'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
