import 'package:dataclass/dataclass.dart';

@dataClass
class Clothing {
  final int index_num;
  final String product_id;
  final String product_name;
  final String brand;
  final String brand_product_Id;
  final String sex;
  final String superCategory;
  final String midCategory;
  final String category;
  final String color;
  final String color_detail;
  final String pattern;
  final String pattern_detail;
  final String material;
  final String model_img;
  final String price;
  final String product_link;
  final String product_img;
  final String style;
  final String fit;
  final String mall;
  final String tag;
  final int is_wear;
  final int is_recommend;

  Clothing({
    this.index_num,
    this.product_id,
    this.product_name,
    this.brand,
    this.brand_product_Id,
    this.sex,
    this.superCategory,
    this.midCategory,
    this.category,
    this.color,
    this.color_detail,
    this.pattern,
    this.pattern_detail,
    this.material,
    this.model_img,
    this.price,
    this.product_link,
    this.product_img,
    this.style,
    this.fit,
    this.mall,
    this.tag,
    this.is_wear,
    this.is_recommend,
  });
}
