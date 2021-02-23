import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'Userfeedinput3.dart';
import 'MyRoom.dart';

//선택한 피드사진
String selected_user_photo = "assets/images/friend_photo1.png";

class Userfeedinput1 extends StatefulWidget {
  Userfeedinput1({Key key}) : super(key: key);

  @override
  _Userfeedinput1State createState() => _Userfeedinput1State();
}

class _Userfeedinput1State extends State<Userfeedinput1> {
  File _image;
  final picker = ImagePicker();
  BoxFit photofit = BoxFit.fitWidth;
  Icon photoicon = Icon(Icons.unfold_more_sharp);

  @override
  Widget build(BuildContext context) {
    Future getImage(ImageSource imageSource) async {
      File pickedFile = await ImagePicker.pickImage(source: imageSource);
      setState(() {
        if (pickedFile != null) {
          _image = pickedFile;
        }
      });
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: FlatButton(
                    minWidth: 0,
                    color: Colors.transparent,
                    padding: new EdgeInsets.all(0.0),
                    onPressed: () {
                      //pop넣기뒤로가기
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 32,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text("새 게시물",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: FlatButton(
                    minWidth: 0,
                    color: Colors.transparent,
                    padding: new EdgeInsets.all(0.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Userfeedinput3(
                                  user_photo: showImage(),
                                )),
                      );
                    },
                    child: Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //사진
          Stack(
            children: [
              Positioned(
                //top: 0,
                //left: 0,
                child: Container(
                  color: Colors.white,
                  child: SizedBox(
                    width: 360,
                    height: 360,
                    //사진 가져오는 거
                    child: showImage(),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      if (photofit == BoxFit.fitWidth) {
                        photofit = BoxFit.scaleDown;
                        photoicon = Icon(Icons.unfold_less);
                      } else {
                        photofit = BoxFit.fitWidth;
                        photoicon = Icon(Icons.unfold_more);
                      }
                    });
                  },
                  padding: new EdgeInsets.all(0.0),
                  minWidth: 0,
                  child: photoicon,
                ),
              ),
            ],
          ),
          Container(
            color: Colors.white,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text("이미지 가져오기",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
                Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: FlatButton(
                        minWidth: 0,
                        color: Colors.transparent,
                        child: Icon(Icons.photo, color: Colors.black, size: 25),
                        onPressed: () {
                          setState(() {
                            getImage(ImageSource.gallery);
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: FlatButton(
                        minWidth: 0,
                        color: Colors.transparent,
                        child: Icon(Icons.camera_alt,
                            color: Colors.black, size: 25),
                        onPressed: () {
                          setState(() {
                            getImage(ImageSource.camera);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showImage() {
    if (_image == null) {
      //사진찍은이미지
      return Center(
        child: Text(
          "이미지를 선택해주세요.",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      );
    } else {
      return Container(
        child: Image.file(
          _image,
          fit: photofit,
          //fit: BoxFit.scaleDown,
          //딱 맞고 위에랑 아래가 짤리게끔
        ),
      );
    }
  }
}
