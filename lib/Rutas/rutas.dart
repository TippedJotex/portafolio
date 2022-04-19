import 'package:flutter/material.dart';
import 'package:tesis/vistas/publicaciones/menu_publicacion/menu_publicaciones.dart';
import 'package:tesis/vistas/registro/menu_registro.dart';

Map <String, WidgetBuilder> getAplicacionRutas(){

  return <String, WidgetBuilder>{
    
    //'login'     : (BuildContext context) => MenuLogin(userRepository: UserRepository,),
    'registro'  : (BuildContext context) => const MenuRegistro(),
    //'ingresar'  : (BuildContext context) => const Publicaciones()
    'menu/publicacion': (BuildContext context) => const Publicaciones()
  };
}
