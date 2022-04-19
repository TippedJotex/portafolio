part of 'mensaje_bloc.dart';

abstract class MensajeEvent extends Equatable {
  const MensajeEvent();

  @override
  List<Object> get props => [];
}

class TipoMensajeEvent extends MensajeEvent {
  final String Mensaje;
  const TipoMensajeEvent({this.Mensaje});
  @override
  List<Object> get props => [Mensaje];
}

class EnvioMensajeEvent extends MensajeEvent {
  final String Mensaje;
  const EnvioMensajeEvent({this.Mensaje});
  @override
  List<Object> get props => [Mensaje];
}
