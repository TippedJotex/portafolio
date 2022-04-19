// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class CuidadoMascotaDetallado extends StatelessWidget {
  final documento;
  CuidadoMascotaDetallado(this.documento, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titulo(context),
      body: _fondo(context),
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
        children: [detallado(context)],
      ),
    );
  }

  Widget detallado(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          color: Colors.blueGrey[100],
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.center,
                child: Text(documento['titulo'],
                    style: TextStyle(
                        color: Colors.blueGrey[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontStyle: FontStyle.italic)),
              ),
              const SizedBox(height: 10.0),
              Image.network(
                documento['url imagen'],
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent cargaProgreso) {
                  if (cargaProgreso == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.center,
                child: Text(
                  'Alimentacion: ' + documento['Alimentacion'],
                  style: TextStyle(
                      color: Colors.blueGrey[700],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 16),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.center,
                child: Text(
                  'Educacion: ' + documento['educacion'],
                  style: TextStyle(
                      color: Colors.blueGrey[700],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 16),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.center,
                child: Text(
                  'Higiene: ' + documento['higiene'],
                  style: TextStyle(
                      color: Colors.blueGrey[700],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 16),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.center,
                child: Text(
                  'Paseos: ' + documento['paseos'],
                  style: TextStyle(
                      color: Colors.blueGrey[700],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 16),
                ),
              )
            ],
          )),
    );
  }
}
