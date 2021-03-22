import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:path/path.dart' as Path;
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

class RegisterPage extends StatefulWidget {
  static bool registered = false;
  String base64Img;
  RegisterPage();
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File mPhoto;
  String brandInput;
  void onPhoto(ImageSource source) async {
    File f = await ImagePicker.pickImage(
        source: source, maxHeight: 500, maxWidth: 450);
    print("imgSizeWidth " + ImageSizeGetter.getSize(FileInput(f)).toString());
    print("imgSizeHeight " + Image.file(f).height.toString());
    //
    // String fileName = f.path.split('/').last;
    // FormData formData = FormData.fromMap({
    //   "file": await MultipartFile.fromFile(f.path,
    //       filename: fileName, contentType: MediaType("image", "jpg")),
    //   "submit": "upload"
    // });
    // var response = await Dio().post("http://14.49.45.139:443", data: formData);
    // print(response.data);
    // File responseFile = File(f.path);
    // var raf = responseFile.openSync(mode: FileMode.WRITE);
    // raf.writeStringSync(response.data);
    // await raf.close();
    // print(await responseFile.length());
    // print(response.data.toString());

    var bytes = await f.readAsBytes();
    print("imgSize " + bytes.length.toString());
    setState(() {
      mPhoto = f;

      //mPhoto = responseFile;
    });
  }

  // void saveFile(bytes) async {
  //   Directory documentDirectory = await getApplicationDocumentsDirectory();
  //   File file = File(Path.join(documentDirectory.path, 'image.png'));
  //   file.writeAsBytesSync(bytes);
  // }

  void getOmnious() async {
    final bytes = mPhoto.readAsBytesSync();
    widget.base64Img = base64Encode(bytes);

    String url = "https://api.omnious.com/tagger/v2.12/tags";
    final response = await http.post(url,
        headers: <String, String>{
          "Content-Type": "application/json",
          "x-api-key": "uWHs0KwUapQYJfBz6PnkrTx13cIE7jGMO2qAyCli",
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
      brandName: brandInput
    ));
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
        child: SimpleDialog(
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
        ));
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
                                  child: mPhoto == null
                                      ? beforeCard()
                                      : afterCard(mPhoto),
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
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        disabledColor: Colors.black,
                        onPressed: () {
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
                      ),
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
