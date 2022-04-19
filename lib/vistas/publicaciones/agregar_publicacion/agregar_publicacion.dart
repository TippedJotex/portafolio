// ignore_for_file: unused_field, unused_local_variable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tesis/bloc/post_bloc/post_bloc.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/vistas/publicaciones/agregar_publicacion/form_agregar_publicacion.dart';

class AgregarPublicacion extends StatelessWidget {
  final Database _userRepository;
  const AgregarPublicacion({Key key, Database userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.grey.withOpacity(0.888888),
        appBar: _appBar(context),
        body: BlocProvider<RegistroPublicacionBloc>(
          create: (context) =>
              RegistroPublicacionBloc(databaseRepository: _userRepository),
          child: _fondo(context),
        )
      );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('Crear Publicacion'),
      backgroundColor: const Color.fromRGBO(34, 214, 148, 0.5),
    );
  }

  Widget _fondo(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(34, 214, 148, 0.6),
        Color.fromRGBO(34, 214, 148, 0.6)
      ])),
      child: ListView(
        children: [_LogoImagen(context), _subFondo(context)],
      ),
    );
  }

  Widget _LogoImagen(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        child: Image.asset(
          'assets/agregar_publicacion.png',
          alignment: Alignment.topCenter,
          //color: Color.fromRGBO(34, 214, 148, 0.6),
          height: 120,
        ),
      ),
    );
  }

  Widget _subFondo(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              //const SizedBox(height: 150),
              //_inputFondo(context),
              const RegistroPublicacion(),
              //_formulario(context)
            ],
          )),
    );
  }
/*
  Widget _tipoPublicacion(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(15)
        ),
        child: DropdownButton(
          hint: Text('Tipo Publicacion'),
          value: valuePublicacion,
          dropdownColor: Colors.white,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 36,
          underline: SizedBox(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          onChanged: (value) {
            setState(() {
              valuePublicacion = value;
            });
          },
          items: publicaciones.map((listado) {
            return DropdownMenuItem(
              value: listado,
              child: Text(listado),
            );
          }).toList(),
        ),
      ),
    );
    */
  /*
    return const TextField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: 'tipo de publicacion'
      ),
    );
    */
}

  /*
  Widget _inputFondo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: 450,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 15, offset: Offset(0, 2))
            ],
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(213, 223, 240, 0.6),
              Color.fromRGBO(197, 227, 217, 0.6)
            ])),
      ),
    );
  }
  */
