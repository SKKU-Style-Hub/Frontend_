import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:stylehub_flutter/Constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylehub_flutter/data/MyClothing.dart';
import 'dart:io';
import '../data/MyClothingDatabase.dart';
import '../Navigation.dart';
import 'package:image/image.dart' as Img;

class RegisterPage extends StatefulWidget {
  static bool registered = false;
  String base64Img;
  RegisterPage();
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File mPhoto;
  bool isLoading = false;
  void onPhoto(ImageSource source) async {
    File f = await ImagePicker.pickImage(source: source);
    Img.Image initialImg = Img.decodeImage(f.readAsBytesSync());
    Img.Image afterImg = Img.copyResize(initialImg, width: 120);
    //print(Img.encodePng(afterImg));
    setState(() {
      //mPhoto..writeAsBytesSync(Img.encodePng(afterImg));
      //print(mPhoto.readAsBytesSync().toString());
      mPhoto = f;
    });
  }

  void saveFile(bytes) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    File file = File(Path.join(documentDirectory.path, 'image.png'));
    file.writeAsBytesSync(bytes);
  }

  void getOmnious() async {
    final bytes = mPhoto.readAsBytesSync();
    widget.base64Img = base64Encode(bytes);
    saveFile(bytes);

    String url = "https://api.omnious.com/tagger/v2.12/tags";
    final response = await http.post(url,
        headers: <String, String>{
          "Content-Type": "application/json",
          "x-api-key": "bWqzpLE4Y36vBugQ20ceSkZAGMDdU9xFOyrRnTo1",
          "accept-language": "ko"
        },
        body: jsonEncode({
          "image": {"type": "base64", "content": widget.base64Img}
        }));

    var tagResult = jsonDecode(utf8.decode(response.bodyBytes));
    print(tagResult.toString());
    final int closet_index = await MyClothingDatabase.totalClothingNum();
    await MyClothingDatabase.insertClothing(MyClothing(
      id: closet_index,
      clothingImgBase64: widget.base64Img,
      category: tagResult['data']['objects'][0]['tags'][0]['category']['name'],
      color: tagResult['data']['objects'][0]['tags'][0]['colors'][0]['name'],
      colorDetail: tagResult['data']['objects'][0]['tags'][0]['colorDetail'][0]
          ['code'],
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
    ));
    final closet = await MyClothingDatabase.getMyCloset();
    print(closet.length);

    setState(() {
      RegisterPage.registered = true;
      isLoading = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Navigation(
                selectedPosition: 1,
              )),
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
            child: !isLoading
                ? RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    disabledColor: Colors.black,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      getOmnious();
                      //sleep(Duration(seconds: 5));
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
                : Center(child: CircularProgressIndicator()),
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
