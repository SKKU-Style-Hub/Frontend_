import 'package:flutter/material.dart';
import 'package:stylehub_flutter/Constants.dart';
import 'package:stylehub_flutter/MyCloset/MyRoom/Userfeedinput1.dart';
import 'CreatePost.dart';
import 'RawData.dart';
import 'StylingCard.dart';

Color notClickedColor = Colors.grey[800]; //선택하지 않은 버튼의 색깔
Color clickedColor = Colors.indigo; //선택된 색깔

class CodiClick {
  //모든 순서는 1:top, 2:bottom, 3: onepiece, 4:outer, 5:shoes, 6:bag
  //클릭했는지를 알려줌. 1이면 클릭 0이면 클릭x
  List<dynamic> clickint = [0, 0, 0, 0, 0, 0, 0];
  CodiClick(
      {int outer, int top, int bag, int shoes, int bottom, int onepiece}) {
    clickint[1] = top;
    clickint[2] = bottom;
    clickint[3] = onepiece;
    clickint[4] = outer;
    clickint[5] = shoes;
    clickint[6] = bag;
  }
  void FocusOnThis(int index)
  //index는 1이면 top.. 임을 나타냄. 입력 받은 애에 focus를 주고 나머지는 포커스 해제해야함.
  {
    clickint = [0, 0, 0, 0, 0, 0, 0];
    clickint[index] = 1; //클릭한 애만 클릭했다고 알려주기
  }
}

//stylingfeed에서 각 옷마다 style.buy.wish정보를 담고 있는 것
class ClothSbw {
  String style_path;
  String style_name;
  String buy_path;
  String buy_name;
  String wish_path;
  String wish_name;
  ClothSbw(
      {this.buy_name,
      this.buy_path,
      this.style_name,
      this.style_path,
      this.wish_name,
      this.wish_path}) {}
}

class ProposedCodiElement {
  ClothSbw clothSbw;
  double xCoordinate, yCoordinate;
  int price;
  String brandName, link;
  ProposedCodiElement(
      {this.clothSbw,
      this.xCoordinate,
      this.yCoordinate,
      this.price,
      this.brandName,
      this.link}) {}
}

class ProposedCodi {
  ClothSbw selectedClothSbw;
  CodiClick codiClick;
  List<dynamic> clothList = [null, null, null, null, null, null, null];
  String codiImage; //이미지path
  ProposedCodi(
      {ProposedCodiElement top,
      ProposedCodiElement bottom,
      ProposedCodiElement onepiece,
      ProposedCodiElement outer,
      ProposedCodiElement shoes,
      ProposedCodiElement bag,
      this.codiImage,
      this.selectedClothSbw}) {
    clothList[1] = top;
    clothList[2] = bottom;
    clothList[3] = onepiece;
    clothList[4] = outer;
    clothList[5] = shoes;
    clothList[6] = bag;
    codiClick = new CodiClick();
  }
}

class AllProposedCodi {
  List<dynamic> proposedCodiList;
  String userId, explanation;
  AllProposedCodi({this.proposedCodiList, this.userId, this.explanation}) {}
}

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
