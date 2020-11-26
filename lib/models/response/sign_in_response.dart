import 'package:firebase_auth/firebase_auth.dart';

class SignInResponse {
  final User user;
  final String message;

  SignInResponse({this.user, this.message});
}
