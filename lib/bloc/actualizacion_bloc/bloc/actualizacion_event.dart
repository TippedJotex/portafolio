part of 'actualizacion_bloc.dart';

abstract class ActualizacionEvent extends Equatable {
  const ActualizacionEvent();

  @override
  List<Object> get props => [];
}

class DatoTexto extends ActualizacionEvent {
  final String texto;
  const DatoTexto({this.texto});

  @override
  List<Object> get props => [texto];
}

class DatoTextoCorreo extends ActualizacionEvent {
  final String texto;
  const DatoTextoCorreo({this.texto});

  @override
  List<Object> get props => [texto];
}

class DatoTextoContrasena extends ActualizacionEvent {
  final String texto;
  const DatoTextoContrasena({this.texto});

  @override
  List<Object> get props => [texto];
}

class EnviarDatoCorreo extends ActualizacionEvent {
  final String texto;
  const EnviarDatoCorreo({this.texto});

  @override
  List<Object> get props => [texto];
}

class EnviarDatoContrasena extends ActualizacionEvent {
  final String texto;
  const EnviarDatoContrasena({this.texto});

  @override
  List<Object> get props => [texto];
}

class EnviarDatoNombre extends ActualizacionEvent {
  final String texto;
  const EnviarDatoNombre({this.texto});

  @override
  List<Object> get props => [texto];
}

class EnviarDatoSexo extends ActualizacionEvent {
  final String texto;
  const EnviarDatoSexo({this.texto});

  @override
  List<Object> get props => [texto];
}