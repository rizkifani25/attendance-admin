import 'package:attendance_admin/constant/Constant.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:attendance_admin/ui/logic/bloc/bloc.dart';
import 'package:attendance_admin/ui/view/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: _SignInForm(),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _handleLoginButton() {
    Admin _admin = new Admin();
    _admin.email = _usernameController.text.toString();
    _admin.password = _passwordController.text.toString();

    if (_key.currentState.validate()) {
      BlocProvider.of<LoginBloc>(context).add(LoginAdminWithUsername(admin: _admin));
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          return ToastNotification().showToast(message: state.message, color: redColor);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state is LoginLoading) {
          return WidgetLoadingIndicator(color: primaryColor);
        }

        return Card(
          elevation: 5.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Container(
            height: 300,
            width: 300,
            padding: EdgeInsets.all(20),
            child: Form(
              key: _key,
              autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset(
                        'icon/calendar.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          'Admin Attendance App',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      controller: _usernameController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (value) {
                        if (value == null) {
                          return 'Email is required.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null) {
                          return 'Password is required.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    RaisedButton(
                      color: primaryColor,
                      textColor: textColor,
                      padding: const EdgeInsets.all(20),
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
                      child: Text('LOG IN'),
                      onPressed: () => _handleLoginButton(),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
