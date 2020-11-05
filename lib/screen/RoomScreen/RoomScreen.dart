import 'package:attendance_admin/models/RoomModel.dart';
import 'package:attendance_admin/screen/LoginScreen/LoginScreen.dart';
import 'package:attendance_admin/screen/RoomScreen/RoomDataTable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomScreen extends StatefulWidget {
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  String username;
  RoomModel roomModel;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var pref = sharedPreferences.getString('token');
    if (pref == null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      setState(() {
        username = pref;
      });
    }
  }

  callback(roomModel) {
    setState(() {
      this.roomModel = roomModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: 1024.0,
            child: RoomDataTable(),
          ),
        ],
      ),
    );
  }
}
