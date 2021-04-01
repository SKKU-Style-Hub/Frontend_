class Comment {
  Comment({this.userNickname, this.userProfileImg, this.commentContent});

  String userNickname;
  String userProfileImg;
  String commentContent;
}

class Like {
  Like({this.userProfile});
  UserProfile userProfile;
}

class UserProfile {
  UserProfile({this.userNickname, this.userProfileImg, this.gender});
  String userNickname;
  String userProfileImg;
  String gender;

  UserProfile.fromJson(Map<String, dynamic> json)
      : userNickname = json['userNickname'],
        userProfileImg = json['userProfileImg'],
        gender = json['gender'];
}

class Content {
  Content(
      {this.postImage,
      this.generalPostId,
      this.postContent,
      this.stylingRequest,
      this.stylingResult,
      this.stylingPostId});
  List<String> postImage;
  int generalPostId;
  String postContent;

  StylingRequest stylingRequest;
  List<StylingResult> stylingResult;
  int stylingPostId;
}

class StylingComponent {
  //상품 가격, 링크 정보 없음
  StylingComponent(
      {this.clothingImage,
      this.xCoordinate,
      this.yCoordinate,
      this.clothingId});

  String clothingImage;
  double xCoordinate;
  double yCoordinate;
  int clothingId;
}

class StylingRequest {
  StylingRequest(
      {this.requestClothings,
      this.requestItems,
      this.requestStyle,
      this.stylingRequestId,
      this.userProfile,
      this.budgetMin,
      this.budgetMax,
      this.requestContent});

  List<StylingComponent> requestClothings;
  List<String> requestItems;
  List<String> requestStyle;
  int stylingRequestId;
  UserProfile userProfile;
  int budgetMin;
  int budgetMax;
  String requestContent;
}

class StylingResult {
  StylingResult(
      {this.stylingPostId,
      this.requestorProfile,
      this.stylistProfile,
      this.stylingImage,
      this.components,
      this.stylingResponseId});

  String stylingPostId;
  UserProfile requestorProfile;
  UserProfile stylistProfile;
  String stylingImage;
  List<StylingComponent> components;
  int stylingResponseId;
}

class Post {
  Post(
      {this.comments,
      this.likes,
      this.feedId,
      this.contentType,
      this.userProfile,
      this.createdAt});

  List<Comment> comments;
  List<Like> likes;
  int feedId;
  String contentType;
  Content content;
  UserProfile userProfile;
  String createdAt;
}
