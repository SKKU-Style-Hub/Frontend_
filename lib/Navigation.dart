import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:stylehub_flutter/FittingRoom/FittingRoom.dart';
import 'MainFeed/MainFeed.dart';
import 'MyCloset/MyClosetPage.dart';
import 'package:stylehub_flutter/common/custom_icons_icons.dart';
import 'MainFeed/MainFeed.dart';
import 'MyCloset/RegisterPage.dart';
import 'RequestCodi/RequestChoose.dart';
import 'RequestCodi/RequestMain.dart';

class Navigation extends StatefulWidget {
  int _selectedItemPosition = 0;
  int fittingroom_select = 0;
  Navigation({Key key, int selectedPosition, int fittingroom_select})
      : super(key: key) {
    _selectedItemPosition = selectedPosition;
    this.fittingroom_select = fittingroom_select;
  }
  //static bool newPage = false;
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(0),
    topRight: Radius.circular(0),
  );

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
        currentIndex: widget._selectedItemPosition,
        onTap: (index) => setState(() => widget._selectedItemPosition = index),
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
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: widget._selectedItemPosition != 0,
            child: TickerMode(
              enabled: widget._selectedItemPosition == 0,
              child: Scaffold(
                body: MainFeed(),
                //debugShowCheckedModeBanner: false,
              ),
            ),
          ),
          Offstage(
            offstage: (widget._selectedItemPosition != 1),
            child: TickerMode(
              enabled: (widget._selectedItemPosition == 1),
              child: Scaffold(
                body: MyClosetPage(),
                // debugShowCheckedModeBanner: false,
                // theme: ThemeData(
                //   buttonColor: Colors.black,
                // ),
              ),
            ),
          ),
          Offstage(
            offstage: widget._selectedItemPosition != 2,
            child: TickerMode(
              enabled: widget._selectedItemPosition == 2,
              child: Scaffold(
                body: RequestMain(),
                //debugShowCheckedModeBanner: false,
              ),
            ),
          ),
          Offstage(
            offstage: widget._selectedItemPosition != 3,
            child: TickerMode(
              enabled: widget._selectedItemPosition == 3,
              child: Scaffold(
                body:
                    Fittingroom_main(selected_index: widget.fittingroom_select),
                //debugShowCheckedModeBanner: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
