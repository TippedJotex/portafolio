import 'package:flutter/material.dart';

class BotonRegistrarUsuario extends StatelessWidget {
  final Function() onPressed;
  const BotonRegistrarUsuario({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: this.onPressed,
      //Navigator.pushNamed(context, 'registro');
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const StadiumBorder(),
      color: Colors.indigo[700],
      child: const Text('Registrarse'),
    );
  }
}