import 'package:attendance_admin/components/Drawer.dart';
import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/screen/DashboardScreen/DashboardScreen.dart';
import 'package:attendance_admin/screen/LoginScreen/LoginScreen.dart';
import 'package:attendance_admin/screen/RoomScreen/RoomScreen.dart';
import 'package:attendance_admin/screen/StudentScreen/StudentScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  SharedPreferences sharedPreferences;
  TabController tabController;
  String username;
  int active = 0;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    tabController = new TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() {
        setState(() {
          active = tabController.index;
        });
      });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: MediaQuery.of(context).size.width < 1300 ? true : false,
        backgroundColor: primaryColor,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 32),
              child: Text(
                'Admin Material',
                style: TextStyle(
                  fontSize: 24,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Container(
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.pop(context);
                sharedPreferences.clear();
                sharedPreferences.commit();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ),
          SizedBox(width: 32),
        ],
      ),
      body: Row(
        children: <Widget>[
          MediaQuery.of(context).size.width < 1300
              ? Container()
              : Card(
                  elevation: 2.0,
                  child: Container(
                    margin: EdgeInsets.all(0),
                    height: MediaQuery.of(context).size.height,
                    width: 300,
                    color: Colors.white,
                    child: DrawerComponents(
                      username: username,
                      tabController: tabController,
                      drawerStatus: false,
                    ),
                  ),
                ),
          Container(
            width: MediaQuery.of(context).size.width < 1300
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width - 310,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                DashboardScreen(),
                StudentScreen(),
                RoomScreen(),
              ],
            ),
          )
        ],
      ),
      drawer: Padding(
        padding: EdgeInsets.only(top: 56),
        child: Drawer(
          child: DrawerComponents(
            username: username,
            tabController: tabController,
            drawerStatus: true,
          ),
        ),
      ),
    );
  }
}
