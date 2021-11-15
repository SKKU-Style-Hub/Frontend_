import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:gender_picker/source/enums.dart' as Gen;
import 'package:kakao_flutter_sdk/all.dart';
import 'package:number_selection/number_selection.dart';
import 'package:codime/main.dart';
import 'Navigation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  Gen.Gender selectedGender = null;
  String selectedNickname = StyleHub.myNickname;
  int selectedAge = 20;

  storeToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userNickname', selectedNickname);
    await prefs.setString('userGender', selectedGender.toString());
    StyleHub.myNickname = selectedNickname;
    StyleHub.myGender = selectedGender.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.black,
            height: 220,
            child: Container(
              margin: EdgeInsets.all(20),
              alignment: Alignment.bottomLeft,
              child: Text(
                "사용자 정보를 입력해주세요.",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'NotoSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Text(
                  "닉네임",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  width: 150,
                  child: TextField(
                    decoration: InputDecoration(hintText: StyleHub.myNickname),
                    onChanged: (value) {
                      selectedNickname = value;
                    },
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey[400])),
                  onPressed: () {
                    String url = "http://34.64.196.105:82/api/auth/signup";
                    http.post(url,
                        headers: {
                          'Content-type': 'application/json',
                          'Accept': 'application/json',
                        },
                        body: jsonEncode({
                          "userProfile": {
                            "userName": selectedNickname,
                            "profileImage": StyleHub.myProfileImg,
                            "gender": selectedGender.toString(),
                            "password": "ee",
                            "age": selectedAge
                          },
                        }));
                  },
                  child: Text(
                    "중복 확인",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "성별",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
              child: GenderPickerWithImage(
            showOtherGender: false,
            verticalAlignedText: true,
            selectedGender: null,
            selectedGenderTextStyle:
                TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            unSelectedGenderTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 18),
            onChanged: (Gen.Gender gender) {
              selectedGender = gender;
            },
            equallyAligned: true,
            animationDuration: Duration(milliseconds: 300),
            isCircular: true,
            // default : true,
            opacityOfGradient: 0.4,
            padding: const EdgeInsets.only(left: 55),
            size: 90, //default : 40
          )),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "나이",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(20),
              height: 70,
              child: NumberSelection(
                initialValue: 20,
                minValue: 1,
                maxValue: 50,
                direction: Axis.horizontal,
                withSpring: false,
                onChanged: (int value) {
                  selectedAge = value;
                },
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                primary: Colors.black,
              ),
              onPressed: () {
                if (selectedGender != null) {
                  storeToPrefs();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Navigation(
                                selectedPosition: 0,
                              )),
                      (route) => false);
                } else {
                  Fluttertoast.showToast(
                    msg: "성별은 필수 입력 값입니다.",
                    toastLength: Toast.LENGTH_SHORT,
                  );
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 100),
                child: Text(
                  "완료",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
