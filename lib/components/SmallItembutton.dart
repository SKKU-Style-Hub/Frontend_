import 'package:flutter/material.dart';

List<String> item_smalllist = [
  "핸드메이드",
  "상의",
  "아우터",
  "원피스",
  "팬츠",
  "스커트",
  "트레이닝",
  "가방",
  "신발",
  "모자",
  "쥬얼리",
  "홈웨어",
  "언더웨어",
  "비치웨어",
  "빅사이즈",
  "후드"
];

List<int> item_smallclick = [];

class SmallItembutton extends StatefulWidget {
  String item;
  double width;
  Color background_color = Colors.white;
  Color text_color = Colors.black;
  int item_index; //0~18
  int len_str;
  SmallItembutton({Key key, int item_index}) : super(key: key) {
    this.item_index = item_index;
    this.item = item_smalllist[item_index];
    len_str = this.item.length;
    if (len_str <= 2) {
      this.width = 45;
    } else if (len_str == 3) {
      this.width = 55;
    } else if (len_str == 4) {
      this.width = 70;
    } else {
      this.width = 80;
    }
  }
  _SmallItembuttonState createState() {
    return _SmallItembuttonState();
  }
}

class _SmallItembuttonState extends State<SmallItembutton> {
  void clickitem() {
    setState(() {
      item_smallclick[widget.item_index] =
          (item_smallclick[widget.item_index] + 1) % 2;
      if (item_smallclick[widget.item_index] == 1) {
        widget.background_color = Colors.black;
        widget.text_color = Colors.white;
      } else {
        widget.background_color = Colors.white;
        widget.text_color = Colors.black;
      }
    });
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, top: 10.0),
      decoration: BoxDecoration(
        color: widget.background_color,
        borderRadius: BorderRadius.all(Radius.circular(100)),
        border: Border.all(width: 1, color: Colors.black),
      ),
      width: widget.width,
      height: 25,
      alignment: Alignment.center,
      child: InkWell(
          child: Text(widget.item,
              style: TextStyle(fontSize: 12.5, color: widget.text_color)),
          onTap: () {
            clickitem();
          }),
    );
  }
}
