// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tesis/bloc/actualizacion_bloc/bloc/actualizacion_bloc.dart';
import 'package:tesis/bloc/autenticacion_bloc/bloc/autenticacion_bloc.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/widget/animacion_carga.dart';

class FormEditarCorreo extends StatefulWidget {
  final Database _userRepository;
  const FormEditarCorreo({Key key, Database userRepository})
      : _userRepository = userRepository,
        super(key: key);
  @override
  State<FormEditarCorreo> createState() => _EditarCorreo();
}

class _EditarCorreo extends State<FormEditarCorreo> {
  //Variables
  final TextEditingController _texto = TextEditingController();
  bool get isPopulated => _texto.text.isNotEmpty;
  bool isButtonEnabled(ActualizacionState state) {
    return isPopulated && !state.Envio;
  }

  ActualizacionBloc _actualizacionBloc;

  @override
  void initState() {
    super.initState();
    _actualizacionBloc = BlocProvider.of<ActualizacionBloc>(context);
    _texto.addListener(_textoChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActualizacionBloc, ActualizacionState>(
      listener: (context, state) {
        if (state.Falla) {
          Animacion().AnimacionFallaRegistro(context);
        }
        if (state.Envio) {
          Animacion().AnimacionEnvioRegistro(context);
        }
      },
      child: BlocBuilder<ActualizacionBloc, ActualizacionState>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              obtenerDato(context),
              const SizedBox(height: 45),
              text(context),
              _textCorreo(context, state),
              const SizedBox(height: 20),
              _botonEnviarActualizacion(context, state)
            ],
          );
        },
      ),
    );
  }

  Widget _textCorreo(BuildContext context, state) {
    return TextFormField(
      controller: _texto,
      autocorrect: false,
      autovalidateMode: AutovalidateMode.always,
      validator: (_) {
        return !state.Texto ? 'email debe tener @example.com' : null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          icon: Icon(Icons.email),
          hintText: 'Ingrese nuevo correo electronico',
          hintStyle: TextStyle(color: Colors.black)),
    );
  }

  Widget _botonEnviarActualizacion(BuildContext context, state) {
    return MaterialButton(
      onPressed: () async {
        var result, documents, a;
        Database().documents = a;
        Database().snapshot = result;
        Database().documentSnapshot = documents;
        String correo = Database().firebase.currentUser.email;
        result = await Database()
            .databaseFirestore
            .where('correo', isEqualTo: _texto.text)
            .limit(1)
            .get();
        a = result.docs;
        //Database().documents = Database().snapshot.docs;
        if (isButtonEnabled(state)) {
          if (_texto.text == correo) {
            print('CORREO EN USO');
            Animacion().AnimacionActualizacionFallida(context);
          } else {
            print('CORREO DISPONIBLE PARA ACTUALIZAR');
            //_enviarFormulario();
            if (a.length > 0) {
              print('YA EXISTE');
              Animacion().AnimacionActualizacionFallida(context);
            } else {
              //si no existe comienza la segunda validacion
              print('NO EXISTE');
              Animacion().AnimacionActualizacionCompletado(context);
              _enviarFormulario();
              _enviarFormulario2();
              await Future.delayed(const Duration(milliseconds: 500));
              Navigator.pop(context);
            }
          }
        } else {
          _mostrarAlerta(context);
        }
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const StadiumBorder(),
      color: Colors.green,
      child: const Text('Enviar'),
    );
  }

  Widget text(BuildContext context) {
    return const Text(
      'Ingrese su nuevo correo electronico:',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  @override
  void dispose() {
    _texto.dispose();
    super.dispose();
  }

  void _textoChange() {
    _actualizacionBloc.add(DatoTextoCorreo(texto: _texto.text));
  }

  void _enviarFormulario() {
    Database().ActualizarPerfilCorreoAuth(_texto.text);
  }

  void _enviarFormulario2() {
    Database().ActualizarPerfilCorreo(_texto.text);
  }

  // void _enviarFormulario2() {
  //   _actualizacionBloc.add(EnviarDatoCorreo(texto: _texto.text));
  // }

  void _mostrarAlerta(BuildContext context) {
    showDialog(
        context: context,
        //el barrierdismissible lo idela es dejarlo true en caso de no tener botones dentro de la alerta, en caso contrario false
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: const Text('Error actualizacion de dato'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                const Text('complete las cadenas de entrada'),
                const Icon(Icons.report_gmailerrorred, size: 100.0)
                //FlutterLogo(size: 100.0)
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget obtenerDato(BuildContext context) {
    return StreamBuilder(
      stream: Database()
          .databaseFirestore
          .doc(Database().firebase.currentUser.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('entro al error para capturar el dato');
          return const Text('Ocurrio un error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('cargando dato');
          return const CircularProgressIndicator();
        }
        var documento = snapshot.data;
        print('capture los datos');
        const CircularProgressIndicator();
        return RichText(
          text: TextSpan(
              text: 'El correo de usuario ',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: '${documento['correo']}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.green)),
                const TextSpan(
                    text: ' sera actualizado por ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black)),
                TextSpan(
                    text: _texto.text,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.green))
              ]),
        );
      },
    );
  }
}
