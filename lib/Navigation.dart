import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:stylehub_flutter/AfterRequest.dart';
import 'package:stylehub_flutter/MyClosetPage.dart';
import 'package:stylehub_flutter/FittingRoom.dart';
import 'package:stylehub_flutter/RegisterPage.dart';
import 'package:stylehub_flutter/common/custom_icons_icons.dart';
import 'RequestPage.dart';
import 'MainFeed.dart';
import 'RequestChoose.dart';

int _request = 0;
int _index = 0;
int _select_cloth = 0;
int _imgOffset = 0;

class Navigation extends StatefulWidget {
  Navigation({Key key, int request, int index, int select_cloth, int imgOffset})
      : super(key: key) {
    _request = request;
    _index = index;
    _select_cloth = select_cloth;
    _imgOffset = imgOffset;
  }
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(0),
    topRight: Radius.circular(0),
  );
  int _selectedItemPosition = RegisterPage.registered == 0 ? 0 : 1;

  static List<Widget> _widgetOptions = <Widget>[
    MainFeed(),
    MyClosetPage(),
    RequestChoose(),
    Fittingroom_main()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/applogo.png',
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.pinned,
        snakeShape: SnakeShape.rectangle,
        shape: BeveledRectangleBorder(borderRadius: _borderRadius),
        padding: EdgeInsets.zero,
        snakeViewColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: [
          const BottomNavigationBarItem(
              icon: Icon(CustomIcons.home), label: 'MAIN 피드'),
          const BottomNavigationBarItem(
              icon: Icon(CustomIcons.wardrobe), label: 'MY 옷장'),
          const BottomNavigationBarItem(
              icon: Icon(CustomIcons.tshirt), label: '코디 요청'),
          const BottomNavigationBarItem(
              icon: Icon(CustomIcons.clothes_hanger), label: '피팅룸'),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedItemPosition),
    );
  }
}