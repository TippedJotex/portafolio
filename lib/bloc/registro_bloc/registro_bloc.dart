// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/validadores/validador.dart';

part 'registro_event.dart';
part 'registro_state.dart';

class RegistroBloc extends Bloc<RegistroEvent, RegistroState> {
  final Database _database;
  RegistroBloc({Database databaseRepository})
      : _database = databaseRepository,
        super(RegistroState.initial());

  @override
  Stream<RegistroState> mapEventToState(
    RegistroEvent event,
  ) async* {
    if (event is RegistroEmailEvento) {
      yield* _mapRegistroEmail(event.correo);
    } else if (event is RegistroPasswordEvento) {
      yield* _mapRegistroPassword(event.password);
    } else if (event is DatosUsuarioNombre) {
      yield* _mapDatoUsuarioNombre(event.nombre);
    } else if (event is DatosUsuarioFecha) {
      yield* _mapDatoUsuarioFecha(event.fecha);
    } else if (event is DatosUsuarioSexo) {
      yield* _mapDatoUsuarioSexo(event.sexo);
    } else if (event is EnvioRegistro) {
      yield* _mapRegistrarse(
          event.correo, event.password, event.nombre, event.fecha, event.sexo);
    }
  }

  Stream<RegistroState> _mapRegistroEmail(String correo) async* {
    yield state.actualizacion(EmailValido: Validators.ValidacionCorreo(correo));
  }

  Stream<RegistroState> _mapRegistroPassword(String password) async* {
    yield state.actualizacion2(
        PasswordValido: Validators.ValidacionContrasena(password));
  }

  Stream<RegistroState> _mapDatoUsuarioNombre(String nombre) async* {
    yield state.actualizacion3(Nombre: Validators.EntradaVacia(nombre));
  }

  Stream<RegistroState> _mapDatoUsuarioFecha(String fechaNacimiento) async* {
    yield state.actualizacion4(
        FechaNacimiento: Validators.EntradaVacia(fechaNacimiento));
  }

  Stream<RegistroState> _mapDatoUsuarioSexo(String sexo) async* {
    yield state.actualizacion5(TipoSexo: Validators.EntradaVacia(sexo));
  }

  Stream<RegistroState> _mapRegistrarse(String correo, String password,
      String nombre, String fecha, String sexo) async* {
    yield RegistroState.carga();
    try {
      await _database.Registrarse(correo, password);
      await _database.RegistrarUsuario(nombre, fecha, correo, sexo, password);
      await _database.registrarNombre(nombre);
      //await _database.getDatos();
      //await _database.getNombre();
      yield RegistroState.completado();
    } catch (e) {
      print('ERROR DE TIPO: ${e}');
      yield RegistroState.falla();
    }
  }

/*
  Stream<RegistroState> _mapRegistroUsuario(
      String NombreUsuario, String FechaNacimiento) async* {
    yield RegistroState.carga();
    try {
      await _userRepository.RegistrarUsuario(NombreUsuario, FechaNacimiento);
      yield RegistroState.completado();
    } catch (e) {
      print('ERROR DE TIPO: ${e}');
      yield RegistroState.falla();
    }
  }
*/

}
