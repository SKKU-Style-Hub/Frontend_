import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stylehub_flutter/Constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'data/MyClothing.dart';
import 'data/MyClothingDatabase.dart';
import 'Navigation.dart';

class RegisterPage extends StatefulWidget {
  static int registered = 0;
  RegisterPage();
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File mPhoto;
  void onPhoto(ImageSource source) async {
    File f = await ImagePicker.pickImage(source: source);
    setState(() {
      mPhoto = f;
    });
  }

  void registerDB() async {
    final bytes = mPhoto.readAsBytesSync();
    String base64Img = base64Encode(bytes);
    await MyClothingDatabase.insertClothing(
        MyClothing(id: 2, clothingImgBase64: base64Img));
    final closet = await MyClothingDatabase.getMyCloset();
    print("closet length " + closet.length.toString());
    setState(() {
      RegisterPage.registered = 1;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Navigation()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/applogo.png',
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12),
            child: Text('MY 옷장', style: kPageTitleTextStyle),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Card(
                elevation: 10,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            onPhoto(ImageSource.gallery);
                          });
                        },
                        child:
                            mPhoto == null ? beforeCard() : afterCard(mPhoto),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Center(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              disabledColor: Colors.black,
              onPressed: () {
                registerDB();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 55),
                child: Text(
                  '옷 등록하기',
                  style: kButtonTextStyle,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 26,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/wall_texture.png'),
            ),
          ),
        ],
      ),
    );
  }
}

Card beforeCard() {
  return Card(
    elevation: 5,
    color: Colors.grey[350],
    child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 70),
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
                fontSize: 18,
                fontFamily: 'Noto Sans',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Card afterCard(File imgFile) {
  return Card(
    elevation: 5,
    child: Center(
        child: Image.file(
      imgFile,
      height: 235,
    )),
  );
}
