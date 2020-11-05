import 'package:attendance_admin/constant/Constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastComponents {
  final FToast fToast;

  ToastComponents({this.fToast});

  showToast(String code, String message) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 12.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: code != '200' ? redColor : greenColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.info_rounded,
            color: secondaryColor,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            message,
            style: TextStyle(color: secondaryColor),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}
