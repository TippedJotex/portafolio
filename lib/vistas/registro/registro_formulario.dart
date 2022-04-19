// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, non_constant_identifier_names, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tesis/bloc/autenticacion_bloc/bloc/autenticacion_bloc.dart';
import 'package:tesis/bloc/registro_bloc/registro_bloc.dart';
import 'package:tesis/widget/animacion_carga.dart';
import 'package:tesis/widget/boton_registrar_usuario.dart';
import 'package:tesis/widget/boton_volver.dart';

class RegistroFormulario extends StatefulWidget {
  const RegistroFormulario({Key key}) : super(key: key);

  @override
  _RegistroFormularioState createState() => _RegistroFormularioState();
}

class _RegistroFormularioState extends State<RegistroFormulario> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _fechaNacimiento = TextEditingController();
  //final TextEditingController _seleccion = TextEditingController();
  String _opcionLista; //_opcionLista;

  //Lista de opciones para el tipo de sexo
  List<String> TipoSexo = ['Hombre', 'Mujer', 'Otro'];

  bool get isPopulated =>
      _email.text.isNotEmpty &&
      _password.text.isNotEmpty &&
      _nombre.text.isNotEmpty &&
      _fechaNacimiento.text.isNotEmpty &&
      _opcionLista != null;

  //String get listaVacia => _opcionLista;

  bool isButtonEnabled(RegistroState state) {
    return isPopulated && !state.Envio; //state.FormularioValido
  }

  RegistroBloc _registroBloc;

  @override
  void initState() {
    super.initState();
    _registroBloc = BlocProvider.of<RegistroBloc>(context);
    //_datosUsuariosBloc = BlocProvider.of<DatosUsuariosBloc>(context);
    _email.addListener(_EmailChange);
    _password.addListener(_PasswordChange);
    _nombre.addListener(_NombreChange);
    _fechaNacimiento.addListener(_FechaNacimientoChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistroBloc, RegistroState>(
        listener: (context, state) {
      if (state.Falla) {
        Animacion().AnimacionFallaRegistro(context);
      }
      if (state.Envio) {
        Animacion().AnimacionEnvioRegistro(context);
      }
      if (state.Completado) {
        BlocProvider.of<AutenticacionBloc>(context)
            .add(AutenticacionIngresoSesion());
        Navigator.pop(context);
      }
    }, child: BlocBuilder<RegistroBloc, RegistroState>(
      builder: (context, state) {
        return Form(
            child: Column(
          children: <Widget>[
            //Input para correo
            _Nombre(context, state),
            const SizedBox(height: 25),
            _FechaNacimiento(context, state),
            const SizedBox(
              height: 25,
            ),
            _TipoSexo(context, state),
            const SizedBox(height: 6),
            _CorreoElectronico(context, state),
            const SizedBox(height: 25),
            //Input para la contrasena
            _Contrasena(context, state),
            const SizedBox(height: 38),
            BotonRegistrarUsuario(
              onPressed: () {
                //print(_RegistrarUsuario);
                if (isButtonEnabled(state)) {
                  _EnvioFormulario();
                  print('GENERANDO REGISTRO: ${_EnvioFormulario}}');
                  print(isButtonEnabled(state));
                  //if (isButtonEnabled2(state)) {
                  //_RegistrarUsuarioFirestore();
                  //_RegistrarUsuario();
                  //} else {
                  //  print('OCURRIO UN ERROR INESPERADO');
                  //}
                } else {
                  _mostrarAlerta(context);
                }
              },
            ),
            const SizedBox(height: 15),
            BotonVolver(
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ));
      },
    ));
  }

  //creaciones de widgets
  Widget _CorreoElectronico(BuildContext context, state) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      controller: _email,
      autocorrect: false,
      validator: (_) {
        return !state.EmailValido ? 'email debe tener @example.com' : null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          icon: Icon(Icons.email),
          hintText: 'example@example.com',
          labelText: 'correo electronico',
          hintStyle: TextStyle(color: Colors.black),
          labelStyle: TextStyle(color: Colors.black)),
    );
  }

  Widget _Contrasena(BuildContext context, state) {
    return TextFormField(
      controller: _password,
      autocorrect: false,
      autovalidateMode: AutovalidateMode.always,
      obscureText: true,
      validator: (_) {
        return !state.PasswordValido
            ? 'la contraseña debe tener 6 caracteres'
            : null;
      },
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          icon: Icon(Icons.lock),
          hintText: '******',
          labelText: 'contraseña',
          hintStyle: TextStyle(color: Colors.black),
          labelStyle: TextStyle(color: Colors.black)),
    );
  }

  Widget _Nombre(BuildContext context, state) {
    return TextFormField(
      controller: _nombre,
      autocorrect: false,
      autovalidateMode: AutovalidateMode.always,
      validator: (_) {
        return !state.Nombre ? 'la entrada no debe estar vacia' : null;
      },
      decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Juan Nicolas Andres',
          labelText: 'nombre completo',
          hintStyle: TextStyle(color: Colors.black),
          labelStyle: TextStyle(color: Colors.black)),

      /*
      validator: (nombre) {
        String validador = r'(^[a-zA-Z ]*$)';
        RegExp expresion = RegExp(validador);
        if (nombre.isEmpty) {
          return 'escriba algo';
        } else if (!expresion.hasMatch(nombre)) {
          return 'el nombre debe de ser a-z y A-Z';
        }
      },
      */
    );
  }

  _SelectDate(BuildContext context) async {
    DateTime selectDate = DateTime.now();
    DateTime fecha = await showDatePicker(
        context: context,
        initialDate: selectDate,
        firstDate: DateTime(1900),
        lastDate: selectDate,
        locale: const Locale('es', 'ES'));
    if (selectDate != null) {
      try {
        var userSelectedDate = DateTime(fecha.year, fecha.month, fecha.day);
    var days = DateTime.now().difference(userSelectedDate).inDays;
    var age = days ~/ 360;
    print('edad del usuario: ${age}');
      if (age < 18) {
        _mostrarAlerta2(context);
      }
      else{
        setState(() {
          try {
            selectDate = fecha;
            _fechaNacimiento.text =
                "${selectDate.day}/ ${selectDate.month}/ ${selectDate.year}";
          } catch (error) {
            print('Ocurrio un error: ${error}');
          }
        });
      }
      } catch (e) {
        print(e);
      }
      
    }
  }

  Widget _FechaNacimiento(BuildContext context, state) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      controller: _fechaNacimiento,
      enableInteractiveSelection: false,
      autocorrect: false,
      decoration: const InputDecoration(
          suffixIcon: Icon(Icons.perm_contact_calendar),
          icon: Icon(Icons.calendar_today),
          hintText: '01-01-2021',
          labelText: 'fecha nacimiento',
          hintStyle: TextStyle(color: Colors.black),
          labelStyle: TextStyle(color: Colors.black)),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        _SelectDate(context);
      },
    );
  }

  Widget _TipoSexo(BuildContext context, state) {
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
            value: _opcionLista,
            autovalidateMode: AutovalidateMode.always,
            dropdownColor: Colors.white,
            //isExpanded: false,
            //underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 30,
            style: const TextStyle(color: Colors.black, fontSize: 18),
            validator: (_) {
              return !state.Nombre ? 'la entrada no debe estar vacia' : null;
            },
            onChanged: (item) {
              setState(() {
                _opcionLista = item;
                //print(_opcionLista);
                _registroBloc
                    .add(DatosUsuarioSexo(sexo: _opcionLista.toString()));
                print(_registroBloc);
              });
            },
            items: TipoSexo.map((listado) {
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

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _nombre.dispose();
    _fechaNacimiento.dispose();
    super.dispose();
  }

  void _EmailChange() {
    _registroBloc.add(RegistroEmailEvento(correo: _email.text));
  }

  void _PasswordChange() {
    _registroBloc.add(RegistroPasswordEvento(password: _password.text));
  }

  void _NombreChange() {
    _registroBloc.add(DatosUsuarioNombre(nombre: _nombre.text));
  }

  void _FechaNacimientoChange() {
    _registroBloc.add(DatosUsuarioFecha(fecha: _fechaNacimiento.text));
  }

  void _EnvioFormulario() {
    _registroBloc.add(EnvioRegistro(
        correo: _email.text,
        password: _password.text,
        nombre: _nombre.text,
        fecha: _fechaNacimiento.text,
        sexo: _opcionLista.toString()));
    print('ENVIANDO DATO USUARIO: ${EnvioRegistro()}');
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

  void _mostrarAlerta2(BuildContext context) {
    showDialog(
        context: context,
        //el barrierdismissible lo idela es dejarlo true en caso de no tener botones dentro de la alerta, en caso contrario false
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Usuario menor de 18 años'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                const Text('Debes ser mayor de 18 años.\nReeintentelo...'),
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
