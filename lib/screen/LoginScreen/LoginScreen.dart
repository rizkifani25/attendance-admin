import 'dart:convert';

import 'package:attendance_admin/components/Toast.dart';
import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/screen/HomeScreen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  TextStyle style = TextStyle(fontFamily: 'Roboto', fontSize: 20.0);
  bool _isLoading = false;
  ToastComponents toastComponents;
  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    toastComponents = ToastComponents(fToast: fToast);
  }

  handleLoginButton(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      var response = await http.post(
        apiURL + '/admin/login?username=' + username + '&password=' + password,
      );

      if (response.statusCode == 200) {
        var customResp = jsonDecode(response.body);
        if (customResp['responseCode'].toString() == '200') {
          toastComponents.showToast(
            customResp['responseCode'].toString(),
            customResp['responseMessage'],
          );
          setState(() {
            _isLoading = false;
          });
          sharedPreferences.setString(
            'token',
            customResp['data']['username'],
          );
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen(),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          toastComponents.showToast(
            customResp['responseCode'].toString(),
            customResp['responseMessage'],
          );
        }
      } else {
        print(response.body);
        var customResp = jsonDecode(response.body);
        toastComponents.showToast(
          response.statusCode.toString(),
          customResp['responseMessage'],
        );
        setState(() {
          _isLoading = false;
        });
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
    final emailField = TextField(
      controller: usernameController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Username',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final passwordField = TextField(
      controller: passwordController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          String username = usernameController.text.toString();
          String password = passwordController.text.toString();
          if (username != '' && password != '') {
            handleLoginButton(usernameController.text, passwordController.text);
          } else {
            toastComponents.showToast(
              '400',
              'Field cannot be empty',
            );
          }
        },
        child: Text(
          'Login',
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );

    return Container(
      alignment: Alignment.center,
      child: Card(
        color: secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        elevation: 5.5,
        child: Container(
          height: 450.0,
          width: 450.0,
          child: Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 50.0,
                            child: Image.asset(
                              'icon/calendar.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 45.0),
                          emailField,
                          SizedBox(height: 25.0),
                          passwordField,
                          SizedBox(
                            height: 35.0,
                          ),
                          loginButon,
                          SizedBox(
                            height: 15.0,
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
