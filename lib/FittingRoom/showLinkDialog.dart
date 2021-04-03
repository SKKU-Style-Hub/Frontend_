import 'package:flutter/material.dart';
import 'FittingRoom.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:stylehub_flutter/common/showToast.dart';
import 'cropImg.dart';
import 'package:stylehub_flutter/data/ProductClothing.dart';
import 'package:stylehub_flutter/data/LinkClothingDatabase.dart';
import 'package:image/image.dart' as Img;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:stylehub_flutter/main.dart';
import 'package:cached_network_image/cached_network_image.dart';

TextStyle labelTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: Colors.indigo[700],
);

//상의인지 하의인지 어떤 type임을 나타내는
String linktype = "상의";

String linkurl;
File mPhoto;
String mPhoto64;
void showLinkDialog(BuildContext context) {
  mPhoto = null;
  mPhoto64 = null;
  showDialog(
      context: context,
      //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          //onPhoto함수
          void onPhoto(ImageSource source) async {
            File f = await ImagePicker.pickImage(
                source: source, maxHeight: 500, maxWidth: 450);
            setState(() {
              mPhoto = f;
            });
          }

          return AlertDialog(
            titlePadding: EdgeInsets.only(top: 20),
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
                    child: Text("링크로 옷 등록하기",
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
                    SizedBox(
                      height: 20,
                    ),
                    Text("링크", style: labelTextStyle),
                    //링크입력창
                    Container(
                      width: 200,
                      height: 50,
                      child: TextField(
                        expands: true,
                        minLines: null,
                        maxLines: null,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          counterStyle: TextStyle(
                            decorationStyle: TextDecorationStyle.solid,
                            color: Colors.blue,
                            fontSize: 13.0,
                          ),
                          hintText: "링크 입력...",
                          hintStyle:
                              TextStyle(fontSize: 13, color: Colors.black),
                          contentPadding: EdgeInsets.only(left: 2.0, top: 2.0),
                        ),
                        onChanged: (String str) {
                          linkurl = str;
                        },
                      ),
                    ),
                    Text("스크린샷 업로드", style: labelTextStyle),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          elevation: 10,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: GestureDetector(
                                  onTap: () async {
                                    FocusScope.of(context).unfocus();
                                    mPhoto64 = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MyApp(selectedPhoto: mPhoto),
                                        ));
                                    setState(() {
                                      mPhoto = screenshotFile;
                                    });
                                    print("mPhoto_file: $mPhoto");
                                  },
                                  child: mPhoto64 == null
                                      ? beforeCard()
                                      : afterCard(mPhoto, mPhoto64),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("분류 : ", style: labelTextStyle),
                        DropdownButton(
                          iconEnabledColor: Colors.indigo,
                          value: linktype,
                          items: [
                            DropdownMenuItem(
                              child: Text("상의"),
                              value: "상의",
                            ),
                            DropdownMenuItem(
                              child: Text("하의"),
                              value: "하의",
                            ),
                            DropdownMenuItem(
                              child: Text("원피스"),
                              value: "원피스",
                            ),
                            DropdownMenuItem(
                              child: Text("아우터"),
                              value: "아우터",
                            ),
                            DropdownMenuItem(
                              child: Text("신발"),
                              value: "신발",
                            ),
                            DropdownMenuItem(
                              child: Text("가방"),
                              value: "가방",
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              linktype = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("옷 가져오기",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.indigo)),
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  //String linkurl, File mphoto(in cache) or Base64
                  //String linktype
                  //파일 배경제거 하고
                  //productclothing class에 저장
                  //'/storage/emulated/0/Android/data/com.example.stylehub_flutter/files/Pictures/someImageFile.jpg'
                  String fileName = mPhoto.path.split('/').last;
                  FormData formData = FormData.fromMap({
                    "file": await MultipartFile.fromFile(
                        '/storage/emulated/0/Android/data/com.example.stylehub_flutter/files/Pictures/someImageFile.jpg',
                        filename: 'someImageFile.jpg',
                        contentType: MediaType("image", "jpg")),
                    "submit": "upload",
                    "userNickname": StyleHub.myNickname
                  });
                  var response = await Dio().post(
                      "http://34.64.196.105:82/api/back/removal/remove",
                      data: formData);
                  print(response);
                  final int closet_index =
                      await LinkClothingDatabase.totalProductNum();
                  await LinkClothingDatabase.insertProduct(ProductClothing(
                      request_num: closet_index + 1,
                      img_path: "ss", //imagepath,
                      encoded_img: "dd", //encodedimage,
                      brand: null,
                      detail_url: linkurl,
                      fashion_url: null,
                      item_url: null,
                      name: null,
                      price: null,
                      score: null,
                      category: linktype));

                  showToast("성공적으로 가져왔습니다");
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
  mPhoto = imgFile;
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
