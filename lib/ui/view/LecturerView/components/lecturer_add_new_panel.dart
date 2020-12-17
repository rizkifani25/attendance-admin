import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/ui/logic/bloc/lecturer/lecturer_bloc.dart';
import 'package:attendance_admin/ui/view/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LecturerAddnew extends StatefulWidget {
  @override
  _LecturerAddnewState createState() => _LecturerAddnewState();
}

class _LecturerAddnewState extends State<LecturerAddnew> {
  final _formKey = GlobalKey<FormState>();

  final lecturerEmailInputController = TextEditingController();
  final lecturerNameInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    lecturerEmailInputController.dispose();
    lecturerNameInputController.dispose();
    passwordInputController.dispose();
    super.dispose();
  }

  _handleAddNewLecturer() {
    if (lecturerEmailInputController.text != '' && lecturerNameInputController.text != '' && passwordInputController.text != '') {
      BlocProvider.of<LecturerBloc>(context).add(
        AddNewLecturerWithForm(
          lecturerEmail: lecturerEmailInputController.text,
          lecturerName: lecturerNameInputController.text,
          password: passwordInputController.text,
        ),
      );
    } else {
      ToastNotification().showToast(message: 'All fields must not blank', color: redColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LecturerBloc, LecturerState>(
      builder: (context, state) {
        if (state is LecturerAddNewFailed) {
          ToastNotification().showToast(message: state.message, color: redColor);
        }
        if (state is LecturerAddNewSuccess) {
          ToastNotification().showToast(message: state.message, color: greenColor);
        }
        return Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Center(
                child: Text(
                  'Add New Lecturer',
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
                        keyboardType: TextInputType.emailAddress,
                        controller: lecturerEmailInputController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'fani@president.ac.id',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: lecturerNameInputController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Rizki Fani',
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
                            _handleAddNewLecturer();
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
