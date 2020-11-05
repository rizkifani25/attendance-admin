import 'package:attendance_admin/models/StudentModel.dart';
import 'package:attendance_admin/screen/LoginScreen/LoginScreen.dart';
import 'package:attendance_admin/screen/StudentScreen/StudentDataTable.dart';
import 'package:attendance_admin/screen/StudentScreen/StudentDetail.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentScreen extends StatefulWidget {
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  String username;
  StudentModel studentModel;
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

  callback(studentModel) {
    setState(() {
      this.studentModel = studentModel;
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
            child: StudentDataTable(callback),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: 370.0,
            child: Card(
              elevation: 5.5,
              child: ShowStudentDetail(
                studentModel: this.studentModel,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
