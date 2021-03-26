import 'package:flutter/material.dart';
import 'package:stylehub_flutter/Constants.dart';
import 'package:stylehub_flutter/MyCloset/MyRoom/Userfeedinput1.dart';
import 'package:stylehub_flutter/data/ProposedCodi.dart';
import 'CreatePost.dart';
import 'RawData.dart';
import 'StylingCard.dart';

Color notClickedColor = Colors.grey[800]; //선택하지 않은 버튼의 색깔
Color clickedColor = Colors.indigo; //선택된 색깔

class MainFeed extends StatefulWidget {
  @override
  _MainFeedState createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeed> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreatePost()));
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                StylingCard(tmpAllCodi: allProposedCodi1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
