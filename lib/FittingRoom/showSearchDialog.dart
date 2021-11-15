import 'package:flutter/material.dart';
import 'FittingRoom.dart';
import 'dart:convert';
import 'dart:io';
import 'package:codime/common/showToast.dart';
import '../components/SmallStylebutton.dart';
import '../components/SmallItembutton.dart';

TextStyle labelTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: Colors.indigo[700],
);

void showSearchDialog(BuildContext context) {
  showDialog(
      context: context,
      //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          for (int i = 0; i < style_smalllist.length; i++) {
            style_smallclick.add(0);
          }
          for (int i = 0; i < item_smalllist.length; i++) {
            item_smallclick.add(0);
          }
          return AlertDialog(
            contentPadding: EdgeInsets.all(5),
            titlePadding: EdgeInsets.only(top: 20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            title: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Text("옷 검색하기",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                  InkWell(
                    child: Icon(Icons.close, size: 25),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            content: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Container(
                      //margin: EdgeInsets.only(left: 20.0),
                      alignment: Alignment.centerLeft,
                      height: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "#아이템",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            margin: EdgeInsets.only(left: 20.0),
                          ),
                          /*GridView.count(
                            crossAxisCount: 3,
                            children: List.generate(
                              16,
                              (idx) {
                                return Itembutton(
                                  item_index: idx,
                                );
                              },
                            ),
                          ),*/
                          Row(
                              children: List.generate(4, (idx) {
                            return SmallItembutton(
                              item_index: idx,
                            );
                          })),
                          Row(
                              children: List.generate(4, (idx) {
                            return SmallItembutton(
                              item_index: idx + 4,
                            );
                          })),
                          Row(
                              children: List.generate(4, (idx) {
                            return SmallItembutton(
                              item_index: idx + 8,
                            );
                          })),
                          Row(
                              children: List.generate(4, (idx) {
                            return SmallItembutton(
                              item_index: idx + 12,
                            );
                          })),
                        ],
                      ),
                    ),
                    //스타일------------------------------------------------
                    Container(
                      //margin: EdgeInsets.only(left: 20.0),
                      alignment: Alignment.centerLeft,
                      height: 220,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "#스타일",
                              style: TextStyle(
                                color: Colors.black,
                                //color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              //textAlign: TextAlign.left,
                            ),
                            margin: EdgeInsets.only(left: 20.0),
                          ),
                          Row(
                              children: List.generate(4, (idx) {
                            return SmallStylebutton(
                              style_index: idx,
                            );
                          })),
                          Row(
                              children: List.generate(4, (idx) {
                            return SmallStylebutton(
                              style_index: idx + 4,
                            );
                          })),
                          Row(
                              children: List.generate(4, (idx) {
                            return SmallStylebutton(
                              style_index: idx + 8,
                            );
                          })),
                          Row(
                              children: List.generate(4, (idx) {
                            return SmallStylebutton(
                              style_index: idx + 12,
                            );
                          })),
                          Row(
                              children: List.generate(3, (idx) {
                            return SmallStylebutton(
                              style_index: idx + 16,
                            );
                          })),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("옷 검색하기",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.indigo)),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  //누르면 검색되도록 하자
                  showToast("검색 완료");
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
      });
}

Card beforeCard() {
  return Card(
    elevation: 5,
    color: Colors.grey[350],
    child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          children: [
            Icon(
              Icons.photo_camera,
              size: 50,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '사진을 등록하세요.',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Noto Sans',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Card afterCard(File imgFile, String decode64) {
  return Card(
    elevation: 5,
    child: Center(
      child:
          /*Image.memory(
      base64Decode(decode64),
      height: 235,
    )*/
          Image.file(
        imgFile,
        height: 235,
      ),
    ),
  );
}
