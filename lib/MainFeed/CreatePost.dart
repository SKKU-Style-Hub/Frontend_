import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as Img;
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:http/http.dart' as http;

//photo edit: image editor pro

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  List<Asset> images = <Asset>[];
  String postContent = "";
  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '피드 올리기',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          FlatButton(
              onPressed: () async {
                List<String> postImgBase64 = [];
                for (Asset a in images) {
                  ByteData bytes =
                      await a.getThumbByteData(480, 480, quality: 70);

                  postImgBase64
                      .add(base64.encode(Uint8List.view(bytes.buffer)));
                }

                String url = "http://34.64.196.105:82/api/post/general/create";
                http.post(url,
                    headers: {
                      'Content-type': 'application/json',
                      'Accept': 'application/json',
                    },
                    body: jsonEncode({
                      "userProfile": {"userName": "dddd", "gender": "eee"},
                      "postImage": postImgBase64,
                      "postContent": postContent.toString()
                    }));
                Navigator.pop(context);
              },
              child: Text(
                "완료",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ))
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            padding: EdgeInsets.all(15),
            child: TextField(
              //focusNode: NoKeyboardEditableTextFocusNode(),
              expands: true,
              minLines: null,
              maxLines: null,
              style: TextStyle(
                fontSize: 18,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                counterStyle: TextStyle(
                  decorationStyle: TextDecorationStyle.solid,
                  color: Colors.blue,
                  fontSize: 18.0,
                ),
                //labelStyle: TextStyle(),
                hintText: "패션에 관련된 피드를 올려보세요.",
                hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                contentPadding: EdgeInsets.only(left: 2.0, top: 2.0),
              ),
              onChanged: (String str) {
                setState(() {
                  //입력된 거 저장함
                  postContent = str;
                });
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              loadAssets();
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Icon(Icons.image),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "사진 업로드",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: buildGridView(),
          )
        ],
      ),
    );
  }
}
