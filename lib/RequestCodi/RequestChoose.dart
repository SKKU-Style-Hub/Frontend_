import 'package:flutter/material.dart';
import 'RequestPage2.dart';
import 'Checkcodi.dart';
import 'Checkcodi.dart';

class RequestChoose extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(children: [
            Spacer(
              flex: 1,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black)),
              margin: EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 30.0, bottom: 10.0),
              height: 50,
              width: 300,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RequestPageForm()));
                },
                child: Center(
                  child: Text("코디요청서 보내기",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black)),
              margin: EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
              height: 50,
              width: 300,
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CheckCodiForm()));
                },
                child: Center(
                  child: Text("받은 코디 제안 확인하기",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
          ]),
        ),
      ),
    );
  }
}
