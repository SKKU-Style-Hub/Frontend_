import 'package:flutter/material.dart';
import 'GeneratedComponents.dart';
import 'UserPost.dart';
import 'StylingCard.dart';

class PostItem extends StatefulWidget {
  Post post;
  PostItem({this.post});
  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return widget.post.contentType == 'general'
        ? UserPost(
            userNickname: widget.post.userProfile.userNickname,
            userProfileImg: widget.post.userProfile.profileImage,
            postImgList: widget.post.content.postImage,
            postContent: widget.post.content.postContent,
            comments: widget.post.comments,
            postTime: widget.post.createdAt,
            isLiked: false,
          )
        : Container(
            child: Text(widget.post.userProfile.userNickname),
          );
  }
}
