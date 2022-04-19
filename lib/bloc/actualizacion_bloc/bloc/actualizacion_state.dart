// ignore_for_file: non_constant_identifier_names

part of 'actualizacion_bloc.dart';

class ActualizacionState {
  bool Texto;
  bool Envio;
  bool Completado;
  bool Falla;

  ActualizacionState({this.Texto, this.Envio, this.Completado, this.Falla});

  factory ActualizacionState.initial() {
    return ActualizacionState(
        Texto: true, Envio: false, Completado: false, Falla: false);
  }

  factory ActualizacionState.carga() {
    return ActualizacionState(
        Texto: true, Envio: true, Completado: false, Falla: false);
  }

  factory ActualizacionState.falla() {
    return ActualizacionState(
        Texto: true, Envio: false, Completado: false, Falla: true);
  }

  factory ActualizacionState.completado() {
    return ActualizacionState(
        Texto: true, Envio: false, Completado: true, Falla: true);
  }

  ActualizacionState DatoTexto({bool Texto}) {
    return Copiar(
      Texto: Texto,
      Envio: false,
      Completado: false,
      Falla: false
    );
  }

  ActualizacionState Copiar({
    bool Texto,
    bool Envio,
    bool Completado,
    bool Falla,
  }) {
    return ActualizacionState(
        Texto: Texto, Envio: Envio, Completado: Completado, Falla: Falla);
  }

  @override
  // ignore: override_on_non_overriding_member
  List<Object> get props => [];
}
