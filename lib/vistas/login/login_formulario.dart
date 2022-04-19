// ignore_for_file: unused_field, non_constant_identifier_names, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tesis/bloc/autenticacion_bloc/bloc/autenticacion_bloc.dart';
import 'package:tesis/bloc/login_bloc/login_bloc.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/widget/animacion_carga.dart';
import 'package:tesis/widget/boton_login.dart';
import 'package:tesis/vistas/registro/menu_registro.dart';
import 'package:tesis/widget/boton_registro.dart';

class LoginFormulario extends StatefulWidget {
  final Database _userRepository;
  const LoginFormulario({Key key, Database userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  State<LoginFormulario> createState() => _LoginFormularioState();
}

class _LoginFormularioState extends State<LoginFormulario> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool get isPopulated => _email.text.isNotEmpty && _password.text.isNotEmpty;

  bool isButtonEnabled(LoginState state) {
    return state.FormularioValido && isPopulated && !state.Envio;
  }

  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _email.addListener(_EmailChange);
    _password.addListener(_PasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.Falla) {
          Animacion().AnimacionCargaLoginFallido(context);
        }
        if (state.Envio) {
          Animacion().AnimacionCargaCompletadaLogin(context);
        }
        if (state.Completado) {
          BlocProvider.of<AutenticacionBloc>(context).add(
            AutenticacionIngresoSesion(),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
              child: Column(
            children: <Widget>[
              //Input para correo electronico
              TextFormField(
                controller: _email,
                autocorrect: false,
                autovalidate: true,
                validator: (_) {
                  return !state.EmailValido
                      ? 'email debe tener @example.com'
                      : null;
                  //return !state.EmailValido ? 'email no valido' : null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'example@example.com',
                    labelText: 'correo electronico'),
              ),
              const SizedBox(height: 25),
              //Input para contraseña
              TextFormField(
                controller: _password,
                autocorrect: false,
                autovalidate: true,
                obscureText: true,
                validator: (_) {
                  return !state.PasswordValido
                      ? 'la contraseña debe tener 6 caracteres'
                      : null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: '******',
                    labelText: 'contraseña'),
              ),
              SizedBox(height: 60),
              //boton para ingresar sesion en el login
              BotonIngresar(onPressed: () {
                if (isButtonEnabled(state)) {
                  _EnvioFormulario();
                } else {
                  print('error');
                  _mostrarAlerta(context);
                }
              }),
              SizedBox(height: 15),
              //Boton para ingresar al menu de registro
              BotonRegistrarse(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return MenuRegistro(userRepository: widget._userRepository);
                }));
              }),
            ],
          ));
        },
      ),
    );
  }

//funciones al momento de presionar el boton de ingresar:

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _EmailChange() {
    _loginBloc.add(LoginEmailEvento(correo: _email.text));
  }

  void _PasswordChange() {
    _loginBloc.add(LoginPasswordEvento(password: _password.text));
  }

  void _EnvioFormulario() {
    _loginBloc.add(
        LoginConCredenciales(correo: _email.text, password: _password.text));
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
            title: Text('Error inicio sesion'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('complete las cadenas de entrada'),
                Icon(Icons.report_gmailerrorred, size: 100.0)
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
