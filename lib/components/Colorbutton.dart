import 'package:flutter/material.dart';
import 'package:circle_button/circle_button.dart';

List<Color> color_code_list = [
  Colors.white,
  Colors.grey[400],
  Colors.grey[600],
  //Colors.grey[800],
  Colors.black,
  Colors.pink,
  Colors.red,
  //Colors.pink[300],
  //Colors.pinkAccent[700],
  //Colors.purpleAccent[100],
  //Colors.pink[100],
  //Colors.red[200],
  //Colors.red[400],
  Colors.orange,
  //Colors.orange[700],
  //Colors.pinkAccent,
  //Colors.deepOrangeAccent[400],
  Colors.yellow,
  //Colors.amber[200],
  //Colors.amber[300],
  //Colors.amber[600],
  //Colors.limeAccent,
  //Colors.lightGreen,
  Colors.blue,
  Colors.green,
  //Colors.green[700],
  //Colors.brown[300],
  //Colors.green[800],
  //Colors.lightBlue[400],
  //Colors.lightBlue[700],
  //Colors.indigo,
  //Colors.indigo[800],
  //Colors.deepPurple[100],
  //Colors.deepPurple,
  Colors.purple,
  //Colors.purple[800],
  Colors.brown,
  //Colors.teal[300],
  //Colors.teal[700],
  //Colors.teal[800],
  Color(0xFFF9E4B7),
  Color(0xFFFFD700) //금색
];

List<Color> border_color_list = [
  Colors.grey[400],
  Colors.grey,
  Colors.grey[700],
  //Colors.grey[900],
  Colors.black,
  Colors.pink[900],
  Colors.red[700],
  //Colors.pink[400],
  //Colors.pink,
  //Colors.purpleAccent,
  //Colors.pink[200],
  //Colors.red[300],
  //Colors.red,
  Colors.orange[600],
  //Colors.orange[800],
  //Colors.pinkAccent[400],
  //Colors.deepOrangeAccent[700],
  Colors.yellow[700],
  //Colors.amber[400],
  //Colors.amber,
  //Colors.amber[700],
  //Colors.limeAccent[400],
  //Colors.lightGreen[600],
  Colors.blue[700],
  Colors.green[600],
  //Colors.green[800],
  //Colors.brown[400],
  //Colors.green[900],
  //Colors.lightBlue,
  //Colors.lightBlue[800],
  //Colors.indigo[700],
  //Colors.indigo[900],
  //Colors.deepPurple[200],
  //Colors.deepPurple[700],
  Colors.purple[700],
  //Colors.purple[900],
  Colors.brown[600],
  //Colors.teal[400],
  //Colors.teal[800],
  //Colors.teal[900]
  Colors.brown,
  Colors.yellow
];

List<int> color_click = [];

class Colorbutton extends StatefulWidget {
  //int click = 0;
  Color color_code;
  Color border_color;
  Color real_border_color;
  double border_width;
  double real_border_width;
  int color_index; //0~39
  Colorbutton({Key key, int color_index}) : super(key: key) {
    this.color_index = color_index;
    this.color_code = color_code_list[color_index];
    this.border_color = border_color_list[color_index];
    this.real_border_color = this.border_color;
    this.border_width = 2.0;
    this.real_border_width = this.border_width;
  }
  _ColorbuttonState createState() {
    return _ColorbuttonState();
  }
}

class _ColorbuttonState extends State<Colorbutton> {
  void changeborder() {
    setState(() {
      color_click[widget.color_index] =
          (color_click[widget.color_index] + 1) % 2;
      if (color_click[widget.color_index] == 1) //clicked
      {
        widget.border_color = Colors.black;
        widget.border_width = 3.5;
      } else {
        //not clicked
        widget.border_color = widget.real_border_color;
        widget.border_width = widget.real_border_width;
      }
    });
  }

  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      margin: EdgeInsets.only(left: 10.0, top: 10.0),
      child: CircleButton(
        onTap: () {
          changeborder();
        },
        tooltip: 'Circle Button',
        width: 30.0,
        height: 30.0,
        borderColor: widget.border_color,
        borderWidth: widget.border_width,
        borderStyle: BorderStyle.solid,
        backgroundColor: widget.color_code,
        child: Icon(
          Icons.add,
          color: widget.color_code,
        ),
      ),
    );
  }
}
