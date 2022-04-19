// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'cuidado_mascota_detallado.dart';

class CuidadoMascota extends StatelessWidget {
  CuidadoMascota({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titulo(context),
      body: listaCuidadosMascota(context),
    );
  }

  Widget titulo(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('Cuidado de mascotas',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
      backgroundColor: Colors.cyan,
    );
  }

  Widget listaCuidadosMascota(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('cuidado de mascota')
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
          var documento = snapshot.data.docs;
          return ListView.builder(
            itemCount: documento.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Card(
                      color: Colors.lime[100],
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            alignment: Alignment.center,
                            child: Text(documento[index].data()['titulo']),
                          ),
                          Image.network(documento[index].data()['url imagen'],
                          loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent cargaProgreso) {
                              if (cargaProgreso == null) return child;
                              return const Center( 
                                child: CircularProgressIndicator(),
                              );
                            },)
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return CuidadoMascotaDetallado(documento[index]);
                      }));
                    },
                  ));
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
