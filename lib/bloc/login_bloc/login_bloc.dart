import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/validadores/validador.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Database _userRepository;
  LoginBloc({Database userRepository})
      : _userRepository = Database(),
        super(LoginState.initial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEmailEvento) {
      yield* _mapLoginEmailToState(event.correo);
    } else if (event is LoginPasswordEvento) {
      yield* _mapLoginPasswordToState(event.password);
    } else if (event is LoginConCredenciales) {
      yield* _mapLoginConCredencialesToState(
          event.correo, event.password);
    }
  }

  Stream<LoginState> _mapLoginEmailToState(String correo) async* {
    yield state.actualizacion2(EmailValido: Validators.ValidacionCorreo(correo));
  }

  Stream<LoginState> _mapLoginPasswordToState(String password) async* {
    yield state.actualizacion3(
        PasswordValido: Validators.ValidacionContrasena(password));
  }

  Stream<LoginState> _mapLoginConCredencialesToState(
      String correo, String password) async* {
    yield LoginState.carga();
    try {
      await _userRepository.IniciarSesion(correo, password);
      yield LoginState.completado();
    } catch (error) {
      yield LoginState.falla();
    }
  }
}
