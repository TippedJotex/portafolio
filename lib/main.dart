import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tesis/Rutas/rutas.dart';
import 'package:tesis/bloc/autenticacion_bloc/bloc/autenticacion_bloc.dart';
import 'package:tesis/bloc/estados_bloc.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/vistas/publicaciones/menu_publicacion/menu_publicaciones.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'bloc/post_bloc/post_bloc.dart';
import 'vistas/login/menu_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = EstadosBloc();
  final Database userRepository = Database();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AutenticacionBloc(
          userRepository: userRepository,
        )..add(AutenticacionComenzada()),
      ),
      BlocProvider(
        create: (context) => RegistroPublicacionBloc(databaseRepository: userRepository)
      ),
    ],
    child: MyApp(
      userRepository: userRepository,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final Database _userRepository;

  MyApp({Database userRepository})
      : _userRepository = userRepository,
        super();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // ignore: prefer_const_literals_to_create_immutables
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        // ignore: prefer_const_literals_to_create_immutables
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('es', 'ES'),
          const Locale.fromSubtags(languageCode: 'zh'),
        ],
        //initialRoute: 'login',
        routes: getAplicacionRutas(),
        title: 'Material App',
        theme: ThemeData(
          primaryColor: Color(0xff6a515e),
        ),
        home: BlocBuilder<AutenticacionBloc, AutenticacionState>(
          builder: (context, state) {
            if (state is AutenticacionFallida) {
              // ignore: prefer_const_constructors
              return MenuLogin(
                userRepository: _userRepository,
              );
            }
            if (state is AutenticacionCompletada) {
              //return Publicaciones()
              return Publicaciones(user: state.usuario);
            }
            return Scaffold(
                appBar: AppBar(),
                body: const Center(
                  child: Text('Cargando'),
                ));
          },
        ));
  }
}

/*
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  get servicio => null;

  @override
  Widget build(BuildContext context) {
      
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ( _ ) => RegistroBloc(),
        ),
        BlocProvider(
          create: ( _ ) => LoginBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: getAplicacionRutas(),
      ),
    );
  }
}


/* save master
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: "login",
      routes: getAplicacionRutas(),
    );

    */

*/


//realizar una ppt
//el 5 (Noviembre) mostrar el codigo desde la ppt mediante un video
//el inicio de sesion ponerle un catchpa o como evitar que no sea un robot el que esta intentando iniciar.