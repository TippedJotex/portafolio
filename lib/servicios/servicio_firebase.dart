// ignore_for_file: non_constant_identifier_names, missing_return
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:google_sign_in/google_sign_in.dart'; #esto se activara en caso de querer iniciar sesion mediante google o cualquier otro medio.

class Database {
  //variable
  final FirebaseAuth firebase;
  File archivo;

  String urlImagen;
  final imagen = FirebaseStorage.instance;
  List<String> idDoc = [];

  QuerySnapshot snapshot;
  DocumentSnapshot documentSnapshot;
  List<DocumentSnapshot> documents;

  Stream datoPublicacion =
      FirebaseFirestore.instance.collection('Publicacion').snapshots();

  CollectionReference databaseFirestore =
      FirebaseFirestore.instance.collection('Usuario');

  CollectionReference databasePublicacion =
      FirebaseFirestore.instance.collection('Publicacion');

  CollectionReference databaseSala =
      FirebaseFirestore.instance.collection('Prueba Sala');

  CollectionReference databaseCuidadoMascota =
      FirebaseFirestore.instance.collection('cuidado de mascota');

  //constructor
  Database({FirebaseAuth firebaseAuth})
      : firebase = firebaseAuth ?? FirebaseAuth.instance;

  //meotodo para registrarse
  Future<void> Registrarse(String email, String password) async {
    return await firebase.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> getIdPublicacion() async {
    databaseSala.get().then((querySnpashot) => {
          querySnpashot.docs.forEach((element) {
            print('Obtuve: ' + element.id);
          })
        });
  }

  //meotodo para iniciar sesion
  Future<void> IniciarSesion(String email, String password) async {
    return firebase.signInWithEmailAndPassword(
        email: email, password: password);
  }

  //metodo para salir de la sesion
  Future<void> SalirSesion() async {
    return Future.wait([firebase.signOut()]);
  }

  //metodo para verificar el inicio sesion
  Future<bool> VerificarSesion() async {
    return firebase.currentUser != null;
  }

  //metodo para obetener el usuario actual
  Future<User> getUsuario() async {
    //print('get usuario: ${firebase.currentUser.uid}');
    databaseFirestore.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        //print('SE OBTUVO LOS DATOS DEL USUARIOooo: ${result.data()}');
      });
    });
    return await firebase.currentUser;
  }

  //metodo para ingresar un usuario a firestore
  Future<void> RegistrarUsuario(String nombre, String fecha, String correo,
      String sexo, String pass) async {
    return await databaseFirestore.doc(firebase.currentUser.uid).set({
      'nombre': nombre,
      'fecha nacimiento': fecha,
      'correo': correo,
      'sexo': sexo,
      'contraseña': pass
    }).then((_) {
      print('Registro completado: ${databaseFirestore.firestore}');
    });
  }

  //registrar en authentication el nombre
  Future<void> registrarNombre(String nombre) async {
    await firebase.currentUser.updateDisplayName(nombre);
  }

  //metodo para registrar publicacion en la base de datos de firestore
  Future<void> SubirPublicacion2(
      String TituloValido,
      String TipoMascotaValido,
      String TipoRazaAnimalValido,
      String PoseeVacunas,
      String PoseeEnfermedades,
      String TipoPublicacionValido,
      String descripcion,
      File archivo) async {
    DocumentReference dc =
        FirebaseFirestore.instance.collection('Publicacion').doc();
    final fechaImagen = DateTime.now();
    final nombre =
        '${fechaImagen.day}-${fechaImagen.month}-${fechaImagen.year}-${fechaImagen.hour}-${fechaImagen.minute}-${fechaImagen.second}-${fechaImagen.millisecond}-${fechaImagen.microsecond}';
    var subirImagen = imagen
        .ref()
        .child('imagenes_publicaciones/${firebase.currentUser.uid}')
        .child('imagen_$nombre');
    await subirImagen.putFile(archivo);
    urlImagen = await subirImagen.getDownloadURL();
    print('Link: ' + urlImagen);
    print('nombre del archivo a subir: imagen' + nombre);
    return await dc.set({
      'titulo': TituloValido,
      'tipo de mascota': TipoMascotaValido,
      'raza de animal': TipoRazaAnimalValido,
      'posee vacunas': PoseeVacunas,
      'posee enfermedades': PoseeEnfermedades,
      'tipo de publicacion': TipoPublicacionValido,
      'descripcion': descripcion,
      'url imagen': urlImagen,
      'id usuario': firebase.currentUser.uid,
      'fecha de publicacion': fechaImagen,
      'id publicacion': dc.id,
      'nombre usuario': firebase.currentUser.displayName,
      'publicacion reportada': 0,
      'estado': true
    }).then((_) {
      print('Se completo el registro: ${dc.firestore}');
    });
  }

  //metodo para cambiar el estado de la publicacion
  Future<void> estadoPublicacion(String idPublicacion) async {
    DocumentReference dc =
        FirebaseFirestore.instance.collection('Publicacion').doc(idPublicacion);
    await dc.update({'estado': false}).then((_) {
      print('publicacion aceptada y dejando de operar...');
    });
  }

  //metodo para incrementar el reporte de publicacion
  Future<void> reportarPublicacion(String idPublicacion) async {
    DocumentReference dc =
        FirebaseFirestore.instance.collection('Publicacion').doc(idPublicacion);
    await dc
        .update({'publicacion reportada': FieldValue.increment(1)}).then((_) {
      print('Se agrego el reporte de publicacion: ${FieldValue.increment(1)}');
    });
  }

  //metodo para registrar mensajes
  Future<void> registrarMensaje3(String mensaje, String idPublicacion,
      String idUsuario, String idSala) async {
    var id = firebase.currentUser.uid;
    await databaseSala.doc(idSala).collection('Mensajes').add({
      'mensaje': mensaje,
      'id emisor': id,
      'id receptor': idUsuario,
      'id publicacion': idPublicacion,
      'fecha': DateTime.now()
    });
  }

  //metodo para obtener la sala
  Future<void> getSala() async {
    databaseSala.get().then((value) => {
          value.docs.forEach((element) {
            print('CAPTURE ID EMISOR: ' + element['id emisor']);
            print('CAPTURE ID RECEPTOR: ' + element['id receptor']);
            print('CAPTURE ID PUBLICACION: ' + element['id publicacion']);
          })
        });
  }

  //metodo para crear la sala
  Future<void> addSala2(
      String idReceptor,
      String idPublicacion,
      String tpublicacion,
      String titulo,
      String urlImagen,
      String nombreUsuario) async {
    DocumentReference dc =
        FirebaseFirestore.instance.collection('Prueba Sala').doc();
    //hubo un pequeño cambio de databaseSala por dc.
    return await dc.set({
      'id publicacion': idPublicacion,
      'id sala': dc.id,
      'titulo': titulo,
      'tipo publicacion': tpublicacion,
      'url imagen': urlImagen,
      'usuario publicacion': nombreUsuario,
      'usuario mensaje': firebase.currentUser.displayName,
      'estado': true,
      'rechazo': false,
      'fecha': DateTime.now(),
      'miembros': FieldValue.arrayUnion([
        '${firebase.currentUser.uid}',
        '${idReceptor}',
      ]),
    }).then((value) {
      print('id del usuario logeado: ${firebase.currentUser.uid}');
      print('id del receptor: ${idReceptor}');
      //print('id de la sala: ${value.id}');
    });
  }

  //cambiar estado de la sala
  Future<void> aceptarPropuesta(String idSala) async {
    DocumentReference dc =
        FirebaseFirestore.instance.collection('Prueba Sala').doc(idSala);
    await dc.update({'estado': false}).then((_) {
      print('sala ya deja de operar');
    });
  }

  //cambiar estado en caso de que el usuario rechaza la propuesta
  Future<void> rechazarPropuesta(String idSala) async{
    DocumentReference dc =
        FirebaseFirestore.instance.collection('Prueba Sala').doc(idSala);
    await dc.update({'rechazo': true}).then((_) {
      print('sala ya deja de operar');
    });
  }

  Future<void> ActualizarPerfilCorreo(String value) async {
    return databaseFirestore
        .doc(firebase.currentUser.uid)
        .update({'correo': value});
  }

  Future<void> ActualizarPerfilFechaNacimeinto(String value) async {
    return databaseFirestore
        .doc(firebase.currentUser.uid)
        .update({'fecha nacimiento': value});
  }

  Future<void> ActualizarPerfilNombre(String value) async {
    return databaseFirestore
        .doc(firebase.currentUser.uid)
        .update({'nombre': value}).then((_) {
      print('se completo la actualizacion');
    }).catchError((error) {
      print('no se actualizo el nombre');
      print(error);
    });
  }

  Future<void> ActualizarPerfilCorreoAuth(String correo_electronico) async {
    var usuario = firebase.currentUser.uid;
    String correo = firebase.currentUser.email;
    FirebaseFirestore.instance
        .collection('Usuario')
        .doc(usuario)
        .get()
        .then((value) {
      String password = value.data()['contraseña'];
      try {
        firebase.currentUser.reload();
        firebase.signInWithEmailAndPassword(email: correo, password: password);
        firebase.currentUser.updateEmail(correo_electronico).then((_) {
          firebase.currentUser.reload();
          print('cambio completado');
        }).catchError((onError) {
          print(onError);
          if (onError.code == 'auth/email-already-in-use') {
            print('correo ocupado');
          } else if (onError.code ==
              'This operation is sensitive and requires recent authentication. Log in again before retrying this request.') {
            print('waa');
          } else if (onError.code == 'auth/requires-recent-login') {
            print('waaa');
          }
        });
      } on FirebaseAuthException catch (e) {
        print(e);
        if (e.code == 'auth/email-already-in-use') {
          print('el correo electronico ya esta registrado');
        } else if (e.code ==
            'This operation is sensitive and requires recent authentication. Log in again before retrying this request.') {
          print('waaa');
        } else if (e.code == 'auth/requires-recent-login') {
          print('waaa');
        }
      }
    });
  }

  Future<void> ActualizarPerfilSexo(String value) {
    return databaseFirestore
        .doc(firebase.currentUser.uid)
        .update({'sexo': value});
  }

  Future<void> ActualizarPerfilContrasena(String value) async {
    return databaseFirestore
        .doc(firebase.currentUser.uid)
        .update({'contraseña': value});
  }

  Future<void> ActualizarPerfilContrasenaAuth(String value_password) async {
    var usuario = firebase.currentUser.uid;
    String correo = firebase.currentUser.email;
    FirebaseFirestore.instance
        .collection('Usuario')
        .doc(usuario)
        .get()
        .then((value) {
      String password = value.data()['contraseña'];
      try {
        firebase.currentUser.reload();
        firebase.signInWithEmailAndPassword(email: correo, password: password);
        firebase.currentUser.updatePassword(value_password).then((_) {
          firebase.currentUser.reload();
          print('cambio completado');
        }).catchError((onError) {
          print(onError);
          if (onError == 'firebase_auth/wrong-password') {
            print('la contraseña es invalida');
          } else if (onError ==
              'The password is invalid or the user does not have a password.') {
            print('wa2');
          } else if (onError ==
              '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
            print('waaa3');
          } else if (onError ==
              '[firebase_auth/requires-recent-login] This operation is sensitive and requires recent authentication. Log in again before retrying this request.') {
            print('waaa4');
          } else if (onError ==
              'This operation is sensitive and requires recent authentication. Log in again before retrying this request.') {
            print('waaa5');
          } else if (onError == 'auth/wrong-password') {
            print('waaaa');
          } else if (onError ==
              'The password is invalid or the user does not have a password.') {
            print('waaa');
          }
        });
      } on FirebaseAuthException catch (e) {
        print(e);
        if (e.code == 'user-not-found') {
          print('email erronea');
        } else if (e.code == 'wrong-password') {
          print('contrasena erronea');
        } else if (e.code ==
            'The password is invalid or the user does not have a password.') {
          print('waaa');
        } else if (e.code ==
            'There is no user record corresponding to this identifier. The user may have been deleted.') {
          print('waa2');
        } else if (e.code == 'auth/wrong-password') {
          print('waaa');
        } else if (e.code ==
            'The password is invalid or the user does not have a password.') {
          print('waaa');
        }
      }
    });
  }

  Stream<QuerySnapshot> getNombre() {
    databaseFirestore.doc(firebase.currentUser.uid);
    return databaseFirestore.snapshots();
  }

  Widget usuario(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Usuario')
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
        print('capture los datos');
        const CircularProgressIndicator();
        return Text('Bienvenido Usuario: ' + documento['nombre'],
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15));
      },
    );
  }

