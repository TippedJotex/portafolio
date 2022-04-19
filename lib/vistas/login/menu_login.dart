// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tesis/bloc/login_bloc/login_bloc.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/vistas/login/login_formulario.dart';

class MenuLogin extends StatelessWidget {
  final Database _userRepository;
  const MenuLogin({Key key, Database userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(userRepository: _userRepository),
          child: _Fondo(context)),
      //body: Fondo(),
    );
  }

  //widget de fondo:
  Widget _Fondo(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(34, 214, 148, 0.6),
        Color.fromRGBO(34, 214, 148, 0.6)
      ])),
      child: Stack(
        children: [_LogoImagen(context), _SubFondo(context)],
      ),
    );
  }

  //widget para el logo de imagen:
  Widget _LogoImagen(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: Image.asset(
          'assets/Logo(1).png',
          alignment: Alignment.topCenter,
          color: Colors.indigo[700],
        ),
      ),
    );
  }

  Widget _SubFondo(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 210),
          _FondoSubFondo(context),
          //SizedBox(height: 30),
          //BotonIngresar(), ponerlo mejor en el login_form
          //SizedBox(height: 10),
          //BotonRegistrarse()ponerlo mejor en el login_form
        ],
      ),
    );
  }

  Widget _FondoSubFondo(BuildContext context) {
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
              Color.fromRGBO(197, 227, 217, 0.6),
            ])),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                'Login',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 25),
              LoginFormulario(userRepository: _userRepository)
            ],
          ),
        ),
      ),
    );
  }
}

