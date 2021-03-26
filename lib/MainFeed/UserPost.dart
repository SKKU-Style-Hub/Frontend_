import 'package:flutter/material.dart';

class UserPost extends StatefulWidget {
  String userNickname;
  String userProfileImg;
  UserPost({String userNickname, String userProfileImg}) {
    this.userNickname = userNickname;
    this.userProfileImg = userProfileImg;
  }

  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: Colors.black,
      elevation: 7,
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(widget.userProfileImg),
          )
        ],
      ),
    );
  }
}