/*
  Future<void> SubirPublicacion(
      String TituloValido,
      String TipoMascotaValido,
      String TipoRazaAnimalValido,
      String PoseeVacunas,
      String PoseeEnfermedades,
      String TipoPublicacionValido,
      String descripcion,
      File archivo) async {
    CollectionReference databaseFirestore2 =
        FirebaseFirestore.instance.collection('Publicacion');
    final fechaImagen = DateTime.now();
    final nombre =
        '${fechaImagen.day}-${fechaImagen.month}-${fechaImagen.year}-${fechaImagen.hour}-${fechaImagen.minute}-${fechaImagen.second}-${fechaImagen.millisecond}-${fechaImagen.microsecond}';
    var subirImagen = imagen
        .ref()
        .child('imagenes_publicaciones/${firebase.currentUser.uid}')
        .child('imagen_$nombre');
    await subirImagen.putFile(archivo);
    urlImagen = await subirImagen.getDownloadURL();
    print('Link: ' + urlImagen);
    print('nombre del archivo a subir: imagen' + nombre);
    return await databaseFirestore2
        .doc(firebase.currentUser.uid)
        .collection('${TipoPublicacionValido}')
        .add({
      'titulo': TituloValido,
      'tipo de mascota': TipoMascotaValido,
      'raza de animal': TipoRazaAnimalValido,
      'posee vacunas': PoseeVacunas,
      'posee enfermedades': PoseeEnfermedades,
      'tipo de publicacion': TipoPublicacionValido,
      'descripcion': descripcion,
      'url imagen': urlImagen,
    }).then((_) {
      print('Se completo el registro: ${databaseFirestore.firestore}');
    });
  }
  */

  // Future<void> addIdUsuario(
  //   String id
  // ) async{
  //   await databaseFirestore.doc(firebase.currentUser.uid)
  //   .set({
  //     'miembros_chat' FieldValue.arrayUnion(/*aqui meter todos los documentos generados*/);
  //   });
  // }

  //Metodo para agregar una publicacion
  Future<void> RegistrarPublicacion(
      String TituloValido,
      String TipoMascotaValido,
      String TipoRazaAnimalValido,
      String PoseeVacunas,
      String PoseeEnfermedades,
      String TipoPublicacionValido,
      String descripcion) async {
    print('URL RESCATADA: ${urlImagen}');
    return await databasePublicacion.doc(firebase.currentUser.uid).set({
      'titulo': TituloValido,
      'tipo de mascota': TipoMascotaValido,
      'raza de animal': TipoRazaAnimalValido,
      'posee vacunas': PoseeVacunas,
      'posee enfermedades': PoseeEnfermedades,
      'tipo de publicacion': TipoPublicacionValido,
      'descripcion': descripcion,
      'url imagen': urlImagen
    }).then((_) {
      print('Se completo el registro: ${databaseFirestore.firestore}');
    });
  }

