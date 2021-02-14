import 'package:flutter/material.dart';

List<String> style_list = [
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

List<int> style_click = [];

class Stylebutton extends StatefulWidget {
  String style;
  double width;
  Color background_color = Colors.white;
  Color text_color = Colors.black;
  int style_index; //0~18
  int len_str;
  Stylebutton({Key key, int style_index}) : super(key: key) {
    this.style_index = style_index;
    this.style = style_list[style_index];
    len_str = this.style.length;
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
  _StylebuttonState createState() {
    return _StylebuttonState();
  }
}

class _StylebuttonState extends State<Stylebutton> {
  void clickitem() {
    setState(() {
      style_click[widget.style_index] =
          (style_click[widget.style_index] + 1) % 2;
      if (style_click[widget.style_index] == 1) {
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
          child: Text(widget.style,
              style: TextStyle(fontSize: 15, color: widget.text_color)),
          onTap: () {
            clickitem();
          }),
    );
  }
}
