import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylehub_flutter/Constants.dart';
import 'FittingRoom.dart';

class ProductDetail extends StatefulWidget {
  List codi_clothes;
  ProductDetail({this.codi_clothes}) {}
  _ProductDetailState createState() {
    return _ProductDetailState();
  }
}

//사진, 브랜드이름. 이름. 가격 받아오자. + 구매하기 버튼 만들기
class _ProductDetailState extends State<ProductDetail> {
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEdgeDragWidth: 0,
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: List.generate(widget.codi_clothes.length, (idx) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1, color: Colors.black26),
              ),
              height: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Container(
                      height: 170,
                      child: Image.asset(
                        widget.codi_clothes[idx].imagepath,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    widget.codi_clothes[idx].brandname,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    widget.codi_clothes[idx].clothname,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.codi_clothes[idx].price.toString() + "원",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      disabledColor: Colors.black,
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          '상품 구매하기',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
