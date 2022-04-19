// ignore_for_file: non_constant_identifier_names, missing_return

import 'package:flutter/material.dart';

class Animacion {
  Widget AnimacionCargaLoginFallido(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Flexible(
              child: Text('Login Fallida'),
            ),
            Icon(Icons.error),
          ],
        ),
        backgroundColor: Color(0xffffae88),
      ),
    );
  }

  Widget AnimacionCargaCompletadaLogin(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 500),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Flexible(
              child: Text('Iniciando Sesion'),
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          ],
        ),
        backgroundColor: Color(0xffffae88),
      ),
    );
  }

  Widget AnimacionFallaRegistro(context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          Flexible(child: Text('Registro fallido')),
          Icon(Icons.error),
        ],
      ),
      backgroundColor: const Color(0xffffae88),
    ));
  }

  Widget AnimacionEnvioRegistro(context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1500),
      content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Flexible(
              child: Text('Registrandose'),
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          ]),
      backgroundColor: const Color(0xffffae88),
    ));
  }

  Widget AnimacionRegistrandoPublicacion(context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(milliseconds: 2000),
      content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Flexible(
              child: Text('Registrando Publicacion'),
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          ]),
      backgroundColor: const Color(0xffffae88),
    ));
    //sleep(const Duration(seconds: 1));
    //Navigator.pop(context);
  }

  Widget AnimacionActualizacionCompletado(context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1500),
      content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Flexible(
              child: Text('Actualizacion Completada',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
            ),
            Icon(Icons.check_circle_outline_sharp)
          ]),
      //backgroundColor: const Color(0xffffae88),
    ));
    //sleep(const Duration(seconds: 1));
    //Navigator.pop(context);
  }

  Widget AnimacionActualizacionFallida(context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1500),
      content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Flexible(
              child: Text('correo electronico en uso',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
            ),
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 30,
            )
          ]),
      //backgroundColor: const Color(0xffffae88),
    ));
    //sleep(const Duration(seconds: 1));
    //Navigator.pop(context);
  }

  Widget AnimacionActualizacionFallida2(context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1500),
      content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Flexible(
              child: Text('la contraseña no debe ser la misma',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
            ),
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 30,
            )
          ]),
      //backgroundColor: const Color(0xffffae88),
    ));
    //sleep(const Duration(seconds: 1));
    //Navigator.pop(context);
  }

  Widget AnimacionActualizacionFallida3(context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1500),
      content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Flexible(
                child: Text('la contraseña debe ser a lo mas 6 caracteres',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15))),
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 30,
            )
          ]),
      //backgroundColor: const Color(0xffffae88),
    ));
    //sleep(const Duration(seconds: 1));
    //Navigator.pop(context);
  }

  Widget SeleccioneImagen(context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1500),
      content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Flexible(
              child: Text('Debe subir al menos 1 imagen',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
            ),
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 30,
            )
          ]),
      //backgroundColor: const Color(0xffffae88),
    ));
    //sleep(const Duration(seconds: 1));
    //Navigator.pop(context);
  }

  Widget errorMensaje(context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1500),
      content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Flexible(
              child: Text('No puedes mandarte mensajes a ti mismo...',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
            ),
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 30,
            )
          ]),
      //backgroundColor: const Color(0xffffae88),
    ));
    //sleep(const Duration(seconds: 1));
    //Navigator.pop(context);
  }

  Widget errorMensaje2(context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1500),
      content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Flexible(
              child: Text('No puedes mandar un mensaje vacio...',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
            ),
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 30,
            )
          ]),
      //backgroundColor: const Color(0xffffae88),
    ));
    //sleep(const Duration(seconds: 1));
    //Navigator.pop(context);
  }

  Widget agregarReporte(context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1500),
      content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Flexible(
              child: Text('Publicacion reportada...',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
            ),
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 30,
            )
          ]),
      //backgroundColor: const Color(0xffffae88),
    ));
    //sleep(const Duration(seconds: 1));
    //Navigator.pop(context);
  }
}
