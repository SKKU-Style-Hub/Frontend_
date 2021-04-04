import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

File screenshotFile;
String screenshotString;

class MyApp extends StatefulWidget {
  File selectedPhoto;
  MyApp({this.selectedPhoto}) {}
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final cropKey = GlobalKey<CropState>();
  File _file;
  File _sample;
  File _lastCropped;

  @override
  void dispose() {
    super.dispose();
    _file?.delete();
    _sample?.delete();
    _lastCropped?.delete();
  }

  Future<void> _askOption() async {
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
                Navigator.pop(context); //창 끄기
                _openImage(ImageSource.camera);
              },
            ),
            SimpleDialogOption(
              child: Text("앨범에서 가져오기"),
              onPressed: () {
                //Navigator.pop(context);
                _openImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: _sample == null ? _buildOpeningImage() : _buildCroppingImage(),
        ),
      ),
    );
  }

  Widget _buildOpeningImage() {
    return Center(child: _buildOpenImage());
  }

  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(_sample, key: cropKey),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                child: Text(
                  'Crop Image',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.white),
                ),
                onPressed: () => _cropImage(),
              ),
              _buildOpenImage(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOpenImage() {
    return FlatButton(
      child: Text(
        'Open Image',
        style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
      ),
      onPressed: () => _askOption(),
    );
  }

  Future<void> _openImage(ImageSource source) async {
    final file = await ImagePicker.pickImage(source: source);
    final sample = await ImageCrop.sampleImage(
      file: file,
      preferredSize: context.size.longestSide.ceil(),
    );

    _sample?.delete();
    _file?.delete();

    setState(() {
      _sample = sample;
      _file = file;
    });
    print('file: $file');
  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      return;
    }
    final sample = await ImageCrop.sampleImage(
      file: _file,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    /*final File imageFile = File(
        '/storage/emulated/0/Android/data/com.example.stylehub_flutter/files/Pictures/someImageFile.jpg');
    await imageFile.create(recursive: true);
    imageFile.wri
    sample.delete();*/

    _lastCropped?.delete();
    _lastCropped = file;

    print('file: $file');
    final bytes = file.readAsBytesSync();

    setState(() {
      screenshotFile = file;
      screenshotString = base64Encode(bytes);
    });
    Navigator.pop(context, screenshotString);
  }
}
