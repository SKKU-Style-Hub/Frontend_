import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:stylehub_flutter/LoginScreen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
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
                      title: "로그아웃",
                      onPressed: (context) async {
                        try {
                          var code = await UserApi.instance.logout();

                          print(code.toString());
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
