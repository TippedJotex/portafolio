import 'package:flutter/material.dart';

class BotonIngresar extends StatelessWidget {
  final Function() onPressed;
  const BotonIngresar({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: this.onPressed,
      //Navigator.pushNamed(context, 'ingresar');
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const StadiumBorder(),
      color: Colors.indigo[700],
      child: const Text('Login'),
    );
  }
}


