import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:stylehub_flutter/FittingRoom/FittingRoom.dart';
import 'package:stylehub_flutter/MyCloset/MyRoom/Userfeedinput1.dart';
import 'package:stylehub_flutter/SettingsScreen.dart';
import 'MainFeed/MainFeed.dart';
import 'MyCloset/MyClosetPage.dart';
import 'package:stylehub_flutter/common/custom_icons_icons.dart';
import 'RequestCodi/RequestMain.dart';
import 'package:flutter/foundation.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'LoginScreen.dart';

class Navigation extends StatefulWidget {
  int _selectedItemPosition = 0;
  Navigation({Key key, int selectedPosition}) : super(key: key) {
    _selectedItemPosition = selectedPosition;
  }
  //static bool newPage = false;
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var token;
  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      AuthCodeClient.instance.retrieveAuthCode();
    }
    //_checkAccessToken();
  }

  _checkAccessToken() async {
    token = await AccessTokenStore.instance.fromStore();
    if (token.refreshToken == null) {
      print("token null");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else
      print("token not null");
  }

  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(0),
    topRight: Radius.circular(0),
  );

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
        actions: [
          widget._selectedItemPosition == 3
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: saveCodi,
                      child: Text("저장     ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    ),
                  ],
                )
              : IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );
                  },
                ),
        ],
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
                body: FittingRoomMain(
                    //selected_index: widget.fittingroom_select
                    ),
                //debugShowCheckedModeBanner: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
