import 'package:flutter/material.dart';

List<String> item_list = [
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

List<int> item_click = [];

class Itembutton extends StatefulWidget {
  String item;
  double width;
  Color background_color = Colors.white;
  Color text_color = Colors.black;
  int item_index; //0~18
  int len_str;
  Itembutton({Key key, int item_index}) : super(key: key) {
    this.item_index = item_index;
    this.item = item_list[item_index];
    len_str = this.item.length;
    if (len_str <= 2) {
      this.width = 65;
    } else if (len_str == 3) {
      this.width = 80;
    } else if (len_str == 4) {
      this.width = 90;
    } else {
      this.width = 110;
    }
  }
  _ItembuttonState createState() {
    return _ItembuttonState();
  }
}

class _ItembuttonState extends State<Itembutton> {
  void clickitem() {
    setState(() {
      item_click[widget.item_index] = (item_click[widget.item_index] + 1) % 2;
      if (item_click[widget.item_index] == 1) {
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
      height: 30,
      alignment: Alignment.center,
      child: InkWell(
          child: Text(widget.item,
              style: TextStyle(fontSize: 15, color: widget.text_color)),
          onTap: () {
            clickitem();
          }),
    );
  }
}
