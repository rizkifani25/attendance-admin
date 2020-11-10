import 'dart:async';

import 'package:attendance_admin/data/repositories/attendanceRepository.dart';
import 'package:attendance_admin/ui/logic/bloc/auth/auth_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AttendanceRepository attendanceRepository;
  final AuthBloc authBloc;

  LoginBloc({this.attendanceRepository, this.authBloc}) : super(LoginInitial());

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
      final admin = await attendanceRepository.getLoginInfo(event.username, event.password);
      if (admin != null) {
        authBloc.add(UserLoggedIn(admin: admin));
        yield LoginSuccess();
      } else {
        yield LoginFailure(error: 'Something very weird just happened');
      }
    } catch (e) {
      yield LoginFailure(error: 'An unknown error occurred when login');
    }
  }
}
