import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/common.dart';
import 'package:bloc/bloc.dart';
import 'package:gender_picker/source/enums.dart' as Gen;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'UserInfoScreen.dart';
import 'Navigation.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginScreen> {
  Gen.Gender selectedGender = null;
  @override
  void initState() {
    super.initState();
    _initKakaoTalkInstalled();
    KakaoContext.clientId = "be4e8ea1218a3a90f7bb5bcdf20fc867";
    KakaoContext.javascriptClientId = "6464ee3e02ef16cfe3811def9a8fdaee";
  }

  @override
  void dispose() {
    super.dispose();
  }

  _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  bool _isKakaoTalkInstalled = true;

  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      AccessTokenStore.instance.toStore(token);

      try {
        User user = await UserApi.instance.me();
        print("access code: 2 " + user.connectedAt.toString());
        await prefs.setString('userNickname', user.properties["nickname"]);
        await prefs.setString(
            'userProfileImg', user.properties["profile_image"]);

        String url = "http://34.64.196.105:82/api/auth/signup";
        http.post(url,
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              "userNickName": user.properties["nickname"].toString(),
              "gender": selectedGender.toString()
            }));

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => UserInfoScreen()),
            (route) => false);
      } on KakaoAuthException catch (e) {} catch (e) {}
    } catch (e) {
      print("error on issuing access token: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    isKakaoTalkInstalled();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: Image.asset(
              "assets/images/SPLASH_image.png",
              height: 450,
            ),
          ),
          Center(
              child: GenderPickerWithImage(
            showOtherGender: false,
            verticalAlignedText: true,
            selectedGender: null,
            selectedGenderTextStyle: TextStyle(
                color: Colors.yellowAccent, fontWeight: FontWeight.bold),
            unSelectedGenderTextStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
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
            height: 50,
          ),
          Center(
            child: GestureDetector(
              child: Image.asset(
                "images/kakao_login_btn.png",
                width: 350,
              ),
              onTap: () {
                if (selectedGender != null) {
                  _isKakaoTalkInstalled ? _loginWithTalk() : _loginWithKakao();
                } else {
                  Fluttertoast.showToast(
                      msg: "성별을 선택해주세요.", toastLength: Toast.LENGTH_SHORT);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _loginWithKakao() async {
    try {
      var code = await AuthCodeClient.instance.request();
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  _loginWithTalk() async {
    try {
      var code = await AuthCodeClient.instance.requestWithTalk();
      print("access code: " + code);
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }
}
