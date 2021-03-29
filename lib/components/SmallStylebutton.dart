import 'package:flutter/material.dart';

List<String> style_smalllist = [
  "로맨틱",
  "페미닌",
  "시크",
  "빈티지",
  "러블리",
  "글램",
  "오피스",
  "모던",
  "젠더리스",
  "걸리쉬",
  "유니크",
  "큐티",
  "미니멀",
  "아메카지",
  "스트릿",
  "키치",
  "베이직",
  "데일리",
  "댄디"
];

List<int> style_smallclick = [];

class SmallStylebutton extends StatefulWidget {
  String style;
  double width;
  Color background_color = Colors.white;
  Color text_color = Colors.black;
  int style_index; //0~18
  int len_str;
  SmallStylebutton({Key key, int style_index}) : super(key: key) {
    this.style_index = style_index;
    this.style = style_smalllist[style_index];
    len_str = this.style.length;
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
  _SmallStylebuttonState createState() {
    return _SmallStylebuttonState();
  }
}

class _SmallStylebuttonState extends State<SmallStylebutton> {
  void clickitem() {
    setState(() {
      style_smallclick[widget.style_index] =
          (style_smallclick[widget.style_index] + 1) % 2;
      if (style_smallclick[widget.style_index] == 1) {
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
          child: Text(widget.style,
              style: TextStyle(fontSize: 12.5, color: widget.text_color)),
          onTap: () {
            clickitem();
          }),
    );
  }
}
