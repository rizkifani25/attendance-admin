import 'dart:async';

import 'package:attendance_admin/data/repositories/repositories.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:attendance_admin/ui/logic/bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AdminRepository adminRepository;
  final AuthBloc authBloc;

  LoginBloc({this.adminRepository, this.authBloc}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginAdminWithUsername) {
      yield* _mapLoginAdminWithUsername(event);
    }
  }

  Stream<LoginState> _mapLoginAdminWithUsername(LoginAdminWithUsername event) async* {
    yield LoginLoading();

    try {
      SignInResponse signInResponse = await adminRepository.signIn(event.admin);
      if (signInResponse.message.toLowerCase() == 'login success') {
        authBloc.add(UserLoggedIn(adminEmail: 'admin@president.ac.id'));
        yield LoginSuccess();
      } else {
        yield LoginFailure(
          message: signInResponse.message.replaceAll(new RegExp(r'[\(\[].*?[\)\]]'), ''),
        );
      }
    } catch (e) {
      print(e.toString());
      yield LoginFailure(message: 'An unknown error occurred when login');
    }
  }
}
