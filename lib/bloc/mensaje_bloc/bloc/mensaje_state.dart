part of 'mensaje_bloc.dart';

class MensajeState {
  final bool Mensaje;
  final bool Envio;
  final bool Completado;
  final bool Falla;

  MensajeState({this.Mensaje, this.Envio, this.Completado, this.Falla});

  factory MensajeState.initial() {
    return MensajeState(
        Mensaje: true, Envio: false, Completado: false, Falla: false);
  }

  factory MensajeState.carga() {
    return MensajeState(
        Mensaje: true, Envio: true, Completado: false, Falla: false);
  }

  factory MensajeState.falla() {
    return MensajeState(
        Mensaje: true, Envio: false, Completado: false, Falla: true);
  }

  factory MensajeState.completado() {
    return MensajeState(
        Mensaje: true, Envio: false, Completado: true, Falla: false);
  }

  MensajeState MensajeEvent({bool Mensaje}) {
    return Copiar(
        Mensaje: Mensaje, Envio: false, Completado: false, Falla: false);
  }

  MensajeState Copiar({bool Mensaje, bool Envio, bool Completado, bool Falla}) {
    return MensajeState(
        Mensaje: Mensaje, Envio: Envio, Completado: Completado, Falla: Falla);
  }

  @override
  List<Object> get props => [];
}
