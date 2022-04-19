part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailEvento extends LoginEvent {
  final String correo;
  const LoginEmailEvento({this.correo});

  @override
  List<Object> get props => [correo];
}

class LoginPasswordEvento extends LoginEvent {
  final String password;
  const LoginPasswordEvento({this.password});

  @override
  List<Object> get props => [password];
}

class LoginConCredenciales extends LoginEvent {
  final String correo;
  final String password;
  const LoginConCredenciales({this.correo, this.password});

  @override
  List<Object> get props => [correo, password];

  get email => null; 
}

class LoginFallido extends LoginEvent {
  
}
