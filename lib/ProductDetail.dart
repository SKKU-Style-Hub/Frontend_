import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylehub_flutter/Constants.dart';

class ProductDetail extends StatefulWidget {
  String imagepath;
  String brandname;
  String name;
  int price;
  ProductDetail({String imagepath, String brandname, String name, int price}) {
    this.imagepath = imagepath;
    this.brandname = brandname;
    this.name = name;
    this.price = price;
  }
  _ProductDetailState createState() {
    return _ProductDetailState();
  }
}

//사진, 브랜드이름. 이름. 가격 받아오자. + 구매하기 버튼 만들기
class _ProductDetailState extends State<ProductDetail> {
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              height: 170,
              child: Image.asset(
                widget.imagepath,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            widget.brandname,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            widget.name,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.price.toString() + "원",
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
  }
}
