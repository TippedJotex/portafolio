import 'package:flutter_bloc/flutter_bloc.dart';

class EstadosBloc extends BlocObserver {

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('********************************************************************************************************************************');
    print('*ESTADO: ${transition} *');
    print('********************************************************************************************************************************');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('********************************************************************************************************************************');
    print('*ESTADO ERROR: ${error}');
    print('********************************************************************************************************************************');
  }
}
