part of 'autenticacion_bloc.dart';

abstract class AutenticacionState extends Equatable {
  const AutenticacionState();

  @override
  List<Object> get props => [];
}

//estructura inicial el cual da comienzo al patron bloc
class AutenticacionInitial extends AutenticacionState {}

//Estado en caso de que se completa el inicio de sesion con la base de datos firebase
class AutenticacionCompletada extends AutenticacionState {
  final User usuario;

  const AutenticacionCompletada(this.usuario);

  @override
  List<Object> get props => [usuario];
}

//Estado en caso de que no se completa el inicio de sesion con la base de datos firebase
class AutenticacionFallida extends AutenticacionState {}
