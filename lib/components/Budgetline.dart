import 'package:flutter/material.dart';

class Budgetline extends StatefulWidget {
  double highrange;
  Budgetline({Key key, double highrange}) : super(key: key) {
    this.highrange = highrange;
  }
  _BudgetlineState createState() {
    return _BudgetlineState();
  }
}

class _BudgetlineState extends State<Budgetline> {
  String actual_highrange_str;
  Widget build(BuildContext context) {
    if (widget.highrange > 27.5) {
      return Text(
        "무제한",
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      );
    } else {
      actual_highrange_str = (widget.highrange * 10000).toInt().toString();
      actual_highrange_str += " 원";
      return Text(
        actual_highrange_str,
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      );
    }
  }
}
