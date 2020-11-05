import 'package:attendance_admin/screen/DashboardScreen/DashboardScreen.dart';
import 'package:attendance_admin/screen/HomeScreen/HomeScreen.dart';
import 'package:attendance_admin/screen/LoginScreen/LoginScreen.dart';
import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/screen/RoomScreen/RoomScreen.dart';
import 'package:attendance_admin/screen/StudentScreen/StudentScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      title: 'Attendance App',
      theme: ThemeData(
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => HomeScreen(),
        loginScreen: (BuildContext context) => LoginScreen(),
        dashboardScreen: (BuildContext context) => DashboardScreen(),
        roomScreen: (BuildContext context) => RoomScreen(),
        studentScreen: (BuildContext context) => StudentScreen()
      },
    );
  }
}
