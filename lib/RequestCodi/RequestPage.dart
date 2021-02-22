import 'package:flutter/material.dart';
import 'file:///D:/Development/AndroidStudio/stylehub_flutter/lib/RequestCodi/ChooseClothingPage.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../components/Colorbutton.dart';
import '../components/Stylebutton.dart';
import '../components/Itembutton.dart';
import '../components/Budgetline.dart';
import 'AfterRequest.dart';
import 'package:http/http.dart';

int _select_cloth = 0;
int _imgOffset = 0;
int _index = 0;

class RequestPageForm extends StatelessWidget {
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
      body: RequestPage(),
    );
  }
}

class RequestPage extends StatefulWidget {
  String title;
  RequestPage(
      {Key key, String title, int index, int select_cloth, int imgOffset})
      : super(key: key) {
    this.title = title;
    _imgOffset = imgOffset;
    _index = index;
    if (select_cloth != null) _select_cloth = select_cloth;
    print("select_cloth" + select_cloth.toString());
  }
  @override
  _RequestPageState createState() {
    return _RequestPageState();
  }
}

class _RequestPageState extends State<RequestPage> {
  String requestcomment = "";
  SfRangeValues _costvalues = SfRangeValues(5.0, 10.0);
  double cost_userwant = 10.0;
  double top_size = 90.0;
  double pants_size = 28.0;

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
    if (_select_cloth == 0) {
      return requestPageBody();
    } else {
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
        body: requestPageBody(),
      );
    }
  }

  Widget requestPageBody() {
    print(_select_cloth);
    return Column(
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
                      "minjoo123 님의\n코디 요청서",
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
                      //textAlign: TextAlign.left,
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
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            //border: Border.all(width: 1, color: Colors.black),
                          ),
                          child: _select_cloth == 0
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("+",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    //Spacer(flex: 1),
                                    Text("옷 선택/추가하기",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ))
                                  ],
                                )
                              : Image.asset(
                                  'images/hanger_cloth${_index + _imgOffset}.png',
                                  fit: BoxFit.fitHeight,
                                )),
                      onTap: () {
                        print("what?");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChooseClothingPage(),
                            ));
                        //select_cloth = 1;
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
                      //textAlign: TextAlign.left,
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
                    /*Spacer(
                  flex: 20,
                ),*/
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
                    /*Spacer(
                  flex: 20,
                ),*/
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
              Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "#색상",
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
                    /*Spacer(
                  flex: 20,
                ),*/
                    Row(
                        children: List.generate(10, (idx) {
                      return Colorbutton(
                        color_index: idx,
                      );
                    })),
                    Row(
                        children: List.generate(4, (idx) {
                      return Colorbutton(
                        color_index: 10 + idx,
                      );
                    })),
                    // Row(
                    //     children: List.generate(10, (idx) {
                    //   return Colorbutton(
                    //     color_index: 20 + idx,
                    //   );
                    // })),
                    // Row(
                    //     children: List.generate(10, (idx) {
                    //   return Colorbutton(
                    //     color_index: 30 + idx,
                    //   );
                    // })),
                  ],
                ),
              ),

              Container(
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
              ),
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
                          //color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        //textAlign: TextAlign.left,
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
                            requestcomment = str;
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
    );
  }
}
