import 'dart:async';

import 'package:attendance_admin/data/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AdminRepository adminRepository;

  AuthBloc({this.adminRepository}) : super(AuthInitial());

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
      final String currentAdminEmail = await adminRepository.getCurrentSignInInfo();

      if (currentAdminEmail != null) {
        yield AuthAuthenticated(adminEmail: currentAdminEmail);
      } else {
        yield AuthNotAuthenticated();
      }
    } catch (e) {
      yield AuthFailure(message: 'An unknown error occurred when auth');
      yield AuthNotAuthenticated();
    }
  }

  Stream<AuthState> _mapUserLoggedInToState(UserLoggedIn event) async* {
    yield AuthAuthenticated(adminEmail: event.adminEmail);
  }

  Stream<AuthState> _mapUserLoggedOutToState(UserLoggedOut event) async* {
    // await adminRepository.logOutAdmin();
    yield AuthNotAuthenticated();
  }
}
