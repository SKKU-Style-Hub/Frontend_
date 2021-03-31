class CodiClick {
  //모든 순서는 1:top, 2:bottom, 3: onepiece, 4:outer, 5:shoes, 6:bag
  //클릭했는지를 알려줌. 1이면 클릭 0이면 클릭x
  List<dynamic> clickint = [0, 0, 0, 0, 0, 0, 0];
  CodiClick(
      {int outer, int top, int bag, int shoes, int bottom, int onepiece}) {
    clickint[1] = top;
    clickint[2] = bottom;
    clickint[3] = onepiece;
    clickint[4] = outer;
    clickint[5] = shoes;
    clickint[6] = bag;
  }
  void FocusOnThis(int index)
  //index는 1이면 top.. 임을 나타냄. 입력 받은 애에 focus를 주고 나머지는 포커스 해제해야함.
  {
    clickint = [0, 0, 0, 0, 0, 0, 0];
    clickint[index] = 1; //클릭한 애만 클릭했다고 알려주기
  }
}

//stylingfeed에서 각 옷마다 style.buy.wish정보를 담고 있는 것
class ClothSbw {
  String style_path;
  String style_name;
  String buy_path;
  String buy_name;
  String wish_path;
  String wish_name;
  ClothSbw(
      {this.buy_name,
      this.buy_path,
      this.style_name,
      this.style_path,
      this.wish_name,
      this.wish_path}) {}
}

class ProposedCodiElement {
  ClothSbw clothSbw; //현재는 안 씀
  double xCoordinate, yCoordinate;
  int price;
  String brandName, link;
  ProposedCodiElement(
      {this.clothSbw,
      this.xCoordinate,
      this.yCoordinate,
      this.price,
      this.brandName,
      this.link}) {}
}

class ProposedCodi {
  ClothSbw selectedClothSbw;
  CodiClick codiClick;
  List<dynamic> clothList = [null, null, null, null, null, null, null];
  String codiImage; //이미지path
  ProposedCodi(
      {ProposedCodiElement top,
      ProposedCodiElement bottom,
      ProposedCodiElement onepiece,
      ProposedCodiElement outer,
      ProposedCodiElement shoes,
      ProposedCodiElement bag,
      this.codiImage,
      this.selectedClothSbw}) {
    clothList[1] = top;
    clothList[2] = bottom;
    clothList[3] = onepiece;
    clothList[4] = outer;
    clothList[5] = shoes;
    clothList[6] = bag;
    codiClick = new CodiClick();
  }
}

class AllProposedCodi {
  String requestClothingImg; //요청한 옷 사진
  List<dynamic> proposedCodiList;
  String userId, explanation;
  String userProfile; //유저 프로필사진
  AllProposedCodi(
      {this.proposedCodiList,
      this.userId,
      this.explanation,
      this.requestClothingImg,
      this.userProfile}) {}
}
