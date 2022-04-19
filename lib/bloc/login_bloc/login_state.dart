// ignore_for_file: non_constant_identifier_names

part of 'login_bloc.dart';

class LoginState {
  final bool EmailValido;
  final bool PasswordValido;
  final bool Envio;
  final bool Completado;
  final bool Falla;

  LoginState(
      {this.EmailValido,
      this.PasswordValido,
      this.Envio,
      this.Completado,
      this.Falla});

  bool get FormularioValido => EmailValido && PasswordValido;
  

  factory LoginState.initial() {
    return LoginState(
        EmailValido: true,
        PasswordValido: true,
        Envio: false,
        Completado: false,
        Falla: false);
  }

  factory LoginState.carga() {
    return LoginState(
        EmailValido: true,
        PasswordValido: true,
        Envio: true,
        Completado: false,
        Falla: false);
  }

  factory LoginState.falla() {
    return LoginState(
        EmailValido: true,
        PasswordValido: true,
        Envio: false,
        Completado: false,
        Falla: true);
  }

  factory LoginState.completado() {
    return LoginState(
        EmailValido: true,
        PasswordValido: true,
        Envio: false,
        Completado: true,
        Falla: false);
  }
/*
  LoginState actualizacion({bool EmailValido, bool PasswordValido}) {
    return Copiar(
      EmailValido: EmailValido,
      PasswordValido: PasswordValido,
      Envio: false,
      Completado: false,
      Falla: false,
    );
  }
  */

  LoginState actualizacion2({bool EmailValido}) {
    return Copiar(
      EmailValido: EmailValido,
      PasswordValido: PasswordValido,
      Envio: false,
      Completado: false,
      Falla: false,
    );
  }

  LoginState actualizacion3({bool PasswordValido}) {
    return Copiar(
      EmailValido: EmailValido,
      PasswordValido: PasswordValido,
      Envio: false,
      Completado: false,
      Falla: false,
    );
  }

  LoginState Copiar(
      {bool EmailValido,
      bool PasswordValido,
      bool Envio,
      bool Completado,
      bool Falla}) {
    return LoginState(
        EmailValido: EmailValido,
        PasswordValido: PasswordValido,
        Envio: Envio,
        Completado: Completado,
        Falla: Falla,);
  }
}



/*
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class CargaLogin extends LoginState {}

class LoginCompletado extends LoginState {
  User user;
  LoginCompletado({required this.user});
}

class FallaLogin extends LoginState {
  String frase;
  FallaLogin({required this.frase});
}
*/