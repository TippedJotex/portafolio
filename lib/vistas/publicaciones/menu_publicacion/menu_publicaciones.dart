// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tesis/bloc/autenticacion_bloc/bloc/autenticacion_bloc.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/vistas/chat/chat_room.dart';
import 'package:tesis/vistas/cuidadoMascota/cuidado_mascota.dart';
import 'package:tesis/vistas/publicaciones/agregar_publicacion/agregar_publicacion.dart';
import 'package:tesis/vistas/editar_perfil/editar_perfil.dart';
import 'package:tesis/vistas/publicaciones/publicacion_detallada/publicacion_detallada.dart';

class Publicaciones extends StatelessWidget {
  const Publicaciones({Key key, Database userRepository, User user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var documento;
    return Scaffold(
      appBar: _appBar(context),
      drawer: _menuLateral(context),
      body: ListaPublicacion(context, documento),
      floatingActionButton: FloatingActionButton(
        child: Image.asset('assets/agregar.png', height: 40),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const AgregarPublicacion();
          }));
        },
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('Publicaciones',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
      backgroundColor: Colors.cyan,
    );
  }

  Widget _menuLateral(BuildContext context) {
    return Drawer(
      child: Container(
        //padding: EdgeInsets.zero,
        color: Colors.cyan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
                child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Image.asset('assets/tienda.png'),
                      ),
                      Database().usuario(context)
                    ],
                  ),
                ),
                ListTile(
                  leading: Image.asset('assets/usuario.png', height: 40),
                  title: const Text(
                    'Editar Perfil',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const EditarPerfil();
                    }));
                  },
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: Image.asset('assets/chat.png', height: 40),
                  title: const Text(
                    'Sala De Chats',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ChatRoom();
                    }));
                  },
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: Image.asset('assets/cuidado.png', height: 40),
                  title: const Text(
                    'Cuidado de mascota',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return CuidadoMascota();
                    }));
                  },
                ),
                // const SizedBox(height: 10),
                // ListTile(
                //   leading: Image.asset('assets/propuesta.png', height: 40),
                //   title: const Text(
                //     'Propuestas usuarios',
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 18),
                //   ),
                //   onTap: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (_) {
                //       return propuestasUsuarios();
                //     }));
                //   },
                // ),
              ],
            )),
            ListTile(
              leading: Image.asset('assets/salida(1).png', height: 40),
              title: const Text(
                'Cerrar Sesion',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onTap: () {
                BlocProvider.of<AutenticacionBloc>(context)
                    .add(AutenticacionSalidaSesion());
              },
            )
          ],
        ),
      ),
    );
  }

  Widget ListaPublicacion(BuildContext context, documento) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Publicacion')
          .orderBy('fecha de publicacion', descending: true)
          .snapshots(),
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
        if (snapshot.hasData) {
          documento = snapshot.data.docs;
          //final List<PublicacionModelo> obtenerDato = List.generate()
          //Database().getID();
          //var documento2 = snapshot.data.snapshot.value;
          //Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
          return ListView.builder(
            itemCount: documento.length,
            itemBuilder: (context, index) {
              //map.values.toList()[index]['id usuario'];
              print(documento[index].data()['titulo']);
              //print(documento[index].data());
              String titulo = documento[index].data()['titulo'];
              titulo = titulo.replaceFirst(titulo[0], titulo[0].toUpperCase());
              Timestamp t = documento[index].data()['fecha de publicacion'];
              DateTime d = t.toDate();
              final d1 = '${d.day}/${d.month}/${d.year}';
              print(d);
              // print('id de la publicacion: ' +
              //     documento[index].data()['id publicacion']);
              if (documento[index].data()['estado'] == false){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    //color: Colors.amber[100],
                    color: Colors.lime[100],
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text('PUBLICACION FINALIZADA Y ACEPTADA...',
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic)),
                        ),
                        const SizedBox(height: 10.0),
                        Image.network(
                          documento[index].data()['url imagen'],
                        ),
                        // FadeInImage(
                        //   image:
                        //       NetworkImage(documento[index].data()['url imagen']),
                        //   placeholder: const AssetImage('assets/cargando.gif'),
                        //   fadeInDuration: const Duration(milliseconds: 200),
                        // ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            'Publicacion ya no esta operando dado que fue aceptado por el usuario...',
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (documento[index].data()['publicacion reportada'] >= 3) {
                print('PUBLICACION YA NO OPERA...');
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    //color: Colors.amber[100],
                    color: Colors.lime[100],
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text('PUBLICACION YA NO OPERA...',
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic)),
                        ),
                        const SizedBox(height: 10.0),
                        Image.network(
                          documento[index].data()['url imagen'],
                        ),
                        // FadeInImage(
                        //   image:
                        //       NetworkImage(documento[index].data()['url imagen']),
                        //   placeholder: const AssetImage('assets/cargando.gif'),
                        //   fadeInDuration: const Duration(milliseconds: 200),
                        // ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            'Publicacion ya no esta operando...',
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Card(
                      //color: Colors.amber[100],
                      color: Colors.lime[100],
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            alignment: Alignment.center,
                            child: Text(titulo,
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic)),
                          ),
                          const SizedBox(height: 10.0),
                          Image.network(
                            documento[index].data()['url imagen'],
                          ),
                          // FadeInImage(
                          //   image:
                          //       NetworkImage(documento[index].data()['url imagen']),
                          //   placeholder: const AssetImage('assets/cargando.gif'),
                          //   fadeInDuration: const Duration(milliseconds: 200),
                          // ),
                          const SizedBox(height: 10.0),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Usuario de publicacion: ' +
                                  documento[index].data()['nombre usuario'],
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Tipo De Publicacion: ' +
                                  documento[index]
                                      .data()['tipo de publicacion'],
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Descripcion: ' +
                                  documento[index].data()['descripcion'],
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.only(right: 10),
                            alignment: Alignment.centerRight,
                            child: Text(
                              'fecha de publicacion: $d1',
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return PublicacionDetallada(documento[index]);
                      }));
                    },
                  ));
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
/*
Widget usuario(BuildContext context) {
  return StreamBuilder(
    stream: Database().datoUsuario().dato,
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
          style: const TextStyle(color: Colors.white));
    },
  );
}
*/

  //aqui tengo que mejorarlo y llamar los parametros de la base de datos
  /*
  Widget ListaPublicacion(){
    return ListView(
      children: <Widget>[
        SizedBox(height: 10),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0)
          ),
          child: Column(
            children: <Widget>[
              Text('Se regala gatito', style: TextStyle(fontSize: 30),),
              ClipRect(
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQh7pzF5NlXP4aJcTz8E8QPJHuYWjyaX98MFg&usqp=CAU'
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Text('Se da en adopcion gatito dado que no lo puedo mantener por problemas personales.', style: TextStyle(fontSize: 15),)
                  ],
                ),
              )
            ],
          ),
        )
        child: Column(
                    children: <Widget>[
                      Text('Titulo: ' + documento[index].data()['titulo'],
                          style: const TextStyle(color: Colors.black87)),
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
                          documento[index].data()['descripcion']),
                      
                    ],
      ],
    );
  }

  */
