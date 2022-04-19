import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tesis/bloc/registro_bloc/registro_bloc.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/vistas/registro/registro_formulario.dart';

class MenuRegistro extends StatelessWidget {
  final Database _userRepository;
  const MenuRegistro(
      {Key key, Database userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      body: BlocProvider<RegistroBloc>(
        create: (context) => RegistroBloc(databaseRepository: _userRepository),
        child: _Fondo(context),
      ),
    );
  }

  //widget para el fondo
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

  //widget para poner una imagen en el menu
  Widget _LogoImagen(BuildContext context) {
    return SafeArea(
      child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 20),
          child: Icon(
            Icons.person,
            size: 120,
            //color: Colors.blueGrey,
            color: Colors.grey.shade900,
          )),
    );
  }

  Widget _SubFondo(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 210),
          _FondoSubFondo(context),
          const SizedBox(height: 30),
          //BotonRegistrarse(),
          const SizedBox(height: 10),
          //BotonVolver()
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
        //height: 500,
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
        //aqui va otro child
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              const SizedBox(height: 10),
              //Ver como darle mas estilo al texto
              Text(
                'Registrarse',
                style: Theme.of(context).textTheme.headline4,
                //style: TextStyle(color: Colors.black, fontSize: 26)
              ),
              const SizedBox(height: 25),
              const RegistroFormulario(),
              //const InputNombre(),
              //const SizedBox(height: 25),
              //const InputFechaNacimiento(),
              //const SizedBox(height: 25),
              //const InputEmail(),
              //const SizedBox(height: 30),
              //const InputPassword()
            ],
          ),
        ),
      ),
    );
  }
}