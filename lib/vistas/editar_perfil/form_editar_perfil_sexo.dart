import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tesis/bloc/actualizacion_bloc/bloc/actualizacion_bloc.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/widget/animacion_carga.dart';

class FormEditarSexo extends StatefulWidget {
  const FormEditarSexo({Key key}) : super(key: key);

  @override
  State<FormEditarSexo> createState() => _EditarSexo();
}

class _EditarSexo extends State<FormEditarSexo> {
//Variables
  String _actualizacionSexo;
  List<String> lista = ['Hombre', 'Mujer', 'Otro'];
  bool get isPopulated => _actualizacionSexo != null;
  bool isButtonEnabled(ActualizacionState state) {
    return isPopulated && !state.Envio;
  }

  ActualizacionBloc _actualizacionBloc;

  @override
  void initState() {
    super.initState();
    _actualizacionBloc = BlocProvider.of<ActualizacionBloc>(context);
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
              _tipoSexo(context, state),
              const SizedBox(height: 20),
              _botonEnviarActualizacion(context, state)
            ],
          );
        },
      ),
    );
  }

  Widget _tipoSexo(BuildContext context, state) {
    return Row(
      children: <Widget>[
        Image.asset(
          'assets/seleccion.png',
          height: 25,
          color: Colors.black54,
        ),
        const SizedBox(width: 15.0),
        Expanded(
          child: DropdownButtonFormField(
            hint: const Text(
              'tipo de sexo',
              style: TextStyle(color: Colors.black),
            ),
            value: _actualizacionSexo,
            autovalidateMode: AutovalidateMode.always,
            dropdownColor: Colors.white,
            //isExpanded: false,
            //underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 30,
            style: const TextStyle(color: Colors.black, fontSize: 18),
            validator: (_) {
              return !state.Texto ? 'la entrada no debe estar vacia' : null;
            },
            onChanged: (item) {
              setState(() {
                _actualizacionSexo = item;
                //print(_opcionLista);
                _actualizacionBloc
                    .add(DatoTexto(texto: _actualizacionSexo.toString()));
                print(_actualizacionBloc);
              });
            },
            items: lista.map((listado) {
              return DropdownMenuItem(
                value: listado,
                child: Text(listado),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  //poner mejor un list
  Widget _botonEnviarActualizacion(BuildContext context, state) {
    return MaterialButton(
      onPressed: () async {
        if (isButtonEnabled(state)) {
          _enviarFormulario();
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
      'Ingrese su nuevo sexo de usuario:',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
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
              text: 'El sexo ',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: '${documento['sexo']}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.green)),
                const TextSpan(
                    text: ' del usuario sera actualizado por ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black)),
                TextSpan(
                    text: _actualizacionSexo.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.green))
              ]),
        );
      },
    );
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

  @override
  void dispose() {
    super.dispose();
  }

  void _enviarFormulario() {
    Database().ActualizarPerfilSexo(_actualizacionSexo.toString());
  }
}
