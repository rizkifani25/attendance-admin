import 'dart:convert';

import 'package:attendance_admin/components/Toast.dart';
import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/models/BasicResponseModel.dart';
import 'package:attendance_admin/models/MajorModel.dart';
import 'package:attendance_admin/models/StudentModel.dart';
import 'package:attendance_admin/screen/StudentScreen/StudentScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentAddNew extends StatefulWidget {
  @override
  _StudentAddNewState createState() => _StudentAddNewState();
}

class _StudentAddNewState extends State<StudentAddNew> {
  final _formKey = GlobalKey<FormState>();
  List<MajorModel> majorlist = MajorModel.getMajor();
  List<DropdownMenuItem<MajorModel>> dropDownMenuItems;
  MajorModel selectedMajorState;
  ToastComponents toastComponents;
  FToast fToast;

  final studentIdInputController = TextEditingController();
  final studentNameInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final batchInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dropDownMenuItems = buildDropdownMenuItems(majorlist);
    selectedMajorState = dropDownMenuItems[1].value;
    fToast = FToast();
    fToast.init(context);
    toastComponents = ToastComponents(fToast: fToast);
  }

  List<DropdownMenuItem<MajorModel>> buildDropdownMenuItems(List majorList) {
    List<DropdownMenuItem<MajorModel>> major = List();
    for (MajorModel majorModel in majorList) {
      major.add(
        DropdownMenuItem(
          value: majorModel,
          child: Text(majorModel.major),
        ),
      );
    }
    return major;
  }

  fetchingAddNewStudent(
    String studentId,
    String studentName,
    String password,
    String batch,
    String major,
  ) async {
    try {
      StudentModel studentData = new StudentModel();
      studentData.student_id = studentId;
      studentData.student_name = studentName;
      studentData.password = password;
      studentData.batch = batch;
      studentData.major = major;
      studentData.additional_data = {'status': 'Ungraduated'};

      var response = await http.post(
        apiURL + '/student/register',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(studentData),
      );

      var resp = BasicResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print(resp.responseCode.toString() + ' :: ' + resp.responseMessage);
        resp.responseCode == 200
            ? toastComponents.showToast(resp.responseCode.toString(), resp.responseMessage)
            : toastComponents.showToast(resp.responseCode.toString(), resp.responseMessage);
      } else {
        print(response.body);
        toastComponents.showToast(resp.responseCode.toString(), resp.responseMessage);
      }
    } catch (e) {
      print(e.toString());
      toastComponents.showToast(
        '400',
        'Not connected to servers',
      );
    }
  }

  handleChangeDropdownItem(MajorModel selectedMajor) {
    setState(() {
      selectedMajorState = selectedMajor;
    });
  }

  handleSubmitForm() {
    if (studentIdInputController.text.toString() != '' &&
        studentNameInputController.text.toString() != '' &&
        passwordInputController.text.toString() != '' &&
        batchInputController.text.toString() != '' &&
        selectedMajorState.major.toString() != '') {
      fetchingAddNewStudent(
        studentIdInputController.text.toString(),
        studentNameInputController.text.toString(),
        passwordInputController.text.toString(),
        batchInputController.text.toString(),
        selectedMajorState.major.toString(),
      );
    } else {
      toastComponents.showToast(
        '400',
        'Field cannot be empty',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 640.0,
      child: Column(
        children: <Widget>[
          Container(
            child: Center(
              child: Text(
                'Add New Student',
                style: TextStyle(color: primaryColor),
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: studentIdInputController,
                    decoration: InputDecoration(hintText: 'Student Id'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: studentNameInputController,
                    decoration: InputDecoration(hintText: 'Student Name'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: passwordInputController,
                    decoration: InputDecoration(hintText: 'Password'),
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: batchInputController,
                    decoration: InputDecoration(hintText: 'Batch'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Major',
                            style: TextStyle(color: greyColor2),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DropdownButton(
                            value: selectedMajorState,
                            items: dropDownMenuItems,
                            onChanged: handleChangeDropdownItem,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: greenColor,
                    child: Text(
                      'Add New',
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        handleSubmitForm();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
