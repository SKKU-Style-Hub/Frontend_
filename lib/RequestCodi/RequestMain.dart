import 'package:flutter/material.dart';
import 'package:stylehub_flutter/Constants.dart';

class RequestMain extends StatefulWidget {
  @override
  _RequestMainState createState() => _RequestMainState();
}

class _RequestMainState extends State<RequestMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      child: Image.asset('assets/email.png'),
                      height: 80,
                    ),
                    Text('코디 요청 보내기')
                  ],
                ),
              ),
              VerticalDivider(
                thickness: 2,
                color: Colors.black,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      child: Image.asset('assets/mailbox.png'),
                      height: 80,
                    ),
                    Text('코디 결과 확인하기')
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
