class ImageInfo {
  String id;
  String name;
}

class GenderInfo {
  String id;
  String name;
}

class Objects {
  String type;
  List<Tag> tags;
}

class Category {
  String id;
  String name;
}

class Position {
  double x;
  double y;
}

class Item {
  String id;
  String name;
  double confidence;
}

class ColorDetails {
  String code;
  String name;
  double pixelFracton;
}

class Tag {
  Category category;
  Position position;
  int pairIndex;
  Item item;
  List<Item> colors;
  List<ColorDetails> colorDetails;
  List<Item> prints;
  List<Item> looks;
  List<Item> textures;
  Item length;
  Item sleeveLength;
  Item neckLine;
  Item fit;
  Item shape;
  Item heelHeight;
  Item toeType;
  Item heelShape;
  Item soletype;
}

class Error {
  int code;
  String message;
}
