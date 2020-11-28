import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/ui/logic/bloc/student/student_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StudentAddNew extends StatefulWidget {
  @override
  _StudentAddNewState createState() => _StudentAddNewState();
}

class _StudentAddNewState extends State<StudentAddNew> {
  final _formKey = GlobalKey<FormState>();
  String _selectedMajor;

  final studentIdInputController = TextEditingController();
  final studentNameInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final batchInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedMajor = 'Information Technology';
  }

  @override
  void dispose() {
    studentIdInputController.dispose();
    studentNameInputController.dispose();
    passwordInputController.dispose();
    batchInputController.dispose();
    super.dispose();
  }

  _handleAddNewStudent() {
    if (studentIdInputController.text != '' &&
        studentNameInputController.text != '' &&
        passwordInputController.text != '' &&
        batchInputController.text != '' &&
        _selectedMajor != '') {
      BlocProvider.of<StudentBloc>(context).add(
        AddNewStudentWithForm(
          studentId: studentIdInputController.text,
          studentName: studentNameInputController.text,
          password: passwordInputController.text,
          batch: batchInputController.text,
          major: _selectedMajor,
        ),
      );
    } else {
      Fluttertoast.showToast(
        webBgColor: "linear-gradient(to right, #c62828, #d32f2f)",
        msg: 'All fields must not blank',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: redColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is StudentAddNewFailed) {
          Fluttertoast.showToast(
            webBgColor: "linear-gradient(to right, #c62828, #d32f2f)",
            msg: state.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: redColor,
            textColor: Colors.white,
            fontSize: 16.0,
          ).then((value) => BlocProvider.of<StudentBloc>(context).add(GetStudentAddNewPageData()));
        }
        if (state is StudentAddNewSuccess) {
          Fluttertoast.showToast(
            webBgColor: "linear-gradient(to right, #2e7d32, #388e3c)",
            msg: state.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: greenColor,
            textColor: Colors.white,
            fontSize: 16.0,
          ).then((value) => BlocProvider.of<StudentBloc>(context).add(GetStudentAddNewPageData()));
        }
        return Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Center(
                child: Text(
                  'Add New Student',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Form(
              key: _formKey,
              child: Container(
                constraints: BoxConstraints(maxWidth: 450),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: studentIdInputController,
                        decoration: InputDecoration(
                          labelText: 'Student ID',
                          hintText: '001201700038',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: studentNameInputController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Muhammad Rizki Fani',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: passwordInputController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Password',
                        ),
                        obscureText: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: batchInputController,
                        decoration: InputDecoration(
                          labelText: 'Batch',
                          hintText: '2017',
                        ),
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
                              child: BlocBuilder<StudentBloc, StudentState>(
                                builder: (context, state) {
                                  if (state is StudentAddNewPageLoadData) {
                                    return DropdownButton(
                                      hint: Text('Select Major'),
                                      value: _selectedMajor,
                                      items: state.listMajor.map((e) {
                                        return DropdownMenuItem(
                                          child: Text(e.major),
                                          value: e.major,
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedMajor = value;
                                        });
                                      },
                                    );
                                  }

                                  return Center(
                                    child: Container(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  );
                                },
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
                            _handleAddNewStudent();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
