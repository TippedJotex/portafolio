import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tesis/bloc/actualizacion_bloc/bloc/actualizacion_bloc.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/widget/animacion_carga.dart';

class FormEditarNombre extends StatefulWidget {
  const FormEditarNombre({Key key}) : super(key: key);
  @override
  State<FormEditarNombre> createState() => _EditarNombre();
}

class _EditarNombre extends State<FormEditarNombre> {
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
              texto(context),
              _textNombre(context, state),
              const SizedBox(height: 20),
              _botonEnviarActualizacion(context, state)
            ],
          );
        },
      ),
    );
  }

  Widget _textNombre(BuildContext context, state) {
    return TextFormField(
      controller: _texto,
      autocorrect: false,
      autovalidateMode: AutovalidateMode.always,
      validator: (_) {
        return !state.Texto
            ? 'si va a actualizar no debe estar este campo vacio'
            : null;
      },
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Ingrese nuevo nombre de usuario',
          hintStyle: TextStyle(color: Colors.black)),
    );
  }

  Widget _botonEnviarActualizacion(BuildContext context, state) {
    return MaterialButton(
      onPressed: () async {
        if (isButtonEnabled(state)) {
          _enviarFormulario2();
          Animacion().AnimacionActualizacionCompletado(context);
          await Future.delayed(const Duration(milliseconds: 500));
          Navigator.pop(context);
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

  Widget texto(BuildContext context) {
    return const Text(
      'Ingrese su nuevo nombre de usuario:',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  Widget obtenerDato(BuildContext context) {
    final FirebaseAuth firebase = FirebaseAuth.instance;
    return StreamBuilder(
      stream: Database().databaseFirestore
          .doc(firebase.currentUser.uid)
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
        String password = snapshot.data['contraseña'];
        print('capture los datos');
        const CircularProgressIndicator();
        return RichText(
          text: TextSpan(
              text: 'El nombre del usuario ',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: '${documento['nombre']}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.green)),
                const TextSpan(
                    text: ' sera reemplazado por ',
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

  @override
  void dispose() {
    _texto.dispose();
    super.dispose();
  }

  void _textoChange() {
    _actualizacionBloc.add(DatoTexto(texto: _texto.text));
  }

  void _enviarFormulario() {
    _actualizacionBloc.add(EnviarDatoNombre(texto: _texto.text));
  }

  void _enviarFormulario2() {
    Database().ActualizarPerfilNombre(_texto.text);
  }

  void _mostrarAlerta(BuildContext context) {
    showDialog(
        context: context,
        //el barrierdismissible lo idela es dejarlo true en caso de no tener botones dentro de la alerta, en caso contrario false
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Error actualizacion de dato'),
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
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
