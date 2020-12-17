import 'dart:ui';
import 'package:attendance_admin/constant/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatelessWidget {
  final List<Widget> children;

  CustomDialogBox({this.children});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxHeight: 800, maxWidth: 800, minWidth: 300, minHeight: 300),
              padding: EdgeInsets.only(left: 25, top: 45 + 25.0, right: 25, bottom: 25),
              margin: EdgeInsets.only(top: 45),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: secondaryColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(mainAxisSize: MainAxisSize.min, children: children),
              ),
            ),
            Positioned(
              left: 25,
              right: 25,
              child: CircleAvatar(
                backgroundColor: secondaryColor,
                radius: 45,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  child: Image.asset("icon/calendar.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
