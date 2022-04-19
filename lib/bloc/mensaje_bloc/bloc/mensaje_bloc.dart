import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/validadores/validador.dart';

part 'mensaje_event.dart';
part 'mensaje_state.dart';

class MensajeBloc extends Bloc<MensajeEvent, MensajeState> {
  final Database _database;
  MensajeBloc({Database databaseRepository})
      : _database = databaseRepository,
        super(MensajeState.initial());

  @override
  Stream<MensajeState> mapEventToState(MensajeEvent event) async* {
    if (event is TipoMensajeEvent) {
      yield* _mapTipoMensaje(event.Mensaje);
    } else if (event is EnvioMensajeEvent) {
      yield* _mapEnviarMensaje(event.Mensaje);
    }
  }

  Stream<MensajeState> _mapTipoMensaje(String mensaje) async* {
    yield state.MensajeEvent(Mensaje: Validators.EntradaVacia(mensaje));
  }

  Stream<MensajeState> _mapEnviarMensaje(String mensaje) async* {
    yield MensajeState.carga();
    try {
      print('aqui poner el enviar mensaje a la base de datos');
    } catch (e) {
      print(e);
    }
  }
}
