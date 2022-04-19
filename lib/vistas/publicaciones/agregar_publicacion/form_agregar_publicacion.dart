import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tesis/bloc/autenticacion_bloc/bloc/autenticacion_bloc.dart';
import 'package:tesis/bloc/post_bloc/post_bloc.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/widget/animacion_carga.dart';

class RegistroPublicacion extends StatefulWidget {
  const RegistroPublicacion({Key key}) : super(key: key);

  @override
  _RegistroPublicacion createState() => _RegistroPublicacion();
}

class _RegistroPublicacion extends State<RegistroPublicacion> {
  //variables
  final TextEditingController _tituloPublicacion = TextEditingController();
  final TextEditingController _descripcionPublicacion = TextEditingController();
  String tpublicacion;
  String vacunas;
  String enfermedad;
  String tipoMascota;
  //String seleccionMascota;
  String seleccionRaza;
  //Lista de opciones para la publicacion
  List<String> publicaciones = ['Adopcion', 'Comercializacion'];
  List<String> validar = ['Si', 'No'];
  List<String> validar2 = ['Si', 'No'];
  List<String> mascota = [
    'Perro',
    'Gato',
    'Hámsters',
    'Pájaros',
    'Peces',
    'Otro'
  ];
  List<String> razaPerro = [
    'Yorkie',
    'Akita',
    'Rottweiler',
    'Bulldog',
    'Otra Raza'
  ];
  List<String> razaGato = [
    'Gato Persa',
    'Gato Angora',
    'Gato Siveriano',
    'Gato Siamés',
    'Otra Raza'
  ];
  List<String> razaHamsters = [
    'Hámster Ruso',
    'Hámster De Roborowski',
    'Hámster Sirio O Dorado',
    'Hámster Chino',
    'Otra Raza'
  ];
  List<String> razaPajaros = [
    'Periquitos',
    'Canarios',
    'Cotorras',
    'Cacatúas',
    'Otra Raza'
  ];
  List<String> razaPeces = [
    'Pez Guppy',
    'Pez Tetra Neón',
    'Pez Platy',
    'Pez Cebra',
    'Otra Raza'
  ];
  List<String> razaAnimales = ['Otro Tipo De Raza'];
  List<String> vacia = [];

  bool get isPopulated =>
      _tituloPublicacion.text.isNotEmpty &&
      tipoMascota != null &&
      seleccionRaza != null &&
      vacunas != null &&
      enfermedad != null &&
      tpublicacion != null &&
      _descripcionPublicacion.text.isNotEmpty;

  bool isButtonEnabled(RegistroPublicacionState state) {
    return isPopulated && !state.Envio; //state.FormularioValido
  }

  RegistroPublicacionBloc _registroPublicacionBloc;

  @override
  void initState() {
    super.initState();
    _registroPublicacionBloc =
        BlocProvider.of<RegistroPublicacionBloc>(context);
    _tituloPublicacion.addListener(_tituloChange);
    _descripcionPublicacion.addListener(_descripcionChange);
  }

  File imagen;
  final imagepicker = ImagePicker();