/*
  //esto es para registrar en la base de datos: realtime database
  Future<void> SubirPublicacion3(
      String TituloValido,
      String TipoMascotaValido,
      String TipoRazaAnimalValido,
      String PoseeVacunas,
      String PoseeEnfermedades,
      String TipoPublicacionValido,
      String descripcion,
      File archivo) async {
    DatabaseReference databaseFirestore3 =
        FirebaseDatabase.instance.reference().child('Adopcion').reference();
    final fechaImagen = DateTime.now();
    final nombre =
        '${fechaImagen.day}-${fechaImagen.month}-${fechaImagen.year}-${fechaImagen.hour}-${fechaImagen.minute}-${fechaImagen.second}-${fechaImagen.millisecond}-${fechaImagen.microsecond}';
    var subirImagen = imagen
        .ref()
        .child('imagenes_publicaciones/${firebase.currentUser.uid}')
        .child('imagen_$nombre');
    await subirImagen.putFile(archivo);
    urlImagen = await subirImagen.getDownloadURL();
    print('Link: ' + urlImagen);
    print('nombre del archivo a subir: imagen' + nombre);
    return await databaseFirestore3.push().set({
      'titulo': TituloValido,
      'tipo de mascota': TipoMascotaValido,
      'raza de animal': TipoRazaAnimalValido,
      'posee vacunas': PoseeVacunas,
      'posee enfermedades': PoseeEnfermedades,
      'tipo de publicacion': TipoPublicacionValido,
      'descripcion': descripcion,
      'url imagen': urlImagen,
      'id usuario': firebase.currentUser.uid
    }).then((_) {
      print('Se completo el registro: ${databaseFirestore.firestore}');
    });
  }
*/
/*
  Future<void> ActualizarPublicacionAdopcion(String value){
    DocumentReferance databaseFirestore2 =
        FirebaseFirestore.instance.collection('Publicacion');
    return databaseFirestore2.doc(firebase.currentUser.uid).collection('Adopcion').doc().update({
      
    });
  }
*/

  /* Future<void> ActualizarPerfilCorreoAuth(String correo_electronico) async {
    var usuario = firebase.currentUser.uid;
    String correo = firebase.currentUser.email;

/**************************Borrar Despues************************************
    FirebaseFirestore.instance.doc(usuario).get().then((value) {
      String password = value.data()['contraseña'];
    });*/

