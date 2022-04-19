import 'package:flutter/material.dart';
import 'package:tesis/vistas/editar_perfil/editar_correo.dart';
import 'package:tesis/vistas/editar_perfil/editar_sexo.dart';
import 'package:tesis/vistas/editar_perfil/editar_contrasena.dart';
import 'package:tesis/vistas/editar_perfil/editar_nombre.dart';

class EditarPerfil extends StatelessWidget {
  const EditarPerfil({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _fondo(context),
    );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Editar Perfil',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      backgroundColor: Color.fromRGBO(56, 175, 151, 0.8),
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
        children: [_LogoEditarPerfil(context), _subFondo(context)],
      ),
    );
  }

  Widget _LogoEditarPerfil(BuildContext context) {
    return SafeArea(
        child: Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: Image.asset('assets/agregar_publicacion.png',
          alignment: Alignment.topCenter, height: 120),
    ));
  }

  Widget _subFondo(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_descripcionText(context)],
          ),
        ),
      ),
    );
  }

  Widget _descripcionText(BuildContext context) {
    return Form(
        child: Column(
      children: <Widget>[
        const SizedBox(height: 10),
        const Text(
          'Seleccione una opcion para editar su perfil',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 60),
        //_botonEditarNombre(context),
        _botonEditarCorreo(context),
        const SizedBox(height: 25),
        _botonEditarContrasena(context),
        const SizedBox(height: 25),
        _botonEditarSexo(context),
      ],
    ));
  }

  Widget _botonEditarNombre(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const EditarNombre();
        }));
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const StadiumBorder(),
      elevation: 5.0,
      minWidth: 300.0,
      height: 40,
      color: Colors.green,
      child: const Text(
        'nombre del usuario',
        style: TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Widget _botonEditarSexo(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const EditarSexo();
        }));
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const StadiumBorder(),
      elevation: 5.0,
      minWidth: 300.0,
      height: 40,
      color: Colors.green,
      child: const Text(
        'sexo del usuario',
        style: TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Widget _botonEditarCorreo(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const EditarCorreo();
        }));
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const StadiumBorder(),
      elevation: 5.0,
      minWidth: 300.0,
      height: 40,
      color: Colors.green,
      child: const Text(
        'correo del usuario',
        style: TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Widget _botonEditarContrasena(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const EditarContrasena();
        }));
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const StadiumBorder(),
      elevation: 5.0,
      minWidth: 300.0,
      height: 40,
      color: Colors.green,
      child: const Text(
        'contraseña del usuario',
        style: TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
