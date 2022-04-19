part of 'registro_bloc.dart';

abstract class RegistroEvent extends Equatable {
  const RegistroEvent();

  @override
  List<Object> get props => [];
}

//aqui poner todas las acciones que se realizar al presionar ya sea un boton o formulario de la vista del celular.

class RegistroEmailEvento extends RegistroEvent {
  final String correo;
  const RegistroEmailEvento({this.correo});

  @override
  List<Object> get props => [correo];
}

class RegistroPasswordEvento extends RegistroEvent {
  final String password;
  const RegistroPasswordEvento({this.password});

  @override
  List<Object> get props => [password];
}

class DatosUsuarioNombre extends RegistroEvent {
  final String nombre;
  const DatosUsuarioNombre({this.nombre});

  @override
  List<Object> get props => [nombre];
}

class DatosUsuarioFecha extends RegistroEvent {
  final String fecha;
  const DatosUsuarioFecha({this.fecha});

  @override
  List<Object> get props => [fecha];
}

class DatosUsuarioSexo extends RegistroEvent {
  final String sexo;
  const DatosUsuarioSexo({this.sexo});

  @override
  List<Object> get props => [sexo];
}

class EnvioRegistro extends RegistroEvent {
  final String correo;
  final String password;
  final String nombre;
  final String fecha;
  final String sexo;
  const EnvioRegistro(
      {this.correo, this.password, this.nombre, this.fecha, this.sexo});

  @override
  List<Object> get props => [correo, password, nombre, fecha, sexo];
}

