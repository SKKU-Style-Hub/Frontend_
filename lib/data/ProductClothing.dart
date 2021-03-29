import 'package:dataclass/dataclass.dart';
import 'package:flutter/material.dart';

@dataClass
class ProductClothing {
  int request_num;
  String encoded_img; //base64
  String brand;
  String detail_url;
  String fashion_url;
  String item_url;
  String name;
  String price;
  String score;
  //category
  String category;

  ProductClothing(
      {this.request_num,
      this.encoded_img,
      this.brand,
      this.detail_url,
      this.fashion_url,
      this.item_url,
      this.name,
      this.price,
      this.score,
      this.category});

  Map<String, dynamic> toMap() {
    return {
      'request_num': request_num,
      'encoded_img': encoded_img,
      'brand': brand,
      'detail_url': detail_url,
      'fashion_url': fashion_url,
      'name': name,
      'price': price,
      'score': score,
      'category': category,
    };
  }
}
