import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tesis/bloc/actualizacion_bloc/bloc/actualizacion_bloc.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/vistas/editar_perfil/form_editar_perfil_sexo.dart';

class EditarSexo extends StatelessWidget {
  final Database _userRepository;
  const EditarSexo({Key key, Database userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(context), body: BlocProvider<ActualizacionBloc>(
      create: (context) => ActualizacionBloc(dbRepository: _userRepository),
      child: _fondo(context),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Editar Sexo',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      backgroundColor: Color.fromRGBO(56, 175, 151, 0.8),
    );
  }

  Widget _fondo(BuildContext context){
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(220, 220, 220, 0.9),
        Color.fromRGBO(220, 220, 220, 0.9)
      ])),
      child: ListView(
        children: [_LogoEditarPerfil(context), _subFondo(context)],
      ),
    );
  }

  Widget _LogoEditarPerfil(BuildContext context) {
    return SafeArea(
        child: Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: Image.asset('assets/agregar_publicacion.png',
          alignment: Alignment.topCenter, height: 120),
    ));
  }

  Widget _subFondo(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: SizedBox(
          width: double.infinity,
          child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
              'Bienvenido a la opcion de editar su sexo de usuario.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 45),
              FormEditarSexo()
            ],
          ),
        ),
      ),
    ));
  }
}
