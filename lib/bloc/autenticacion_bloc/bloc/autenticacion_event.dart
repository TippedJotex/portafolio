part of 'autenticacion_bloc.dart';

abstract class AutenticacionEvent extends Equatable {
  const AutenticacionEvent();

  @override
  List<Object> get props => [];
}

class AutenticacionComenzada extends AutenticacionEvent{}

class AutenticacionIngresoSesion extends AutenticacionEvent{}

class AutenticacionSalidaSesion extends AutenticacionEvent{}