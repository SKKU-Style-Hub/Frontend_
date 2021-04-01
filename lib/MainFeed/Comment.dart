class Comment {
  Comment({this.userNickname, this.userProfileImg, this.commentContent});

  String userNickname;
  String userProfileImg;
  String commentContent;
}

class Like {
  UserProfile userProfile;
}

class UserProfile {
  String userNickname;
  String userProfileImg;
  String gender;
}

class Content {
  List<String> postImage;
  int generalPostId;
  String _id;
  String postContent;
}

class Post {
  List<Comment> comments;
  List<Like> likes;
  int feedId;
  String _id;
  String contentType;
  UserProfile userProfile;
}