//recordatorio: una vez que se alla aplicado el cambio de correo, cerrar la sesion para que ingrese nuevamente
//idea: primero ver que revise en el mismo doc si existe el correo, en caso de que no exista que revise todos los demas.

    /* final QuerySnapshot result = await databaseFirestore
        .where('correo', isEqualTo: correo_electronico)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.length > 0) {
      print('YA EXISTE');
    } else {
      print('NO EXISTEE');
    }
*/
/*    databaseFirestore.get().then((querySnapshot) => {
          querySnapshot.docs.forEach((element) {
            if (correo_electronico == element['correo']) {
              print('correo existe');
            } else {
              print('correo no existe');
            }
          })
        });
*************************Borrar Despues*************************************/

    FirebaseFirestore.instance
        .collection('Usuario')
        .doc(usuario)
        .get()
        .then((value) {
      String password = value.data()['contraseña'];
      try {
        firebase.currentUser.reload();
        firebase.signInWithEmailAndPassword(email: correo, password: password);
        firebase.currentUser.updateEmail(correo_electronico).then((_) {
          firebase.currentUser.reload();
          print('cambio completado');
        }).catchError((onError) {
          print(onError);
          if (onError.code == 'auth/email-already-in-use') {
            print('correo ocupado');
          }
        });
      } on FirebaseAuthException catch (e) {
        print(e);
        if (e.code == 'auth/email-already-in-use') {
          print('el correo electronico ya esta registrado');
        }
      }
    });
  }

