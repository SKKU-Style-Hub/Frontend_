import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stylehub_flutter/data/ProductClothing.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetail extends StatefulWidget {
  ProductClothing product;

  ProductDetail({this.product}) {}
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  void goToUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(width: 1, color: Colors.black26),
          ),
          height: 420,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 225,
                  child: widget.product.encoded_img.contains('.')
                      ? Image.asset(
                          widget.product.encoded_img,
                          fit: BoxFit.fill,
                        )
                      : Image.memory(
                          base64Decode(widget.product.encoded_img),
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.product.brand,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                widget.product.name,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.product.price + "원",
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
                  onPressed: () {
                    print(widget.product.detail_url);
                    goToUrl(widget.product.detail_url);
                  },
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
        ),
      ),
    );
  }
}
