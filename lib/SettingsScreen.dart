import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylehub_flutter/LoginScreen.dart';

class SettingsScreen extends StatefulWidget {
  String nickname = "";
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void getNickname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.nickname = prefs.getString('userNickname');
    });
  }

  void setNickname(String new_nickname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userNickname", new_nickname);
    setState(() {
      widget.nickname = new_nickname;
    });
  }

  @override
  Widget build(BuildContext context) {
    getNickname();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "설정",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 30,
            color: Colors.white,
          ),
          Expanded(
            child: SettingsList(
              backgroundColor: Colors.white,
              sections: [
                SettingsSection(
                  title: "계정",
                  tiles: [
                    SettingsTile(
                      title: "닉네임",
                      subtitle: widget.nickname,
                      leading: Icon(Icons.perm_identity),
                      onPressed: (context) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              final textController = TextEditingController();
                              String new_Nickname;
                              return AlertDialog(
                                title: Text("닉네임 수정"),
                                content: TextField(
                                  onChanged: (value) {
                                    new_Nickname = value;
                                  },
                                  controller: textController,
                                  decoration: InputDecoration(
                                      hintText: widget.nickname),
                                ),
                                actions: [
                                  FlatButton(
                                    child: Text("확인"),
                                    onPressed: () {
                                      setNickname(new_Nickname);
                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                    },
                                  )
                                ],
                              );
                            });
                      },
                    ),
                    SettingsTile(
                      title: "로그아웃",
                      leading: Icon(Icons.exit_to_app),
                      onPressed: (context) async {
                        try {
                          var code = await UserApi.instance.logout();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        } catch (e) {
                          print(e);
                        }
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
