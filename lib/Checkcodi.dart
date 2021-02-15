import 'package:flutter/material.dart';
import 'package:stylehub_flutter/Constants.dart';
import 'FittingRoom.dart';

class Received_codi {
  String top_path;
  String bottom_path;
  String shoes_path;
  String onepiece_path;
  String outer_path;
  Received_codi(
      {String top_path,
      String bottom_path,
      String shoes_path,
      String onepiece_path,
      String outer_path}) {
    this.top_path = top_path;
    this.bottom_path = bottom_path;
    this.shoes_path = shoes_path;
    this.onepiece_path = onepiece_path;
    this.outer_path = outer_path;
  }
}

List<dynamic> Received_codi_list = [];

class CheckCodiForm extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: CheckCodi(),
    );
  }
}

class CheckCodi extends StatefulWidget {
  _CheckCodiState createState() {
    return _CheckCodiState();
  }
}

class _CheckCodiState extends State<CheckCodi> {
  Widget build(BuildContext context) {
    Received_codi_list = [];
    Received_codi rc1 = Received_codi(
        top_path: "assets/images/sample_knit.png",
        bottom_path: "assets/images/sample_pants.png",
        shoes_path: "assets/images/sample_shoes.png",
        onepiece_path: "",
        outer_path: "");
    Received_codi_list.add(rc1);
    Received_codi rc2 = Received_codi(
        top_path: "assets/images/top2.png",
        bottom_path: "assets/images/pants3.png",
        shoes_path: "assets/images/sample_shoes.png",
        onepiece_path: "",
        outer_path: "");
    Received_codi_list.add(rc2);
    return Container(
      child: ListView(
          scrollDirection: Axis.vertical,
          children: List.generate(Received_codi_list.length, (idx) {
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
                      "From.Yesong",
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
                      child: Image.asset(Received_codi_list[idx].top_path),
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
                              print("her");
                              //다음 페이지 이동
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  print("haha");
                                  return Fittingroom(
                                      selected_top1:
                                          Received_codi_list[idx].top_path,
                                      selected_bottom1:
                                          Received_codi_list[idx].bottom_path,
                                      selected_shoes1:
                                          Received_codi_list[idx].shoes_path,
                                      selected_onepiece1: null,
                                      selected_outer1: null);
                                  //return Fittingroom();
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
