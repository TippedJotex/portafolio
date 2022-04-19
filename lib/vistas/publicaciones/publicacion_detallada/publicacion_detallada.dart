// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/vistas/chat/sala_mensajeria2.dart';
import 'package:tesis/widget/animacion_carga.dart';

class PublicacionDetallada extends StatelessWidget {
  final documento;
  var id = Database().firebase.currentUser.uid;
  PublicacionDetallada(this.documento, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: titulo(context), body: _fondo(context));
  }

  Widget titulo(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('Publicacion Detallada',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
      backgroundColor: Colors.cyan,
    );
  }

  Widget _fondo(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(220, 220, 220, 0.9),
        Color.fromRGBO(220, 220, 220, 0.9)
      ])),
      child: ListView(
        children: [cardPublicacion(context)],
      ),
    );
  }

  Widget cardPublicacion(BuildContext context) {
    String titulo = documento['titulo'];
    titulo = titulo.replaceFirst(titulo[0], titulo[0].toUpperCase());
    Timestamp t = documento['fecha de publicacion'];
    DateTime d = t.toDate();
    final d1 = '${d.day}/${d.month}/${d.year}';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.blueGrey[100],
        child: Column(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.center,
                child: Text(
                  titulo,
                  style: TextStyle(
                      color: Colors.blueGrey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontStyle: FontStyle.italic),
                )),
            const SizedBox(height: 10.0),
            Image.network(
              documento['url imagen'],
            ),
            // FadeInImage(
            //   image: NetworkImage(documento['url imagen']),
            //   placeholder: const AssetImage('assets/cargando.giff'),
            //   fadeInDuration: const Duration(milliseconds: 200),
            // ),
            const SizedBox(height: 5.0),
            Container(
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                  'Usuario de publicacion: ' + documento['nombre usuario'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic)),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                    text: 'Tipo de mascota: ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontStyle: FontStyle.italic),
                    children: <TextSpan>[
                      TextSpan(
                          text: '${documento['tipo de mascota']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontStyle: FontStyle.italic))
                    ]),
              ),
              //child: Text('Tipo de mascota: ' + documento['tipo de mascota'],
              //style: const TextStyle(color: Colors.lime, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Raza de la mascota: ' +
                      documento['raza de animal'.toString()],
                  style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                )),
            const SizedBox(height: 5),
            Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Posee alguna enfermedad: ' + documento['posee enfermedades'],
                  style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                )),
            const SizedBox(height: 5),
            Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Posee alguna vacuna: ' + documento['posee vacunas'],
                  style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                )),
            const SizedBox(height: 5),
            Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                    'Tipo de publicacion: ' + documento['tipo de publicacion'],
                    style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic))),
            const SizedBox(height: 5),
            Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Fecha de publicacion: $d1',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                )),
            const SizedBox(height: 5),
            Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Descripcion: \n' + documento['descripcion'],
                  style: TextStyle(
                      color: Colors.blueGrey[700],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 16),
                )),
            const SizedBox(height: 20),
            botonContactarUsuario(context),
            reportarPublicacion(context)
          ],
        ),
      ),
    );
  }

  Widget botonContactarUsuario(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        onPressed: () async {
          if (id == documento['id usuario']) {
            Animacion().errorMensaje(context);
          } else {
            //Database().getSala();
            var result, docuemnts, a;
            Database().documents = a;
            Database().snapshot = result;
            Database().documentSnapshot = docuemnts;
            String idEmisor = Database().firebase.currentUser.uid;
            String idReceptor = documento['id usuario'];
            String idPublicacion = documento['id publicacion'];
            result = await Database()
                .databaseSala
                .where('miembros', arrayContains: idEmisor)
                //.where('miembros', arrayContains: idReceptor)
                // .where('id emisor', isEqualTo: idEmisor)
                // .where('id receptor', isEqualTo: idReceptor)
                .where('id publicacion', isEqualTo: idPublicacion)
                .limit(1)
                .get();
            a = result.docs;
            print(a);
            if (a.length > 0) {
              print('id en uso');
              Database().databaseSala.get().then((value) => {
                    value.docs.forEach((element) {
                      for (var i = 0; i < 1; i++) {
                        var idSala = element['miembros'][i];
                        if (idSala == id &&
                            idSala != null &&
                            idPublicacion == element['id publicacion']) {
                          var rescate = element['id sala'];
                          print(rescate);
                          print('waaa: ' + element['id sala']);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return sala_Mensajeria2(documento, rescate);
                          }));
                        }
                      }
                      // if (id == element['miembros']) {
                      //   print('waaa: '+element['id sala']);
                      // }
                    })
                  });
              //print(idSala); //aqui obtengo null
              // Navigator.push(context, MaterialPageRoute(builder: (_) {
              //   return sala_Mensajeria2(documento);
              // }));
            } else {
              print('disponible');
              registrarSala();
              print('registre nueva sala');
              //buscar el id
              Database().databaseSala.get().then((value) => {
                    value.docs.forEach((element) {
                      for (var i = 0; i < 1; i++) {
                        var idSala = element['miembros'][i];
                        if (idSala == id &&
                            idSala != null &&
                            idPublicacion == element['id publicacion']) {
                          print('waaa: ' + element['id sala']);
                          var rescate = element['id sala'];
                          print(rescate);
                          idSala = idSala;
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return sala_Mensajeria2(documento, rescate);
                          }));
                        }
                      }
                      // if (id == element['miembros']) {
                      //   print('waaa: '+element['id sala']);
                      // }
                    })
                  });
              // Navigator.push(context, MaterialPageRoute(builder: (_) {
              //   return sala_Mensajeria2(
              //       documento); // esto cambiarlo a sala_mensajeria
              // }));
            }
          }
        },
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const StadiumBorder(),
        color: Colors.green,
        child: const Text(
          'contactar al usuario',
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }

  Widget reportarPublicacion(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: MaterialButton(
        onPressed: () async {
          if (documento['publicacion reportada'] <= 3) {
            Animacion().agregarReporte(context);
            reportar();
          }
          Navigator.pop(context);
        },
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const StadiumBorder(),
        color: Colors.green,
        child: const Text(
          'reportar publicacion',
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }

  void reportar() {
    String idPublicacion = documento['id publicacion'];
    Database().reportarPublicacion(idPublicacion);
  }

  void registrarSala() {
    Database().addSala2(
        documento['id usuario'],
        documento['id publicacion'],
        documento['tipo de publicacion'],
        documento['titulo'],
        documento['url imagen'],
        documento['nombre usuario']);
  }
}
