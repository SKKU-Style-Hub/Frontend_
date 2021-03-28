import 'package:fluttertoast/fluttertoast.dart';

void showToast(String info) {
  Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
}
