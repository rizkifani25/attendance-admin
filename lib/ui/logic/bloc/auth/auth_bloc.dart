import 'dart:async';

import 'package:attendance_admin/data/repositories/repositories.dart';
import 'package:attendance_admin/models/admin.dart';
import 'package:attendance_admin/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AttendanceRepository attendanceRepository;

  AuthBloc({@required this.attendanceRepository}) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState(event);
    }

    if (event is UserLoggedIn) {
      yield* _mapUserLoggedInToState(event);
    }

    if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState(event);
    }
  }

  Stream<AuthState> _mapAppLoadedToState(AppLoaded event) async* {
    yield AuthLoading();
    try {
      final Admin currentAdmin = await attendanceRepository.getCurrentLoginInfo();
      if (currentAdmin != null) {
        yield AuthAuthenticated(admin: currentAdmin);
      } else {
        yield AuthNotAuthenticated();
      }
    } catch (e) {
      yield AuthFailure(message: e ?? 'An unknown error occurred when auth');
    }
  }

  Stream<AuthState> _mapUserLoggedInToState(UserLoggedIn event) async* {
    yield AuthAuthenticated(admin: event.admin);
  }

  Stream<AuthState> _mapUserLoggedOutToState(UserLoggedOut event) async* {
    await attendanceRepository.logOutAdmin();
    yield AuthNotAuthenticated();
  }
}
