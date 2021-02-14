import 'package:flutter/material.dart';

class ClosetPage extends StatefulWidget {
  @override
  _ClosetPageState createState() => _ClosetPageState();
}

class _ClosetPageState extends State<ClosetPage> {
  Container buildTitle(String name) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(18)),
          border: Border.all(width: 1, color: Colors.black12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 3,
            )
          ]),
    );
  }

  Container buildRow(double _height, int imgOffset) {
    return Container(
      height: _height,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 100,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(
              'images/cloth${index + imgOffset}.png',
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              buildTitle('상의'),
              buildRow(120, 1),
              Divider(
                thickness: 3,
                color: Colors.black26,
              ),
              buildTitle('하의'),
              buildRow(120, 5),
              Divider(
                thickness: 3,
                color: Colors.black26,
              ),
              buildTitle('아우터'),
              buildRow(160, 9),
            ],
          ),
        ),
        // Expanded(
        //   flex: 1,
        //   child: Image.asset(
        //     'assets/wall_texture.png',
        //     fit: BoxFit.fitWidth,
        //   ),
        // )
      ],
    );
  }
}
