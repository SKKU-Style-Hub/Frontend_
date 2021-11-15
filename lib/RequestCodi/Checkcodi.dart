import 'package:flutter/material.dart';
import 'package:codime/Constants.dart';
import '../FittingRoom/FittingRoom.dart';
import 'RawData.dart';

class ReceivedCodi {
  String top_path;
  String bottom_path;
  String shoes_path;
  String onepiece_path;
  String outer_path;
  String stylist;
  ReceivedCodi(
      {this.top_path,
      this.bottom_path,
      this.shoes_path,
      this.onepiece_path,
      this.outer_path,
      this.stylist}) {}
}

List<dynamic> receivedCodiList = [];

class CheckCodiForm extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: CheckCodi(),
    );
  }
}

class CheckCodi extends StatefulWidget {
  static int checkCodi = 1;
  _CheckCodiState createState() {
    return _CheckCodiState();
  }
}

class _CheckCodiState extends State<CheckCodi> {
  Widget build(BuildContext context) {
    //for raw-data
    receivedCodiList = [];
    receivedCodiList.add(rc1);
    receivedCodiList.add(rc2);
    receivedCodiList.add(rc3);
    receivedCodiList.add(rc4);
    //receivedCodiList에 옷정보 받아오면 된다
    return Container(
      child: ListView(
          scrollDirection: Axis.vertical,
          children: List.generate(receivedCodiList.length, (idx) {
            return Container(
              margin: EdgeInsets.only(
                bottom: 10,
                top: 10,
                right: 10,
                left: 10,
              ),
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 3,
                  )
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    child: Text(
                      "From.${receivedCodiList[idx].stylist}",
                      style: kTitleTextStyle,
                    ),
                    top: 10,
                    right: 10,
                  ),
                  //list안에 있는 내용들
                  Positioned(
                    top: 40,
                    right: 140,
                    child: SizedBox(
                      height: 140,
                      width: 140,
                      child: Image.asset(receivedCodiList[idx].top_path),
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      right: 0,
                      left: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  left: 15.0,
                                  top: 10.0,
                                  right: 15.0,
                                  bottom: 10.0),
                              //height: 50,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("피팅룸으로 이동하기",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            ),
                            onTap: () {
                              //다음 페이지 이동
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return FittingRoom(
                                      /*selected_top1:
                                          receivedCodiList[idx].top_path,
                                      selected_bottom1:
                                          receivedCodiList[idx].bottom_path,
                                      selected_shoes1:
                                          receivedCodiList[idx].shoes_path,
                                      selected_onepiece1: null,
                                      selected_outer1: null,*/
                                      );
                                }),
                              );
                            },
                          ),
                        ],
                      )),
                ],
              ),
            );
          })),
    );
  }
}
