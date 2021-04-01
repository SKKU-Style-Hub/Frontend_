import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'GeneratedComponents.dart';
import 'CreatePost.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'PostItem.dart';
import 'StylingCard.dart';
import 'UserPost.dart';

Color notClickedColor = Colors.grey[800]; //선택하지 않은 버튼의 색깔
Color clickedColor = Colors.indigo; //선택된 색깔

class MainFeed extends StatefulWidget {
  @override
  _MainFeedState createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeed> {
  static const _pageSize = 20;
  ScrollController scrollController = ScrollController();
  bool showActionButton = true;
  final _pagingController = PagingController<int, Post>(
    firstPageKey: 0,
  );

  addListener() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          showActionButton = false;
        });
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          showActionButton = true;
        });
      }
    });
  }

  Future<List<Post>> getPosts(int offset, int limit) async {
    String url = "http://34.64.196.105:82/api/mainfeed/list/read";
    List<Post> posts = [];
    var response = await http.post(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({"lastFeedId": offset, "limit": limit}));
    //print(response.body);
    var results = jsonDecode(response.body);
    for (var result in results) {
      Post tmp = Post.fromJson(result);
      posts.add(tmp);
      print(posts.length);
    }
    return posts;
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<Post> newPosts = await getPosts(pageKey, _pageSize);
      //Future<List<Post>>받아오기
      final isLastPage = newPosts.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newPosts);
      } else {
        final nextPageKey = pageKey + newPosts.length;
        _pagingController.appendPage(newPosts, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    addListener();
    return Scaffold(
        floatingActionButton: Visibility(
          visible: showActionButton,
          child: FloatingActionButton(
            child: Icon(Icons.create),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreatePost()));
            },
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => Future.sync(
            () => _pagingController.refresh(),
          ),
          child: PagedListView<int, Post>.separated(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Post>(
              itemBuilder: (context, item, index) => PostItem(
                post: item,
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
          ),
        ));
  }
}
// ListView(
// controller: scrollController,
// children: [
// StylingCard(
// tmpAllCodi: allProposedCodi1,
// isLiked: false,
// ),
// UserPost(
// userNickname: "ddd",
// userProfileImg:
// "https://www.ui4u.go.kr/depart/img/content/sub03/img_con03030100_01.jpg",
// postImgList: [
// "https://image.ajunews.com/content/image/2021/03/05/20210305085249990180.png",
// "https://image.ajunews.com/content/image/2021/03/05/20210305085249990180.png",
// ],
// postContent:
// "ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ",
// comments: [
// Comment(
// userNickname: "eee",
// userProfileImg:
// "https://image.ajunews.com/content/image/2021/03/05/20210305085249990180.png",
// commentContent: "아이유 예쁘다")
// ],
// postTime: DateTime(2021, 3, 29, 17, 30),
// isLiked: false,
// ),
// ],
// ),
