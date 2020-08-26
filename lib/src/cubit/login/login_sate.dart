import 'package:equatable/equatable.dart';
import 'package:medico_app/src/model/login_response.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginStateInitial extends LoginState {}

class LoginStateInProgress extends LoginState {}

class LoginStateFailure extends LoginState {
  LoginStateFailure({this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class LoginSuccessWithNoData extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccessWithData extends LoginState {
  final LoginResponse loginResponse;
  const LoginSuccessWithData(this.loginResponse);
  @override
  List<Object> get props => [loginResponse];
}
