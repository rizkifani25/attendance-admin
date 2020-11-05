import 'dart:convert';

import 'package:attendance_admin/components/Toast.dart';
import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/models/BasicResponseModel.dart';
import 'package:attendance_admin/models/StudentModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class ShowStudentDetail extends StatefulWidget {
  final StudentModel studentModel;

  ShowStudentDetail({this.studentModel});

  @override
  _ShowStudentDetailState createState() => _ShowStudentDetailState();
}

class _ShowStudentDetailState extends State<ShowStudentDetail> {
  ToastComponents toastComponents;
  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    toastComponents = ToastComponents(fToast: fToast);
  }

  showAlertDialog(BuildContext context, String studentId) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text('Continue'),
      onPressed: () {
        handleDeleteButton(studentId);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text('AlertDialog'),
      content: Text('Delete ' + studentId + '?'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  handleDeleteButton(String studentId) async {
    try {
      var params = '/student/delete';
      if (studentId != '') {
        params = '/student/delete?student_id=' + studentId;
      }
      var response = await http.post(apiURL + params);

      if (response.statusCode == 200) {
        var resp = BasicResponseModel.fromJson(jsonDecode(response.body));
        if (resp.responseCode == 200) {
          print(resp.responseCode.toString() + ' :: ' + resp.responseMessage);
          toastComponents.showToast(resp.responseCode.toString(), resp.responseMessage);
        } else {
          print(response.body);
          toastComponents.showToast(resp.responseCode.toString(), resp.responseMessage);
        }
      } else {
        print(response.body);
        toastComponents.showToast('400', 'Delete failed');
      }
    } catch (e) {
      print(e.toString());
      toastComponents.showToast(
        '400',
        'Not connected to servers',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.studentModel == null
        ? Center(
            child: Text('No student selected'),
          )
        : Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 50.0,
                ),
                child: Center(
                  child: CircleAvatar(
                    minRadius: 50.0,
                    maxRadius: 75.0,
                    backgroundImage: NetworkImage('https://via.placeholder.com/140x100'),
                  ),
                ),
              ),
              listDetail('Student ID', widget.studentModel.student_id),
              listDetail('Student Name', widget.studentModel.student_name),
              listDetail('Batch', widget.studentModel.batch.toString()),
              listDetail('Major', widget.studentModel.major),
              listDetail('Additional Data', widget.studentModel.additional_data.toString()),
              Container(
                margin: EdgeInsets.only(
                  top: 20.0,
                ),
                height: 45.0,
                width: 100.0,
                child: Center(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    height: 40.0,
                    color: redColor,
                    textColor: secondaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.delete_rounded,
                          size: 18.0,
                        ),
                        Text(
                          'Delete',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      showAlertDialog(context, widget.studentModel.student_id);
                    },
                  ),
                ),
              ),
            ],
          );
  }

  Widget listDetail(String headString, String contentString, {String studentId}) {
    final headStyle = TextStyle(
      color: primaryColor,
      fontSize: 16.0,
    );

    final contentStyle = TextStyle(
      color: greyColor,
      fontSize: 14.0,
    );

    return Column(
      children: [
        Container(
          width: 350.0,
          margin: EdgeInsets.only(
            top: 50.0,
          ),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(headString, style: headStyle),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(contentString, style: contentStyle),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 15.0,
          ),
          child: Divider(
            color: primaryColor,
            thickness: 1.0,
            indent: 20.0,
            endIndent: 20.0,
          ),
        ),
      ],
    );
  }
}
