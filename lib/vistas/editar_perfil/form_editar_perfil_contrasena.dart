import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tesis/bloc/actualizacion_bloc/bloc/actualizacion_bloc.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/widget/animacion_carga.dart';

class FormEditarContrasena extends StatefulWidget {
  const FormEditarContrasena({Key key}) : super(key: key);

  @override
  State<FormEditarContrasena> createState() => _EditarContrasena();
}

class _EditarContrasena extends State<FormEditarContrasena> {
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
              texto(context),
              _textNombre(context, state),
              const SizedBox(height: 20),
              _botonEnviarActualizacion(context, state),
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
      obscureText: true,
      validator: (_) {
        return !state.Texto ? 'la contraseña debe tener 6 caracteres' : null;
      },
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          icon: Icon(Icons.lock),
          hintText: 'Ingrese su nueva contraseña',
          hintStyle: TextStyle(color: Colors.black)),
    );
  }

  Widget _botonEnviarActualizacion(BuildContext context, state) {
    return MaterialButton(
      onPressed: () async {
        FirebaseFirestore.instance
            .collection('Usuario')
            .doc(Database().firebase.currentUser.uid)
            .get()
            .then((value) async {
          String password = value.data()['contraseña'];
          print('la contrasena es: ' + password);
          if (isButtonEnabled(state)) {
            if (_texto.text == password) {
              Animacion().AnimacionActualizacionFallida2(context);
            } else {
              if (_texto.text.length >= 6){
                Animacion().AnimacionActualizacionCompletado(context);
              _enviarFormulario();
              _enviarFormulario2();
              await Future.delayed(const Duration(microseconds: 500));
              Navigator.pop(context);
              }
              else{
                Animacion().AnimacionActualizacionFallida3(context);
              }
            }
          } else {
            _mostrarAlerta(context);
          }
        });
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const StadiumBorder(),
      color: Colors.green,
      child: const Text('Enviar'),
    );
  }

  Widget texto(BuildContext context) {
    return const Text(
      'Ingrese su nueva contraseña:',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  @override
  void dispose() {
    _texto.dispose();
    super.dispose();
  }

  void _textoChange() {
    _actualizacionBloc.add(DatoTextoContrasena(texto: _texto.text));
  }

  void _enviarFormulario() {
    Database().ActualizarPerfilContrasenaAuth(_texto.text);
  }

  void _enviarFormulario2() {
    Database().ActualizarPerfilContrasena(_texto.text);
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
}