  Future seleccionarImagen() async {
    final seleccionar =
        await imagepicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (seleccionar != null) {
        imagen = File(seleccionar.path);
        print('nombre de la imagen: ' + seleccionar.name);
        print(imagen);
      } else {
        showSnackBar(
            'No se selecciono una imagen', const Duration(milliseconds: 1500));
      }
    });
  }

  showSnackBar(String snackText, Duration duration) {
    final texto = SnackBar(content: Text(snackText), duration: duration);
    ScaffoldMessenger.of(context).showSnackBar(texto);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistroPublicacionBloc, RegistroPublicacionState>(
      listener: (context, state) {
        if (state.Falla) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Error Registro'),
                  const Icon(Icons.error),
                ],
              ),
              backgroundColor: Color(0xffffae88),
            ));
        }
        if (state.Envio) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Registrando Publicacion'),
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ]),
              backgroundColor: const Color(0xffffae88),
            ));
        }
        if (state.Completado) {
          BlocProvider.of<AutenticacionBloc>(context)
              .add(AutenticacionIngresoSesion());
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<RegistroPublicacionBloc, RegistroPublicacionState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(30),
            child: SizedBox(
              width: double.infinity,
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _TituloPublicacion(context, state),
                    const SizedBox(height: 10),
                    _imagen(context),
                    const SizedBox(height: 10),
                    _tipoMascota(context, state),
                    const SizedBox(height: 10),
                    _razaMascota(context, state),
                    const SizedBox(height: 10),
                    _isVacunado(context, state),
                    const SizedBox(height: 10),
                    _isEnfermo(context, state),
                    const SizedBox(height: 10),
                    _tipoPublicacion(context, state),
                    const SizedBox(height: 20),
                    _descripcionAnimal(context, state),
                    const SizedBox(height: 15),
                    _botonCrearPublicacion(context, state)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _TituloPublicacion(BuildContext context, state) {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: _tituloPublicacion,
      autocorrect: false,
      autovalidateMode: AutovalidateMode.always,
      validator: (_) {
        return !state.TituloPublicacion
            ? 'titulo debe ser menor de 50 caracteres'
            : null;
      },
      // ignore: prefer_const_constructors
      decoration: InputDecoration(
          labelText: 'Titulo de publicacion',
          hintStyle: const TextStyle(color: Colors.teal),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.teal),
              borderRadius: BorderRadius.circular(5.5)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.teal),
              borderRadius: BorderRadius.circular(5.5)),
          filled: true,
          fillColor: Colors.green[50]),
    );
  }

  Widget _imagen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: Column(
            children: [
              const Text('Imagen'),
              const SizedBox(height: 10),
              Expanded(
                flex: 4,
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.red)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: imagen == null
                              ? const Center(
                                  child: Text(
                                      'NO SE HA SELECCIONADO AUN UNA IMAGEN'),
                                )
                              : Image.file(imagen),
                        ),
                        //boton para seleccionar una imagen
                        MaterialButton(
                          onPressed: () {
                            seleccionarImagen();
                          },
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          shape: const StadiumBorder(),
                          color: Colors.indigo[700],
                          child: const Text('Seleccionar imagen'),
                        ), /*
                        MaterialButton(
                          onPressed: () {
                            Database().subir_Imagen(imagen);
                          },
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          shape: const StadiumBorder(),
                          color: Colors.indigo[700],
                          child: const Text('subir imagen'),
                        )*/
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _tipoMascota(BuildContext context, state) {
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
              'Tipo de mascota',
              style: TextStyle(color: Colors.black54),
            ),
            value: tipoMascota,
            autovalidateMode: AutovalidateMode.always,
            validator: (_) {
              return !state.TipoMascota
                  ? 'la entrada no debe estar vacia'
                  : null;
            },
            dropdownColor: Colors.white,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 30,
            style: const TextStyle(color: Colors.black54, fontSize: 18),
            onChanged: (item) {
              //vacia = item == 'Perro' ? razaPerro : razaGato;
              seleccionRaza = null;
              if (item == 'Perro') {
                vacia = razaPerro;
              } else if (item == 'Gato') {
                vacia = razaGato;
              } else if (item == 'Hámsters') {
                vacia = razaHamsters;
              } else if (item == 'Pájaros') {
                vacia = razaPajaros;
              } else if (item == 'Peces') {
                vacia = razaPeces;
              } else if (item == 'Otro') {
                vacia = razaAnimales;
              }
              setState(() {
                tipoMascota = item;
                _registroPublicacionBloc
                    .add(TipoMascotaEvent(tipomascota: tipoMascota.toString()));
                print(_registroPublicacionBloc);
              });
            },
            items: mascota.map((listado) {
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

  Widget _razaMascota(BuildContext context, state) {
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
              'Raza del animal',
              style: TextStyle(color: Colors.black54),
            ),
            value: seleccionRaza,
            dropdownColor: Colors.white,
            autovalidateMode: AutovalidateMode.always,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 30,
            style: const TextStyle(color: Colors.black54, fontSize: 18),
            validator: (_) {
              return !state.RazaAnimal
                  ? 'la entrada no debe estar vacia'
                  : null;
            },
            onChanged: (item) {
              setState(() {
                seleccionRaza = item;
                _registroPublicacionBloc
                    .add(RazaAnimalEvent(razaanimal: seleccionRaza.toString()));
                print(_registroPublicacionBloc);
              });
            },
            items: vacia.map((listado) {
              return DropdownMenuItem(
                value: listado,
                child: Text(listado),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _isVacunado(BuildContext context, state) {
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
              'posee vacunas',
              style: TextStyle(color: Colors.black54),
            ),
            value: vacunas,
            dropdownColor: Colors.white,
            autovalidateMode: AutovalidateMode.always,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 30,
            style: const TextStyle(color: Colors.black54, fontSize: 18),
            validator: (_) {
              return !state.Vacunas ? 'la entrada no debe estar vacia' : null;
            },
            onChanged: (item) {
              setState(() {
                vacunas = item;
                _registroPublicacionBloc
                    .add(VacunasEvent(vacunas: vacunas.toString()));
                print(_registroPublicacionBloc);
              });
            },
            items: validar.map((listado) {
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

  Widget _isEnfermo(BuildContext context, state) {
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
              'posee enfermedad',
              style: TextStyle(color: Colors.black54),
            ),
            value: enfermedad,
            autovalidateMode: AutovalidateMode.always,
            dropdownColor: Colors.white,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 30,
            style: const TextStyle(color: Colors.black54, fontSize: 18),
            validator: (_) {
              return !state.Enfermedades
                  ? 'la entrada no debe estar vacia'
                  : null;
            },
            onChanged: (item2) {
              setState(() {
                enfermedad = item2;
                _registroPublicacionBloc
                    .add(EnfermedadesEvent(enfermedad: enfermedad.toString()));
                print(_registroPublicacionBloc);
              });
            },
            items: validar2.map((listado2) {
              return DropdownMenuItem(
                value: listado2,
                child: Text(listado2),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget _tipoPublicacion(BuildContext context, state) {
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
              'tipo de publicacion',
              style: TextStyle(color: Colors.black54),
            ),
            value: tpublicacion,
            autovalidateMode: AutovalidateMode.always,
            dropdownColor: Colors.white,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 30,
            style: const TextStyle(color: Colors.black54, fontSize: 18),
            validator: (_) {
              return !state.TipoPublicacion
                  ? 'la entrada no debe estar vacia'
                  : null;
            },
            onChanged: (item) {
              setState(() {
                tpublicacion = item;
                _registroPublicacionBloc.add(TipoPublicacionEvent(
                    tipopublicacion: tpublicacion.toString()));
                print(_registroPublicacionBloc);
              });
            },
            items: publicaciones.map((listado) {
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

  Widget _descripcionAnimal(BuildContext context, state) {
    return TextFormField(
      keyboardType: TextInputType.text,
      autocorrect: false,
      autovalidateMode: AutovalidateMode.always,
      controller: _descripcionPublicacion,
      validator: (_) {
        return !state.DescripcionPublicacion
            ? 'La descripcion debe ser menor de 200 caracteres'
            : null;
      },
      decoration: InputDecoration(
          labelText: 'Descripcion publicacion',
          hintStyle: const TextStyle(color: Colors.teal),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.teal),
            borderRadius: BorderRadius.circular(5.5),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.teal),
              borderRadius: BorderRadius.circular(5.5)),
          filled: true,
          fillColor: Colors.green[50]),
    );
  }

  Widget _botonCrearPublicacion(BuildContext context, state) {
    return MaterialButton(
      onPressed: () async {
        if (isButtonEnabled(state)) {
          if (imagen == null) {
            Animacion().SeleccioneImagen(context);
          } else {
            Animacion().AnimacionRegistrandoPublicacion(context);
            await Future.delayed(const Duration(milliseconds: 500));
            _enviarDato();
            Navigator.pop(context);
          }
        } else {
          _mostrarAlerta(context);
        }
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const StadiumBorder(),
      color: Colors.indigo[700],
      child: const Text('Registrar'),
    );
  }

  @override
  void dispose() {
    _tituloPublicacion.dispose();
    _descripcionPublicacion.dispose();
    super.dispose();
  }

  void _tituloChange() {
    _registroPublicacionBloc.add(TituloEvent(titulo: _tituloPublicacion.text));
  }

  void _descripcionChange() {
    _registroPublicacionBloc.add(DescripcionPublicacionEvent(
        descripcionpublicacion: _descripcionPublicacion.text));
  }

/*
  void _EnviarFormulario() {
    _registroPublicacionBloc.add(EnviarPublicacion(
        titulo: _tituloPublicacion.text,
        tipomascota: tipoMascota.toString(),
        razaanimal: seleccionRaza.toString(),
        vacunas: vacunas.toString(),
        enfermedad: enfermedad.toString(),
        tipopublicacion: tpublicacion.toString(),
        descripcionpublicacion: _descripcionPublicacion.text));
    print('ENVIANDO DATO: ${EnviarPublicacion()}');
  }
*/
/*
  void _enviarDato() {
    Database().SubirPublicacion2(
        _tituloPublicacion.text,
        tipoMascota,
        seleccionRaza,
        vacunas,
        enfermedad,
        tpublicacion,
        _descripcionPublicacion.text,
        imagen);
  }
*/

  void _enviarDato() {
    Database().SubirPublicacion2(
        _tituloPublicacion.text,
        tipoMascota,
        seleccionRaza,
        vacunas,
        enfermedad,
        tpublicacion,
        _descripcionPublicacion.text,
        imagen);
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
            title: const Text('Error Agregar Publicacion'),
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
