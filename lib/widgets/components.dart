import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// this file contains different widget components to aid builder method

void showErrorToast(String label) {
  Fluttertoast.showToast(
      msg: label, backgroundColor: Colors.red, gravity: ToastGravity.CENTER);
}

showToast(String label) {
  Fluttertoast.showToast(
    msg: label,
    backgroundColor: Colors.green,
    gravity: ToastGravity.CENTER,
  );
}

Color pColor = const Color(0xff4cbb17);

Widget loader = Center(
  child: CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(pColor),
  ),
);
