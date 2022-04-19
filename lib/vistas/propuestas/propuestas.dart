// ignore_for_file: missing_return

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tesis/servicios/servicio_firebase.dart';

class propuestasUsuarios extends StatelessWidget {
  var id = Database().firebase.currentUser.uid;
  var id2 = Database().firebase.currentUser.displayName;
  propuestasUsuarios({Key key, Database userRepository, User user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _listaPropuesta(context),
    );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('Propuestas de usuarios',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
      backgroundColor: Colors.cyan,
    );
  }

  Widget _listaPropuesta(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Prueba Sala')
          .where('miembros', arrayContainsAny: [id])
          .where('id publicacion', isEqualTo: 'yylPJnWp4i4kWfYgETO8')
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
              print(documento[index].data()['id publicacion']);
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
                        
                      ],
                    ),
                  ),
                  // onTap: () {
                  //   Navigator.push(context, MaterialPageRoute(builder: (_) {
                  //     return sala_Mensajeria(documento[index], idReceptor);
                  //   }));
                  // },
                ),
              );
            },
          );
        }
      },
    );
  }
}
