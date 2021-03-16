import 'package:flutter/material.dart';
import '../Navigation.dart';
import 'RequestChoose.dart';

class AfterRequest extends StatefulWidget {
  AfterRequest({Key key}) : super(key: key) {}
  _AfterRequestState createState() {
    return _AfterRequestState();
  }
}

class _AfterRequestState extends State<AfterRequest> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          Spacer(flex: 15),
          Center(
              child: Icon(
            Icons.email_outlined,
            color: Colors.black,
            size: 120,
          )),
          Spacer(flex: 3),
          Text("요청이 완료되었습니다",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          Spacer(flex: 3),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  left: 15.0, top: 10.0, right: 15.0, bottom: 10.0),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("확인",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
            onTap: () {
              //메인페이지 이동 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Navigation(
                    selectedPosition: 2,
                  );
                  //return Fittingroom();
                }),
              );
            },
          ),
          Spacer(flex: 8)
        ],
      ),
    ));
  }
}
