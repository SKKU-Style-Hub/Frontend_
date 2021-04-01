import 'dart:convert';
import 'package:stylehub_flutter/MainFeed/GeneratedComponents.dart';
import 'package:stylehub_flutter/data/MyClothing.dart';
import 'package:stylehub_flutter/data/ProductClothing.dart';
import 'package:stylehub_flutter/data/ProductClothingDatabase.dart';
import 'package:stylehub_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../components/Colorbutton.dart';
import '../components/Stylebutton.dart';
import '../components/Itembutton.dart';
import '../components/Budgetline.dart';
import 'AfterRequest.dart';
import 'ChooseClothingPage.dart';
import 'package:http/http.dart' as http;
import '../MyCloset/MyClosetPage.dart';
import 'dart:io' as Io;
import 'package:path_provider/path_provider.dart';

//사용자이름
String userName = StyleHub.myNickname;

class RequestPage extends StatefulWidget {
  String chosenBase64;
  int chosenId;
  String chosenType;
  MyClothing chosenClothing;

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  String requestContent = "";
  SfRangeValues _costvalues = SfRangeValues(5.0, 10.0);
  double cost_userwant = 10.0;
  List<String> chosenStyle = [];
  List<String> chosenItem = [];
  RequestClothings chosenClothing;

  void getStyling(
      int request_num, String clothBase64, String request_category) async {
    String sex = StyleHub.myGender == 'Gender.Female' ? 'WOMEN' : 'MEN';
    String url = "http://115.145.212.100:51122/post";
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    Map<String, dynamic> data = {
      'top_k': 20,
      'sex': sex,
      'category': request_category,
      'image': clothBase64
    };
    http.Response response = await http
        .post(url, headers: headers, body: jsonEncode(data))
        .timeout(Duration(seconds: 180));
    var result = json.decode(response.body);
    for (int i = 0; i < 15; i++) {
      String dir = (await getApplicationDocumentsDirectory()).path;
      var file = Io.File('${dir}/' + 'recommend_${request_num}_${i}.png');
      file.writeAsBytesSync(
          base64.decode(result['Deep']['predictions_info'][i]['encoded_img']));
      ProductClothingDatabase.insertProduct(ProductClothing(
          request_num: request_num,
          img_path: file.path,
          encoded_img: result['Deep']['predictions_info'][i]['encoded_img'],
          brand: result['Deep']['predictions_info'][i]['brand'],
          detail_url: result['Deep']['predictions_info'][i]['detail_url'],
          fashion_url: result['Deep']['predictions_info'][i]['fashion_url'],
          item_url: result['Deep']['predictions_info'][i]['item_url'],
          name: result['Deep']['predictions_info'][i]['name'],
          price: result['Deep']['predictions_info'][i]['price'],
          score: result['Deep']['predictions_info'][i]['score'],
          category: result['Deep']['predictions_info'][i]['category']));

      int total = await ProductClothingDatabase.totalProductNum();
      print(total);
      // ProductClothingDatabase.insertProduct(ProductClothing(
      //   request_num: 100,
      //   encoded_img: result['DeepGraph']['topk'][i]['encoded_img'],
      //   brand: result['DeepGraph']['topk'][i]['brand'],
      //   detail_url: result['DeepGraph']['topk'][i]['detail_url'],
      //   fashion_url: result['DeepGraph']['topk'][i]['fashion_url'],
      //   item_url: result['DeepGraph']['topk'][i]['item_url'],
      //   name: result['DeepGraph']['topk'][i]['name'],
      //   price: result['DeepGraph']['topk'][i]['price'].toString(),
      // ));
      // int total = await ProductClothingDatabase.totalProductNum();
      // print(total);
    }
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 14; i++) {
      color_click.add(0);
    }
    for (int i = 0; i < 19; i++) {
      style_click.add(0);
    }
    for (int i = 0; i < 16; i++) {
      item_click.add(0);
    }
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
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20.0),
                  alignment: Alignment.centerLeft,
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Spacer(
                        flex: 10,
                      ),
                      Text(
                        "${userName} 님의\n코디 요청서",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Noto Sans',
                        ),
                        //textAlign: TextAlign.left,
                      ),
                      Spacer(
                        flex: 10,
                      ),
                      Text(
                        "원하는 옷 딱 그대로\n판매자 님들께 추천받을 수 있어요.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Noto Sans',
                        ),
                      ),
                      Spacer(
                        flex: 10,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 2.0,
                  width: 500.0,
                  color: Colors.black,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  alignment: Alignment.centerLeft,
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Spacer(
                        flex: 20,
                      ),
                      Text(
                        "#함께 코디할 옷",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Spacer(
                        flex: 8,
                      ),
                      Text(
                        "추천 받고 싶은 옷과 함께 코디할 옷 또는 스타일을 추가해 주세요.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Spacer(
                        flex: 10,
                      ),
                      //------------here
                      InkWell(
                        child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 10.0, right: 10.0),
                            height: 150,
                            decoration: BoxDecoration(
                              color: widget.chosenBase64 == null
                                  ? Colors.grey
                                  : Colors.white54,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              //border: Border.all(width: 1, color: Colors.black),
                            ),
                            child: widget.chosenBase64 == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("+",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      Text("옷 선택/추가하기",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ))
                                    ],
                                  )
                                : Image.memory(
                                    base64Decode(widget.chosenBase64),
                                    fit: BoxFit.fill,
                                  )),
                        onTap: () async {
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChooseClothingPage(),
                              ));
                          print(result.id);
                          setState(() {
                            widget.chosenBase64 = result?.clothingImgBase64;
                            widget.chosenId = result?.id;
                            widget.chosenType = result?.category;
                            widget.chosenClothing = result;
                          });
                        },
                      ),
                      Spacer(
                        flex: 15,
                      ),
                      Text(
                        "#예산 설정하기",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(
                        flex: 15,
                      ),
                      SfRangeSlider(
                        tooltipTextFormatterCallback:
                            (dynamic actualValue, String formattedText) {
                          if (actualValue > 27.5) {
                            return '무제한';
                          } else if (actualValue == 0) {
                            return '0원';
                          }
                          return '$formattedText만원';
                        },
                        labelFormatterCallback:
                            (dynamic actualValue, String formattedText) {
                          if (actualValue > 27.5) {
                            return '무제한';
                          } else if (actualValue == 0) {
                            return '0원';
                          }
                          return '$formattedText만원';
                        },
                        min: 0.0,
                        max: 30.0,
                        values: _costvalues,
                        interval: 5,
                        stepSize: 2.5,
                        showTicks: true,
                        showLabels: true,
                        enableTooltip: true,
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey[400],
                        onChanged: (SfRangeValues values) {
                          setState(() {
                            _costvalues = values;
                          });
                        },
                      ),
                      Spacer(flex: 20),
                      Row(
                        children: [
                          Text(
                            "설정한 예산: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 20.0),
                              width: 100,
                              child: Budgetline(
                                highrange: _costvalues.start,
                              )),
                          Container(
                            child: Text(
                              "~",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              //textAlign: TextAlign.left,
                            ),
                            margin: EdgeInsets.only(left: 10.0, right: 10.0),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 20.0),
                              width: 100,
                              child: Budgetline(
                                highrange: _costvalues.end,
                              )),
                        ],
                      ),
                      Spacer(
                        flex: 15,
                      ),
                    ],
                  ),
                ),
                //아이템---------------------------------
                Container(
                  alignment: Alignment.centerLeft,
                  height: 230,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "#아이템",
                          style: TextStyle(
                            color: Colors.black,
                            //color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          //textAlign: TextAlign.left,
                        ),
                        margin: EdgeInsets.only(left: 20.0),
                      ),
                      Row(
                          children: List.generate(4, (idx) {
                        return Itembutton(
                          item_index: idx,
                        );
                      })),
                      Row(
                          children: List.generate(4, (idx) {
                        return Itembutton(
                          item_index: idx + 4,
                        );
                      })),
                      Row(
                          children: List.generate(4, (idx) {
                        return Itembutton(
                          item_index: idx + 8,
                        );
                      })),
                      Row(
                          children: List.generate(4, (idx) {
                        return Itembutton(
                          item_index: idx + 12,
                        );
                      })),
                    ],
                  ),
                ),
                //스타일------------------------------------------------
                Container(
                  //margin: EdgeInsets.only(left: 20.0),
                  alignment: Alignment.centerLeft,
                  height: 230,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "#스타일",
                          style: TextStyle(
                            color: Colors.black,
                            //color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          //textAlign: TextAlign.left,
                        ),
                        margin: EdgeInsets.only(left: 20.0),
                      ),
                      Row(
                          children: List.generate(4, (idx) {
                        return Stylebutton(
                          style_index: idx,
                        );
                      })),
                      Row(
                          children: List.generate(4, (idx) {
                        return Stylebutton(
                          style_index: idx + 4,
                        );
                      })),
                      Row(
                          children: List.generate(4, (idx) {
                        return Stylebutton(
                          style_index: idx + 8,
                        );
                      })),
                      Row(
                          children: List.generate(4, (idx) {
                        return Stylebutton(
                          style_index: idx + 12,
                        );
                      })),
                      Row(
                          children: List.generate(3, (idx) {
                        return Stylebutton(
                          style_index: idx + 16,
                        );
                      })),
                    ],
                  ),
                ),
                //색상----------------------------------
                // Container(
                //   height: 200,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.baseline,
                //     textBaseline: TextBaseline.alphabetic,
                //     children: <Widget>[
                // //       Container(
                // //         child: Text(
                // //           "#색상",
                // //           style: TextStyle(
                // //             color: Colors.black,
                // //             //color: Colors.black,
                // //             fontSize: 18,
                // //             fontWeight: FontWeight.bold,
                // //           ),
                // //           //textAlign: TextAlign.left,
                // //         ),
                // //         margin: EdgeInsets.only(left: 20.0),
                // //       ),
                // //       /*Spacer(
                // //   flex: 20,
                // // ),*/
                // //       Row(
                // //           children: List.generate(10, (idx) {
                // //         return Colorbutton(
                // //           color_index: idx,
                // //         );
                // //       })),
                // //       Row(
                // //           children: List.generate(4, (idx) {
                // //         return Colorbutton(
                // //           color_index: 10 + idx,
                // //         );
                // //       })),
                //       // Row(
                //       //     children: List.generate(10, (idx) {
                //       //   return Colorbutton(
                //       //     color_index: 20 + idx,
                //       //   );
                //       // })),
                //       // Row(
                //       //     children: List.generate(10, (idx) {
                //       //   return Colorbutton(
                //       //     color_index: 30 + idx,
                //       //   );
                //       // })),
                //     ],
                //   ),
                // ),

                /*Container(
                  height: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Container(
                        child: Text(
                          "#상의",
                          style: TextStyle(
                            color: Colors.black,
                            //color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          //textAlign: TextAlign.left,
                        ),
                        margin: EdgeInsets.only(left: 20.0),
                      ),
                      Spacer(flex: 1),
                      SfSlider(
                        /*labelFormatterCallback:
                            (dynamic actualValue, String formattedText) {
                          if (actualValue == 0 || actualValue == 35) {
                            return '';
                          } else if (actualValue == 30) {
                            return '무제한';
                          }
                          return '$formattedText';
                        },*/
                        enableTooltip: true,
                        min: 80.0,
                        max: 115.0,
                        value: top_size,
                        showLabels: true,
                        showTicks: true,
                        stepSize: 5,
                        interval: 5,
                        showDivisors: true,
                        activeColor: Colors.black,
                        inactiveColor: Colors.black,
                        onChanged: (dynamic newValue) {
                          setState(() {
                            top_size = newValue;
                          });
                        },
                      ),
                      Spacer(
                        flex: 3,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 90,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Spacer(flex: 1),
                      Container(
                        child: Text(
                          "#하의",
                          style: TextStyle(
                            color: Colors.black,
                            //color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          //textAlign: TextAlign.left,
                        ),
                        margin: EdgeInsets.only(left: 20.0),
                      ),
                      Spacer(flex: 1),
                      SfSlider(
                        enableTooltip: true,
                        min: 22.0,
                        max: 38.0,
                        value: pants_size,
                        showLabels: true,
                        showTicks: true,
                        stepSize: 1,
                        interval: 2,
                        showDivisors: true,
                        activeColor: Colors.black,
                        inactiveColor: Colors.black,
                        onChanged: (dynamic newValue) {
                          setState(() {
                            pants_size = newValue;
                          });
                        },
                      ),
                      Spacer(
                        flex: 3,
                      ),
                    ],
                  ),
                ),*/

                Container(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Container(
                        child: Text(
                          "#요청사항 입력",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        margin: EdgeInsets.only(left: 20.0),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black)),
                        margin: EdgeInsets.only(
                            left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "  요청사항 직접 입력하기",
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          onChanged: (String str) {
                            setState(() {
                              requestContent = str;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        left: 15.0, top: 10.0, right: 15.0, bottom: 10.0),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("요청하기",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                  onTap: () {
                    for (int i = 0; i < 16; i++) {
                      if (item_click[i] == 1) {
                        chosenItem.add(item_list[i]);
                      }
                    }
                    for (int i = 0; i < 19; i++) {
                      if (style_click[i] == 1) {
                        chosenStyle.add(style_list[i]);
                      }
                    }
                    chosenClothing = RequestClothings(
                        clothingId: widget.chosenClothing.id,
                        userProfile:
                            UserProfile(userNickname: StyleHub.myNickname),
                        clothingImage: widget.chosenBase64);

                    String url =
                        "http://34.64.196.105:82/api/styling/request/create";
                    http.post(url,
                        headers: {
                          'Content-type': 'application/json',
                          'Accept': 'application/json',
                        },
                        body: jsonEncode({
                          "userProfile": {
                            "userNickname": StyleHub.myNickname,
                            "userGender": StyleHub.myGender,
                            "profileImg": StyleHub.myProfileImg
                          },
                          "requestClothings": [chosenClothing.toJson()],
                          "budgetMin": (_costvalues.start.round() * 10000),
                          "budgetMax": (_costvalues.end.round() * 10000),
                          "requestItems": chosenItem,
                          "requestStyle": chosenStyle,
                          "requestContent": requestContent
                        }));
                    if (getType(widget.chosenType) != '기타') {
                      getStyling(widget.chosenId, widget.chosenBase64,
                          getType(widget.chosenType));
                    }

                    //다음 페이지 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AfterRequest()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
