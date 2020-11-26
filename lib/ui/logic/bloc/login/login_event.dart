part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginAdminWithUsername extends LoginEvent {
  final Admin admin;

  LoginAdminWithUsername({@required this.admin});

  @override
  List<Object> get props => [admin];
}
