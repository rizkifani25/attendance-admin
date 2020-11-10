part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthEvent {}

class UserLoggedIn extends AuthEvent {
  final Admin admin;

  UserLoggedIn({@required this.admin});

  @override
  List<Object> get props => [admin];
}

class UserLoggedOut extends AuthEvent {}