/*
  Future<void> ActualizarPerfilCorreoAuth(String value) async {
    String correo = firebase.currentUser.email;
    String password = 'password';
    try {
      //firebase.signInWithEmailAndPassword(email: correo, password: password);
      FirebaseAuth.instance.currentUser.reload();
      firebase.currentUser.updateEmail(value).then((_) {
        print('cambio completado');
      }).catchError((e) {
        print('ocurrio un error');
        print(e);
      });
    }
    /* on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'user-not-found') {
        print('email erronea');
      } else if (e.code == 'wrong-password') {
        print('contrasena erronea');
      } else if (e.code ==
          'The password is invalid or the user does not have a password.') {
        print('waaa');
      } else if (e.code ==
          'There is no user record corresponding to this identifier. The user may have been deleted.') {
        print('waa2');
      }
    } catch (e) {
      print('error pasado');
      print(e);
    }*/
  }
*/
*/

/*
  //Metodo para subir una foto a firebase storage
  Future<void> subir_Imagen(File archivo) async {
    CollectionReference databaseFirestore =
        FirebaseFirestore.instance.collection('Publicacion');
    final fechaImagen = DateTime.now();
    final nombre =
        '${fechaImagen.day}-${fechaImagen.month}-${fechaImagen.year}-${fechaImagen.second}';
    var subirImagen = imagen
        .ref()
        .child('imagenes_publicaciones/${firebase.currentUser.uid}')
        .child('imagen_$nombre');
    await subirImagen.putFile(archivo);
    urlImagen = await subirImagen.getDownloadURL();
    print('Link: ' + urlImagen);
    print('nombre del archivo a subir: imagen' + nombre);
  }
*/

