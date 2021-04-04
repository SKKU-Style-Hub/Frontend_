import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stylehub_flutter/Constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylehub_flutter/data/MyClothing.dart';
import 'dart:io';
import '../data/MyClothingDatabase.dart';
import '../Navigation.dart';
import 'package:image/image.dart' as Img;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:stylehub_flutter/main.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RegisterPage extends StatefulWidget {
  static bool registered = false;
  String base64Img;
  String backRemovePath;
  String backRemoveUrl;
  RegisterPage();
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File mPhoto;
  String brandInput;
  bool isClicked = false;
  String imgPath;
  void onPhoto(ImageSource source) async {
    File f = await ImagePicker.pickImage(
        source: source, maxHeight: 500, maxWidth: 450);
    imgPath = f.path;
    final int closet_index = await MyClothingDatabase.totalClothingNum();
    String fileName = f.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(f.path,
          filename: fileName, contentType: MediaType("image", "jpg")),
      "submit": "upload",
      "userNickname": StyleHub.myNickname
    });
    var response = await Dio().post(
        "http://34.64.196.105:82/api/back/removal/remove",
        data: formData);

    print(response.data);

    var response2 = await http.get(response.data);
    while (response2.statusCode == 404) {
      print("retry");
      response2 = await http.get(response.data);
    }

    String dir = (await getApplicationDocumentsDirectory()).path;
    final file = File('${dir}/' + 'closet2_${closet_index}.png');
    file.writeAsBytesSync(response2.bodyBytes);
    List<int> imageBytes = file.readAsBytesSync();
    setState(() {
      mPhoto = f;
      widget.backRemovePath = file.path;
      widget.backRemoveUrl = response.data.toString();
      widget.base64Img = base64Encode(imageBytes);
    });
  }

  void getOmnious() async {
    final bytes = mPhoto.readAsBytesSync();
    var tagResult;
    widget.base64Img = base64Encode(bytes);

    String url = "https://api.omnious.com/tagger/v2.12/tags";
    final response = await http.post(url,
        headers: <String, String>{
          "Content-Type": "application/json",
          "x-api-key": "7ED65zaQXknFLAKifx0YoBdWc8m23PTwblJyZRN4",
          "accept-language": "ko"
        },
        body: jsonEncode({
          "image": {"type": "url", "content": widget.backRemoveUrl}
        }));

    tagResult = jsonDecode(utf8.decode(response.bodyBytes));
    print(tagResult.toString());

    if (tagResult['status'] == 'fail') {
      Fluttertoast.showToast(
        msg: tagResult["error"]["message"].toString(),
        toastLength: Toast.LENGTH_LONG,
      );
      setState(() {
        isClicked = false;
      });
      return;
    }

    if (tagResult['data']['objects'][0]['type'] == "no detected product") {
      Fluttertoast.showToast(
        msg: "사진에서 옷을 찾을 수 없습니다. 다른 사진을 등록해주세요.",
        toastLength: Toast.LENGTH_LONG,
      );
      setState(() {
        isClicked = false;
      });
      return;
    }

    String url2 = "http://34.64.196.105:82/api/closet/create/cloth";
    var response2 = await http.post(url2,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "userProfile": {
            "userNickname": StyleHub.myNickname,
            "gender": StyleHub.myGender
          },
          "tagResult": tagResult,
          "clothingImage": widget.base64Img //배경제거 후 링크
        }));

    final int closet_index = await MyClothingDatabase.totalClothingNum();
    await MyClothingDatabase.insertClothing(MyClothing(
        id: closet_index,
        clothingImgPath: widget.backRemovePath,
        clothingImgUrl: widget.backRemoveUrl,
        clothingImgBase64: widget.base64Img, //배경 제거 안됨
        category: tagResult['data']['objects'][0]['tags'][0]['category']
            ['name'],
        color: tagResult['data']['objects'][0]['tags'][0]['colors'][0]['name'],
        colorDetail: tagResult['data']['objects'][0]['tags'][0]['colorDetail']
            [0]['code'],
        print: tagResult['data']['objects'][0]['tags'][0]['prints'][0]['name'],
        look: tagResult['data']['objects'][0]['tags'][0]['looks'][0]['name'],
        texture: tagResult['data']['objects'][0]['tags'][0]['textures'][0]
            ['name'],
        detail: tagResult['data']['objects'][0]['tags'][0]['details'] != null
            ? tagResult['data']['objects'][0]['tags'][0]['details'][0]['name']
            : null,
        length: tagResult['data']['objects'][0]['tags'][0]['length']['name'],
        sleeveLength:
            tagResult['data']['objects'][0]['tags'][0]['sleeveLength'] != null
                ? tagResult['data']['objects'][0]['tags'][0]['sleeveLength']
                    ['name']
                : null,
        neckLine: tagResult['data']['objects'][0]['tags'][0]['neckLine'] != null
            ? tagResult['data']['objects'][0]['tags'][0]['neckLine']['name']
            : null,
        fit: tagResult['data']['objects'][0]['tags'][0]['fit'] != null
            ? tagResult['data']['objects'][0]['tags'][0]['fit']['name']
            : null,
        shape: tagResult['data']['objects'][0]['tags'][0]['shape'] != null
            ? tagResult['data']['objects'][0]['tags'][0]['shape']['name']
            : null,
        brandName: brandInput));
    final closet = await MyClothingDatabase.getMyCloset();
    print(closet.length);

    setState(() {
      RegisterPage.registered = true;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Navigation(
                selectedPosition: 1,
              )),
    );
  }

  Future _askOption() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            "옷 이미지 업로드 경로",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            SimpleDialogOption(
              child: Text(
                "카메라로 촬영하기",
              ),
              onPressed: () {
                Navigator.pop(context);
                onPhoto(ImageSource.camera);
              },
            ),
            SimpleDialogOption(
              child: Text("앨범에서 가져오기"),
              onPressed: () {
                Navigator.pop(context);
                onPhoto(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
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
        body: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 90,
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
                                    _askOption();
                                  },
                                  child: widget.backRemoveUrl == null
                                      ? beforeCard()
                                      : afterCard(widget.backRemoveUrl),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        child: TextField(
                            controller: textController,
                            onChanged: (String value) {
                              brandInput = value;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '브랜드 입력',
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: !isClicked
                          ? RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              disabledColor: Colors.black,
                              onPressed: () {
                                setState(() {
                                  isClicked = true;
                                });
                                getOmnious();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 55),
                                child: Text(
                                  '옷 등록하기',
                                  style: kButtonTextStyle,
                                ),
                              ),
                            )
                          : CircularProgressIndicator(),
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    Expanded(
                      child: Container(
                        height: 80,
                        alignment: Alignment.bottomCenter,
                        child: Image.asset('assets/wall_texture.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
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

Card afterCard(String imgUrl) {
  print("imgUrl " + imgUrl);
  return Card(
    elevation: 5,
    child: Container(
      height: 235,
      child: Center(
          child: Image.network(
        imgUrl,
        height: 235,
      )),
    ),
  );
}

// CachedNetworkImage(
// imageUrl: imgUrl,
// placeholder: (context, url) => CircularProgressIndicator(),
// errorWidget: (context, url, error) => Icon(Icons.error),
// ),
