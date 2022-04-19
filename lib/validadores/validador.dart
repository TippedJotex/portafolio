// ignore_for_file: non_constant_identifier_names

class Validators {
  static ValidacionContrasena(String password) {
    return (password != null && password.length >= 6);
  }

  static EntradaVacia(String value) {
    return (value.isNotEmpty);
  }

  static ValidarTitulo(String titulo) {
    return (titulo != null && titulo.length <= 50);
  }

  static ValidarDescripcion(String desc) {
    return (desc != null && desc.length <= 200);
  }

  static ListaNull(String value) {
    return (value != null && value.length >= 2);
  }

  static ValidacionCorreo(String correo) {
    RegExp expresion = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return expresion.hasMatch(correo);
  }
}
