import 'package:attendance_admin/constant/Constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastNotification {
  showToast({String message, Color color}) {
    Fluttertoast.showToast(
      webBgColor: (color == greenColor) ? "linear-gradient(to right, #2e7d32, #388e3c)" : "linear-gradient(to right, #c62828, #d32f2f)",
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: color ?? greenColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
