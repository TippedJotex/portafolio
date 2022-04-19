// ignore_for_file: missing_return, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/vistas/chat/sala_mensajeria.dart';

class ChatRoom extends StatelessWidget {
  var id = Database().firebase.currentUser.uid;
  var id2 = Database().firebase.currentUser.displayName;
  ChatRoom({Key key, Database userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titulo(context),
      body: menuChat(context),
    );
  }

  Widget titulo(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('Chats'),
      backgroundColor: const Color.fromRGBO(34, 214, 148, 0.5),
    );
  }

  Widget menuChat(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Prueba Sala')
          .where('miembros', arrayContainsAny: [id])
          //.where('usuario publicacion', isEqualTo: id2)
          .orderBy('fecha', descending: true)
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
            child: Text('NO SE ENCUENTRAS CHATS'),
          );
        }
        if (snapshot.hasData) {
          var documento = snapshot.data.docs;
          return ListView.builder(
            itemCount: documento.length,
            itemBuilder: (context, index) {
              var idReceptor;
              for (var i = 0; i < 2; i++) {
                var a = documento[index].data()['miembros'][i];
                //print(a);
                if (a != id2 && a != null) {
                  //print(a);
                  idReceptor = a;
                }
              }
              if (documento[index].data()['rechazo'] == true) {
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
                          child: const Text('PUBLICACION RECHAZADA...',
                              style: TextStyle(
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
                            'El usuario rechazo su propuesta...',
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
              if (documento[index].data()['estado'] == false) {
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
                          child: const Text(
                              'PUBLICACION FINALIZADA Y ACEPTADA...',
                              style: TextStyle(
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
              if (idReceptor == id &&
                  documento[index].data()['estado'] == true) {
                print('fin');
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Card(
                          color: Colors.lime[100],
                          child: Column(children: <Widget>[
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              alignment: Alignment.center,
                              child: Text(
                                'Publicacion: ' +
                                    documento[index].data()['titulo'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Image.network(
                              documento[index].data()['url imagen'],
                              loadingBuilder: (BuildContext context,
                                  Widget child, ImageChunkEvent cargaProgreso) {
                                if (cargaProgreso == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              alignment: Alignment.center,
                              child: Text(
                                'Mensaje enviado por: ' +
                                    documento[index].data()['usuario mensaje'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              alignment: Alignment.center,
                              child: Text(
                                  'Mensaje recibido por: ' +
                                      documento[index]
                                          .data()['usuario publicacion'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontStyle: FontStyle.italic)),
                            ),
                            const SizedBox(height: 15),
                            const Text('¿Aceptar propuesta de usuario?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontStyle: FontStyle.italic)),
                            const SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: MaterialButton(
                                      onPressed: () {
                                        String idPublicacion = documento[index]
                                            .data()['id publicacion'];
                                        String idSala =
                                            documento[index].data()['id sala'];
                                        Database()
                                            .estadoPublicacion(idPublicacion);
                                        Database().aceptarPropuesta(idSala);
                                      },
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      shape: const StadiumBorder(),
                                      color: Colors.green,
                                      height: 40.0,
                                      minWidth: 70.0,
                                      child: const Text(
                                        'Aceptar',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: MaterialButton(
                                      onPressed: () {
                                        String idSala =
                                            documento[index].data()['id sala'];
                                        Database().rechazarPropuesta(idSala);
                                      },
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      shape: const StadiumBorder(),
                                      color: Colors.green,
                                      height: 40.0,
                                      minWidth: 70.0,
                                      child: const Text(
                                        'Rechazar',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ])),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return sala_Mensajeria(documento[index], idReceptor);
                        }));
                      },
                    ));
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Card(
                    color: Colors.lime[100],
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            'Publicacion: ' + documento[index].data()['titulo'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Image.network(
                          documento[index].data()['url imagen'],
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent cargaProgreso) {
                            if (cargaProgreso == null) return child;
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            'Mensaje enviado por: ' +
                                documento[index].data()['usuario mensaje'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                              'Mensaje recibido por: ' +
                                  documento[index]
                                      .data()['usuario publicacion'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  fontStyle: FontStyle.italic)),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return sala_Mensajeria(documento[index], idReceptor);
                    }));
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
