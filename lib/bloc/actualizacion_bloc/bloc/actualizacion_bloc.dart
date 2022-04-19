// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/validadores/validador.dart';

part 'actualizacion_event.dart';
part 'actualizacion_state.dart';

class ActualizacionBloc extends Bloc<ActualizacionEvent, ActualizacionState> {
  final Database _db;
  ActualizacionBloc({Database dbRepository})
      : _db = Database(),
        super(ActualizacionState.initial());

  @override
  Stream<ActualizacionState> mapEventToState(ActualizacionEvent event) async* {
    if (event is DatoTexto) {
      yield* _mapDatoTexto(event.texto);
    } else if (event is DatoTextoCorreo) {
      yield* _mapDatoTextoCorreo(event.texto);
    } else if (event is DatoTextoContrasena) {
      yield* _mapDatoTextoContrasena(event.texto);
    } else if (event is EnviarDatoCorreo) {
      yield* _mapEnviarDatoCorreo(event.texto);
    } else if (event is EnviarDatoContrasena) {
      yield* _mapEnviarDatoContrasena(event.texto);
    } else if (event is EnviarDatoNombre) {
      yield* _mapEnviarDatoNombre(event.texto);
    } else if (event is EnviarDatoSexo) {
      yield* _mapEnviarDatoSexo(event.texto);
    }
  }

  Stream<ActualizacionState> _mapDatoTexto(String texto) async* {
    yield state.DatoTexto(Texto: Validators.EntradaVacia(texto));
  }

  Stream<ActualizacionState> _mapDatoTextoCorreo(String texto) async* {
    yield state.DatoTexto(Texto: Validators.ValidacionCorreo(texto));
  }

  Stream<ActualizacionState> _mapDatoTextoContrasena(String texto) async* {
    yield state.DatoTexto(Texto: Validators.ValidacionContrasena(texto));
  }

  Stream<ActualizacionState> _mapEnviarDatoCorreo(String texto) async* {
    yield ActualizacionState.carga();
    try {
      await _db.ActualizarPerfilCorreoAuth(texto);
      await _db.ActualizarPerfilCorreo(texto);
    } catch (e) {
      print('Ocurrio un error para actualizar el correo');
      print(e);
    }
  }

  Stream<ActualizacionState> _mapEnviarDatoContrasena(String texto) async* {
    yield ActualizacionState.carga();
    try {
      await _db.ActualizarPerfilContrasenaAuth(texto);
      await _db.ActualizarPerfilContrasena(texto);
    } catch (e) {
      print('Ocurrio un error para actualizar password');
      print(e);
    }
  }

  Stream<ActualizacionState> _mapEnviarDatoNombre(String texto) async* {
    yield ActualizacionState.carga();
    try {
      await _db.ActualizarPerfilNombre(texto);
    } catch (e) {
      print('Ocurrio un error para actualizar el nombre');
      print(e);
    }
  }

  Stream<ActualizacionState> _mapEnviarDatoSexo(String texto) async* {
    yield ActualizacionState.carga();
    try {
      await _db.ActualizarPerfilSexo(texto);
    } catch (e) {
      print('Ocurrio un error para actualizar el sexo');
      print(e);
    }
  }
}
