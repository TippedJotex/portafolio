// ignore_for_file: non_constant_identifier_names

part of 'registro_bloc.dart';

class RegistroState {
  final bool EmailValido;
  final bool PasswordValido;
  final bool Nombre;
  final bool FechaNacimiento;
  final bool TipoSexo;
  final bool Envio;
  final bool Completado;
  final bool Falla;

  RegistroState(
      {this.EmailValido,
      this.PasswordValido,
      this.Nombre,
      this.FechaNacimiento,
      this.TipoSexo,
      this.Envio,
      this.Completado,
      this.Falla});

  //bool get FormularioValido =>
      //EmailValido && PasswordValido && Nombre && FechaNacimiento && TipoSexo;

  factory RegistroState.initial() {
    return RegistroState(
        EmailValido: true,
        PasswordValido: true,
        Nombre: true,
        FechaNacimiento: true,
        TipoSexo: true,
        Envio: false,
        Completado: false,
        Falla: false);
  }

  factory RegistroState.carga() {
    return RegistroState(
        EmailValido: true,
        PasswordValido: true,
        Nombre: true,
        FechaNacimiento: true,
        TipoSexo: true,
        Envio: true,
        Completado: false,
        Falla: false);
  }

  factory RegistroState.falla() {
    return RegistroState(
        EmailValido: true,
        PasswordValido: true,
        Nombre: true,
        FechaNacimiento: true,
        TipoSexo: true,
        Envio: false,
        Completado: false,
        Falla: true);
  }

  factory RegistroState.completado() {
    return RegistroState(
        EmailValido: true,
        PasswordValido: true,
        Nombre: true,
        FechaNacimiento: true,
        TipoSexo: true,
        Envio: false,
        Completado: true,
        Falla: false);
  }

  RegistroState actualizacion({bool EmailValido}) {
    return Copiar(
        EmailValido: EmailValido,
        PasswordValido: PasswordValido,
        Nombre: Nombre,
        FechaNacimiento: FechaNacimiento,
        TipoSexo: TipoSexo,
        Envio: false,
        Completado: false,
        Falla: false);
  }

  RegistroState actualizacion2({bool PasswordValido}) {
    return Copiar(
      EmailValido: EmailValido,
      PasswordValido: PasswordValido,
      Nombre: Nombre,
      FechaNacimiento: FechaNacimiento,
      TipoSexo: TipoSexo,
      Envio: false,
      Completado: false,
      Falla: false,
    );
  }

  RegistroState actualizacion3({bool Nombre}) {
    return Copiar(
        EmailValido: EmailValido,
        PasswordValido: PasswordValido,
        Nombre: Nombre,
        FechaNacimiento: FechaNacimiento,
        TipoSexo: TipoSexo,
        Envio: false,
        Completado: false,
        Falla: false);
  }

  RegistroState actualizacion4({bool FechaNacimiento}) {
    return Copiar(
        EmailValido: EmailValido,
        PasswordValido: PasswordValido,
        Nombre: Nombre,
        FechaNacimiento: FechaNacimiento,
        TipoSexo: TipoSexo,
        Envio: false,
        Completado: false,
        Falla: false);
  }

  RegistroState actualizacion5({bool TipoSexo}) {
    return Copiar(
        EmailValido: EmailValido,
        PasswordValido: PasswordValido,
        Nombre: Nombre,
        FechaNacimiento: FechaNacimiento,
        TipoSexo: TipoSexo,
        Envio: false,
        Completado: false,
        Falla: false);
  }

  RegistroState Copiar(
      {bool EmailValido,
      bool PasswordValido,
      bool Nombre,
      bool FechaNacimiento,
      bool TipoSexo,
      bool Envio,
      bool Completado,
      bool Falla}) {
    return RegistroState(
      EmailValido: EmailValido,
      PasswordValido: PasswordValido,
      Nombre: Nombre,
      FechaNacimiento: FechaNacimiento,
      TipoSexo: TipoSexo,
      Envio: Envio,
      Completado: Completado,
      Falla: Falla,
    );
  }

  @override
  // ignore: override_on_non_overriding_member
  List<Object> get props => [];
}

/*
class RegistroInitial extends RegistroState {}

// ignore: must_be_immutable
class RegistrarseState extends RegistroState {
  User user;
  RegistrarseState({this.user});
}

class EstadoDeAutenticacion extends RegistroState {}

*/








/*
class Validadores extends RegistroState{
  //variables de la clase persona
  //a utilizar para enviar el formulario.
  final String nombrePersona;
  final String fechaNacimiento;
  final String correoElectronico;
  final String passPersona;

  const Validadores(
      {this.nombrePersona = '',
      this.fechaNacimiento = '',
      this.correoElectronico = '',
      this.passPersona = ''});

  //metodo para validar que la contraseña sea mayor a 6 caracteres

}
*/


/*

@immutable
abstract class RegistroState {
  //descomentar despues, esto es un hermoso constructor.
  /*
  final String nombrePersona;
  final String fechaNacimiento;
  final String correoElectronico;
  final String passPersona;

  RegistroState(this.nombrePersona, this.fechaNacimiento, this.correoElectronico, this.passPersona);*/
}




*/