import 'package:flutter/material.dart';

class NotificationSnackBar {
  final String message;
  final Color color;

  NotificationSnackBar({this.message, this.color});

  SnackBar createSnackBar() {
    return SnackBar(
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      content: Text(message),
    );
  }
}
