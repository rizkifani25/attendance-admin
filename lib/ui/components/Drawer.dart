import 'package:attendance_admin/constant/Constant.dart';
import 'package:flutter/material.dart';

class DrawerComponents extends StatefulWidget {
  @override
  _DrawerComponentsState createState() => _DrawerComponentsState();
}

class _DrawerComponentsState extends State<DrawerComponents> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          // selected: widget.tabController.index == 0 ? true : false,
          selectedTileColor: selectedColor,
          leading: Icon(
            Icons.home_rounded,
            // color: widget.tabController.index == 0 ? primaryColor : iconUnselectedColor,
          ),
          title: Text(
            'Room',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          onTap: () {
            // widget.tabController.animateTo(0);
            // widget.drawerStatus ? Navigator.pop(context) : print("");
          },
        ),
        // ListTile(
        //   selected: widget.tabController.index == 1 ? true : false,
        //   selectedTileColor: selectedColor,
        //   leading: Icon(
        //     Icons.account_circle_rounded,
        //     color: widget.tabController.index == 1 ? primaryColor : iconUnselectedColor,
        //   ),
        //   title: Text(
        //     'Student',
        //     style: TextStyle(
        //       fontSize: 18,
        //     ),
        //   ),
        //   onTap: () {
        //     widget.tabController.animateTo(1);
        //     widget.drawerStatus ? Navigator.pop(context) : print("");
        //   },
        // ),
        // ListTile(
        //   selected: widget.tabController.index == 2 ? true : false,
        //   selectedTileColor: selectedColor,
        //   leading: Icon(
        //     Icons.content_paste_rounded,
        //     color: widget.tabController.index == 2 ? primaryColor : iconUnselectedColor,
        //   ),
        //   title: Text(
        //     'Room',
        //     style: TextStyle(
        //       fontSize: 18,
        //     ),
        //   ),
        //   onTap: () {
        //     widget.tabController.animateTo(2);
        //     widget.drawerStatus ? Navigator.pop(context) : print("");
        //   },
        // ),
      ],
    );
  }
}