/*
  Widget ListaPublicacionAdopcion(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Publicacion')
          .doc(firebase.currentUser.uid)
          .collection('Adopcion')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Ocurrio un error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        var documento = snapshot.data.docs;
        return ListView.builder(
            itemCount: documento.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Text(documento[index].data()['titulo']),
                      const SizedBox(height: 10.0),
                      Image.network(documento[index].data()['url imagen'])
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
*/
/*
  Widget ListaPublicacionAdopcion2(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Publicacion').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('se detecto un error');
          return const Center(
            child: Text('OCURRIO UN ERROR'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('cargando datos');
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          print('se encuentra vacio');
          return const Center(
            child: Text('NO SE ENCUENTRAN PUBLICACIONES'),
          );
        }
        var documento = snapshot.data.docs;
        return ListView.builder(
          itemCount: documento.length,
          itemBuilder: (context, index) {
            print(documento[index].data()['titulo']);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Text('Titulo: ' + documento[index].data()['titulo']),
                    const SizedBox(height: 10.0),
                    FadeInImage(
                      image:
                          NetworkImage(documento[index].data()['url imagen']),
                      placeholder: const AssetImage('assets/cargando.gif'),
                      fadeInDuration: const Duration(milliseconds: 200),
                    ),
                    /*Image.network(
                        documento[index].data()['url imagen']
                        ),*/
                    const SizedBox(height: 10.0),
                    Text('Descripcion: ' +
                        documento[index].data()['descripcion'])
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
*/
  /*
  Future<void> getNombre() async {
    var usuario = firebase.currentUser.uid;
    FirebaseFirestore.instance.collection('Usuario').doc(usuario).get().then((value) {
      print('Dato Obtendio: '+value.data()['nombre']);
    });
  }
  */

}
//aqui termina

/*
  #esto quizas pueda servir mas adelante jejeje
  // ignore: unused_field
  final FirebaseAuth _firebaseAuth;

  // ignore: unused_field
  //final GoogleSignIn _googleSignIn;

  Servicio({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  //constructor
  /*
  Servicio({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();
  */

  //ingresar con credencial a la base de datos
  // ignore: non_constant_identifier_names
  Future<void> IngresarConCredenciales(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  //registrarse para la base de datos
  // ignore: non_constant_identifier_names
  Future<void> Registrarse(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> Deslogearse() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }

  Future<void> EstaRegistrado() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<FirebaseUser> getUser() async {
    return await _firebaseAuth.currentUser();
  }
}
*/
