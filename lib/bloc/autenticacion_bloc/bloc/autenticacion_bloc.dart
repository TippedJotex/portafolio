import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:tesis/servicios/servicio_firebase.dart';

part 'autenticacion_event.dart';
part 'autenticacion_state.dart';

class AutenticacionBloc extends Bloc<AutenticacionEvent, AutenticacionState> {
  final Database _database;
  AutenticacionBloc({Database userRepository})
      : _database = userRepository,
        super(AutenticacionInitial());

  @override
  Stream<AutenticacionState> mapEventToState(AutenticacionEvent event) async* {
    //dando comienzo al bloc
    if (event is AutenticacionComenzada) {
      yield* _mapAutenticacionComenzadaToState();
    } else if (event is AutenticacionIngresoSesion) {
      yield* _mapAutneticacionLoginToState();
    } else if (event is AutenticacionSalidaSesion) {
      yield* _mapAutneticacionSalidaSesionToState();
    }
  }

  Stream<AutenticacionState> _mapAutenticacionComenzadaToState() async* {
    final login = await _database.VerificarSesion();
    if (login) {
      //variable
      final firebaseUser = await _database.getUsuario();
      //final dato = await _database.getNombre();
      //print('DATOS USUARIO: ${firebaseUser}');
      yield AutenticacionCompletada(firebaseUser);
    } else {
      yield AutenticacionFallida();
    }
  }

  Stream<AutenticacionState> _mapAutneticacionLoginToState() async* {
    yield AutenticacionCompletada(await _database.getUsuario());
    //variable
    /*
    User ObtenerUsuario = await _userRepositorio.getUsuario();
    yield AutenticacionCompletada(ObtenerUsuario);
    */
  }

  Stream<AutenticacionState> _mapAutneticacionSalidaSesionToState() async* {
    //variable
    yield AutenticacionFallida();
    _database.SalirSesion();
  }
}
