import 'package:flutter/material.dart';

class BotonVolver extends StatelessWidget {
  final Function() onPressed;
  const BotonVolver({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: this.onPressed,
        //Navigator.pop(context);
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const StadiumBorder(),
      color: Colors.indigo[700],
      child: const Text('Volver'),
    );
  }
}