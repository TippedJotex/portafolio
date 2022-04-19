// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, camel_case_types, prefer_final_fields, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/widget/animacion_carga.dart';

class sala_Mensajeria extends StatelessWidget {
  final documento; //esto viene de la sala de chat
  final idReceptor;
  TextEditingController _mensaje = TextEditingController();

  sala_Mensajeria(this.documento, this.idReceptor,
      {Key key, Database userRepository})
      : super(key: key);

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
      title: Text('Chat'), //Text(documento['id receptor']),
      backgroundColor: const Color.fromRGBO(34, 214, 148, 0.5),
    );
  }

  Widget menuChat(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //const Text(''),
        //aqui poner para que se pueda ver todos los mensajes
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: SingleChildScrollView(
              reverse: true,
              child: mensajes(context),
            )
          ),
        ),
        estructuraMensaje(context)
      ],
    );
  }

  Widget estructuraMensaje(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 60,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _mensaje,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'Mensaje...'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_mensaje.text == '') {
                        Animacion().errorMensaje2(context);
                      } else {
                        enviarMensaje();
                      }
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget mensajes(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Prueba Sala')
          .doc(documento['id sala'])
          .collection('Mensajes')
          .orderBy('fecha', descending: false)
          .snapshots(),
      // ignore: missing_return
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
            child: Text('Puede iniciar la conversacion con un simple Hola...'),
          );
        }
        if (snapshot.hasData) {
          var result = snapshot.data.docs;
          var id = Database().firebase.currentUser.uid;
          return ListView.builder(
            shrinkWrap: true,
            primary: true,
            physics: const ScrollPhysics(),
            itemCount: result.length,
            // ignore: missing_return
            itemBuilder: (context, index) {
              bool yo = id == result[index].data()['id emisor'];
              String mensajeEnviado = result[index].data()['mensaje'];
              // String idEmisor = result[index].data()['id emisor'];
              // String idReceptor = result[index].data()['id receptor'];
              Timestamp t = result[index].data()['fecha'];
              DateTime d = t.toDate();
              // final fecha = '${d.day}/${d.month}/${d.year}';
              return Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment:
                      yo ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.6),
                      decoration: BoxDecoration(
                          color: yo ? Colors.blue[50] : Colors.grey[200],
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomLeft: Radius.circular(yo ? 12 : 0),
                              bottomRight: Radius.circular(yo ? 0 : 12))),
                      child: Text(
                        mensajeEnviado,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void enviarMensaje() {
    String idSala = documento['id sala'];
    String idPublicacion = documento['id publicacion'];
    String idUsuario = idReceptor;
    Database()
        .registrarMensaje3(_mensaje.text, idPublicacion, idUsuario, idSala);
    _mensaje.clear();
  }
}
