import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:gender_picker/source/enums.dart' as Gen;
import 'package:kakao_flutter_sdk/all.dart';
import 'package:number_selection/number_selection.dart';
import 'Navigation.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  Gen.Gender selectedGender = null;
  String kakaoNickname = "";
  String selectedNickname;
  bool isButtonDisabled = true;

  getNickname() async {
    User user = await UserApi.instance.me();
    //setState(() {
    kakaoNickname = user.properties["nickname"];
    selectedNickname = kakaoNickname;
    //});
  }

  @override
  Widget build(BuildContext context) {
    getNickname();
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
                    decoration: InputDecoration(hintText: kakaoNickname),
                    onChanged: (value) {
                      selectedNickname = value;
                      if (value != "") {
                        setState(() {
                          isButtonDisabled = false;
                        });
                      } else {
                        setState(() {
                          isButtonDisabled = true;
                        });
                      }
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
                    if (!isButtonDisabled) {}
                  },
                  child: isButtonDisabled
                      ? Text("중복 확인")
                      : Text(
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
                onChanged: (int value) => print("value: $value"),
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
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Navigation(
                              selectedPosition: 0,
                            )),
                    (route) => false);
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
