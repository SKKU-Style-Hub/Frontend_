import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weight_slider/weight_slider.dart';
import 'package:stylehub_flutter/Constants.dart';

class UserInfoBody1Page extends StatefulWidget {
  @override
  _UserInfoBody1PageState createState() => _UserInfoBody1PageState();
}

class _UserInfoBody1PageState extends State<UserInfoBody1Page> {
  int height = 160;
  int weight = 50;
  int topSize = 90;
  int bottomSize = 27;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text('minjoo123님의\n체형을 알려주세요', style: kTitleTextStyle),
          ),
          Divider(
            thickness: 3,
            color: Colors.black26,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              '# 키(cm)',
              style: kHashtagTextStyle,
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              width: 300,
              height: 80,
              child: WeightSlider(
                weight: height,
                minWeight: 130,
                maxWeight: 200,
                unit: 'cm',
                onChange: (val) {
                  setState(() {
                    this.height = val;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              '# 몸무게(kg)',
              style: kHashtagTextStyle,
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              width: 300,
              height: 80,
              child: WeightSlider(
                weight: weight,
                minWeight: 35,
                maxWeight: 100,
                unit: 'kg',
                onChange: (val) {
                  setState(() {
                    this.weight = val;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                        '#상의',
                        style: kHashtagTextStyle,
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: 185,
                        height: 80,
                        child: WeightSlider(
                          unit: '',
                          weight: topSize,
                          minWeight: 75,
                          maxWeight: 120,
                          onChange: (val) {
                            setState(() {
                              this.topSize = val;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                        '#하의',
                        style: kHashtagTextStyle,
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: 185,
                        height: 80,
                        child: WeightSlider(
                          unit: '',
                          weight: bottomSize,
                          minWeight: 18,
                          maxWeight: 35,
                          onChange: (val) {
                            setState(() {
                              this.bottomSize = val;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
