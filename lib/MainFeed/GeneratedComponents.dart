class Post {
  List<Comments> comments;
  List<Likes> likes;
  int feedId;
  String sId;
  String contentType;
  UserProfile userProfile;
  Content content;
  String createdAt;
  String updatedAt;

  Post(
      {this.comments,
      this.likes,
      this.feedId,
      this.sId,
      this.contentType,
      this.userProfile,
      this.content,
      this.createdAt,
      this.updatedAt});

  Post.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
    if (json['likes'] != null) {
      likes = new List<Likes>();
      json['likes'].forEach((v) {
        likes.add(new Likes.fromJson(v));
      });
    }
    feedId = json['feedId'];
    sId = json['_id'];
    contentType = json['contentType'];
    userProfile = json['userProfile'] != null
        ? new UserProfile.fromJson(json['userProfile'])
        : null;
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    if (this.likes != null) {
      data['likes'] = this.likes.map((v) => v.toJson()).toList();
    }
    data['feedId'] = this.feedId;
    data['_id'] = this.sId;
    data['contentType'] = this.contentType;
    if (this.userProfile != null) {
      data['userProfile'] = this.userProfile.toJson();
    }
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Likes {
  Likes({this.userProfile});
  UserProfile userProfile;
  Likes.fromJson(Map<String, dynamic> json) {
    userProfile = json['userProfile'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.userProfile != null) {
      data['userProfile'] = this.userProfile.toJson();
    }
    return data;
  }
}

class Comments {
  UserProfile userProfile;
  String commentContent;

  Comments({this.userProfile, this.commentContent});

  Comments.fromJson(Map<String, dynamic> json) {
    userProfile = json['userProfile'] != null
        ? new UserProfile.fromJson(json['userProfile'])
        : null;
    commentContent = json['commentContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userProfile != null) {
      data['userProfile'] = this.userProfile.toJson();
    }
    data['commentContent'] = this.commentContent;
    return data;
  }
}

class UserProfile {
  String userNickname;
  String profileImage;
  String gender;
  int age;

  UserProfile({this.userNickname, this.profileImage, this.gender, this.age});

  UserProfile.fromJson(Map<String, dynamic> json) {
    userNickname = json['userNickname'];
    profileImage = json['profileImage'];
    gender = json['gender'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userNickname'] = this.userNickname;
    data['profileImage'] = this.profileImage;
    data['gender'] = this.gender;
    data['age'] = this.age;
    return data;
  }
}

class Content {
  List<StylingResult> stylingResult;
  int stylingPostId;
  StylingRequest stylingRequest;
  List<String> postImage;
  int generalPostId;
  String sId;
  UserProfile userProfile;
  String postContent;
  String createdAt;
  String updatedAt;

  Content(
      {this.stylingResult,
      this.stylingPostId,
      this.stylingRequest,
      this.postImage,
      this.generalPostId,
      this.sId,
      this.userProfile,
      this.postContent,
      this.createdAt,
      this.updatedAt});

  Content.fromJson(Map<String, dynamic> json) {
    if (json['stylingResult'] != null) {
      stylingResult = new List<StylingResult>();
      json['stylingResult'].forEach((v) {
        stylingResult.add(new StylingResult.fromJson(v));
      });
    }
    stylingPostId = json['stylingPostId'];
    stylingRequest = json['stylingRequest'] != null
        ? new StylingRequest.fromJson(json['stylingRequest'])
        : null;
    postImage = json['postImage'].cast<String>();
    generalPostId = json['generalPostId'];
    sId = json['_id'];
    userProfile = json['userProfile'] != null
        ? new UserProfile.fromJson(json['userProfile'])
        : null;
    postContent = json['postContent'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stylingResult != null) {
      data['stylingResult'] =
          this.stylingResult.map((v) => v.toJson()).toList();
    }
    data['stylingPostId'] = this.stylingPostId;
    if (this.stylingRequest != null) {
      data['stylingRequest'] = this.stylingRequest.toJson();
    }
    data['postImage'] = this.postImage;
    data['generalPostId'] = this.generalPostId;
    data['_id'] = this.sId;
    if (this.userProfile != null) {
      data['userProfile'] = this.userProfile.toJson();
    }
    data['postContent'] = this.postContent;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class StylingResult {
  List<Components> components;
  int stylingResponseId;
  String sId;
  String stylingImage;
  RequestorProfile requestorProfile;
  RequestorProfile stylistProfile;
  String stylingPostId;
  String createdAt;
  String updatedAt;
  int codiClick; //어떤 버튼을 클릭했는지 저장

  StylingResult({
    this.components,
    this.stylingResponseId,
    this.sId,
    this.stylingImage,
    this.requestorProfile,
    this.stylistProfile,
    this.stylingPostId,
    this.createdAt,
    this.updatedAt,
  }) {
    codiClick = 0; //0으로 초기화
  }

  StylingResult.fromJson(Map<String, dynamic> json) {
    if (json['components'] != null) {
      components = new List<Components>();
      json['components'].forEach((v) {
        components.add(new Components.fromJson(v));
      });
    }
    stylingResponseId = json['stylingResponseId'];
    sId = json['_id'];
    stylingImage = json['stylingImage'];
    requestorProfile = json['requestorProfile'] != null
        ? new RequestorProfile.fromJson(json['requestorProfile'])
        : null;
    stylistProfile = json['stylistProfile'] != null
        ? new RequestorProfile.fromJson(json['stylistProfile'])
        : null;
    stylingPostId = json['stylingPostId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.components != null) {
      data['components'] = this.components.map((v) => v.toJson()).toList();
    }
    data['stylingResponseId'] = this.stylingResponseId;
    data['_id'] = this.sId;
    data['stylingImage'] = this.stylingImage;
    if (this.requestorProfile != null) {
      data['requestorProfile'] = this.requestorProfile.toJson();
    }
    if (this.stylistProfile != null) {
      data['stylistProfile'] = this.stylistProfile.toJson();
    }
    data['stylingPostId'] = this.stylingPostId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Components {
  String brand;
  String color;
  double xcordinate;
  double ycordinate;

  Components({this.brand, this.color, this.xcordinate, this.ycordinate});

  Components.fromJson(Map<String, dynamic> json) {
    brand = json['brand'];
    color = json['color'];
    xcordinate = json['xcordinate'];
    ycordinate = json['ycordinate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand'] = this.brand;
    data['color'] = this.color;
    data['xcordinate'] = this.xcordinate;
    data['ycordinate'] = this.ycordinate;
    return data;
  }
}

class RequestorProfile {
  String userNickname;
  String gender;

  RequestorProfile({this.userNickname, this.gender});

  RequestorProfile.fromJson(Map<String, dynamic> json) {
    userNickname = json['userNickname'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userNickname'] = this.userNickname;
    data['gender'] = this.gender;
    return data;
  }
}

class StylingRequest {
  List<RequestClothings> requestClothings;
  List<String> requestItems;
  List<String> requestStyle;
  int stylingRequestId;
  int resultCounter;
  String sId;
  UserProfile userProfile;
  int budgetMin;
  int budgetMax;
  String requestContent;
  String createdAt;
  String updatedAt;

  StylingRequest(
      {this.requestClothings,
      this.requestItems,
      this.requestStyle,
      this.stylingRequestId,
      this.resultCounter,
      this.sId,
      this.userProfile,
      this.budgetMin,
      this.budgetMax,
      this.requestContent,
      this.createdAt,
      this.updatedAt});

  StylingRequest.fromJson(Map<String, dynamic> json) {
    if (json['requestClothings'] != null) {
      requestClothings = new List<RequestClothings>();
      json['requestClothings'].forEach((v) {
        requestClothings.add(new RequestClothings.fromJson(v));
      });
    }
    //requestClothings = json['requestClothings'].cast<String>();
    requestItems = json['requestItems'].cast<String>();
    requestStyle = json['requestStyle'].cast<String>();
    stylingRequestId = json['stylingRequestId'];
    resultCounter = json['resultCounter'];
    sId = json['_id'];
    userProfile = json['userProfile'] != null
        ? new UserProfile.fromJson(json['userProfile'])
        : null;
    budgetMin = json['budgetMin'];
    budgetMax = json['budgetMax'];
    requestContent = json['requestContent'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.requestClothings != null) {
      data['requestClothings'] =
          this.requestClothings.map((v) => v.toJson()).toList();
    }
    //data['requestClothings'] = this.requestClothings;
    data['requestItems'] = this.requestItems;
    data['requestStyle'] = this.requestStyle;
    data['stylingRequestId'] = this.stylingRequestId;
    data['resultCounter'] = this.resultCounter;
    data['_id'] = this.sId;
    if (this.userProfile != null) {
      data['userProfile'] = this.userProfile.toJson();
    }
    data['budgetMin'] = this.budgetMin;
    data['budgetMax'] = this.budgetMax;
    data['requestContent'] = this.requestContent;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class RequestClothings {
  int clothingId;
  String sId;
  UserProfile userProfile;
  TagResult tagResult;
  String clothingImage;
  String createdAt;
  String updatedAt;

  RequestClothings(
      {this.clothingId,
      this.sId,
      this.userProfile,
      this.tagResult,
      this.clothingImage,
      this.createdAt,
      this.updatedAt});

  RequestClothings.fromJson(Map<String, dynamic> json) {
    clothingId = json['clothingId'];
    sId = json['_id'];
    userProfile = json['userProfile'] != null
        ? new UserProfile.fromJson(json['userProfile'])
        : null;
    tagResult = json['tagResult'] != null
        ? new TagResult.fromJson(json['tagResult'])
        : null;
    clothingImage = json['clothingImage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clothingId'] = this.clothingId;
    data['_id'] = this.sId;
    if (this.userProfile != null) {
      data['userProfile'] = this.userProfile.toJson();
    }
    if (this.tagResult != null) {
      data['tagResult'] = this.tagResult.toJson();
    }
    data['clothingImage'] = this.clothingImage;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class TagResult {
  int price;
  String brandName;
  String category;

  TagResult({this.price, this.brandName, this.category});

  TagResult.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    brandName = json['brandName'];
    category = json["category"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['brandName'] = this.brandName;
    data['category'] = this.category;
    return data;
  }
}

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
