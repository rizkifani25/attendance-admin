part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthEvent {}

class UserLoggedIn extends AuthEvent {
  final String adminEmail;

  UserLoggedIn({@required this.adminEmail});

  @override
  List<Object> get props => [adminEmail];
}

class UserLoggedOut extends AuthEvent {}
