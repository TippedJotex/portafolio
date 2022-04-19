import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tesis/servicios/servicio_firebase.dart';
import 'package:tesis/validadores/validador.dart';

part 'post_event.dart';
part 'post_state.dart';

class RegistroPublicacionBloc
    extends Bloc<RegistroPublicacionEvent, RegistroPublicacionState> {
  final Database _database;
  RegistroPublicacionBloc({Database databaseRepository})
      : _database = databaseRepository,
        super(RegistroPublicacionState.initial());

  @override
  Stream<RegistroPublicacionState> mapEventToState(
    RegistroPublicacionEvent event,
  ) async* {
    if (event is TituloEvent) {
      yield* _mapRegistroTitulo(event.titulo);
    } else if (event is TipoMascotaEvent) {
      yield* _mapRegistroTipoMascota(event.tipomascota);
    } else if (event is RazaAnimalEvent) {
      yield* _mapRegistroRazaAnimal(event.razaanimal);
    } else if (event is VacunasEvent) {
      yield* _mapRegistroVacunas(event.vacunas);
    } else if (event is EnfermedadesEvent) {
      yield* _mapRegistroEnfermedad(event.enfermedad);
    } else if (event is TipoPublicacionEvent) {
      yield* _mapRegistroTipoPublicacion(event.tipopublicacion);
    } else if (event is DescripcionPublicacionEvent) {
      yield* _mapRegistroDescripcionPublicacion(event.descripcionpublicacion);
    } else if (event is EnviarPublicacion) {
      yield* _mapRegistrarPublicacion(
          event.titulo,
          event.tipomascota,
          event.razaanimal,
          event.vacunas,
          event.enfermedad,
          event.tipopublicacion,
          event.descripcionpublicacion);
    }
  }

  Stream<RegistroPublicacionState> _mapRegistroTitulo(String titulo) async* {
    yield state.TituloEvent(
        TituloPublicacion: Validators.ValidarTitulo(titulo));
  }

  Stream<RegistroPublicacionState> _mapRegistroTipoMascota(
      String tipomascota) async* {
    yield state.TipoMascotaEvent(
        TipoMascota: Validators.EntradaVacia(tipomascota));
  }

  Stream<RegistroPublicacionState> _mapRegistroRazaAnimal(
      String razaanimal) async* {
    yield state.RazaAnimalEvent(
        RazaAnimal: Validators.EntradaVacia(razaanimal));
  }

  Stream<RegistroPublicacionState> _mapRegistroVacunas(String vacunas) async* {
    yield state.VacunasEvent(Vacunas: Validators.EntradaVacia(vacunas));
  }

  Stream<RegistroPublicacionState> _mapRegistroEnfermedad(
      String enfermedad) async* {
    yield state.EnfermedadesEvent(
        Enfermedades: Validators.EntradaVacia(enfermedad));
  }

  Stream<RegistroPublicacionState> _mapRegistroTipoPublicacion(
      String tipopublicacion) async* {
    yield state.TipoPublicacionEvent(
        TipoPublicacion: Validators.EntradaVacia(tipopublicacion));
  }

  Stream<RegistroPublicacionState> _mapRegistroDescripcionPublicacion(
      String descripcionpublicacion) async* {
    yield state.DescripcionPublicacionEvent(
        DescripcionPublicacion:
            Validators.EntradaVacia(descripcionpublicacion));
  }

  Stream<RegistroPublicacionState> _mapRegistrarPublicacion(
      String titulo,
      String tipomascota,
      String razaanimal,
      String vacunas,
      String enfermedad,
      String tipopublicacion,
      String descripcionpublicacion) async* {
    yield RegistroPublicacionState.carga();
    print('Titulo: ${titulo}');
    print('Tipo de mascota: ${tipomascota}');
    print('Raza del animal: ${razaanimal}');
    print('Posee vacunas: ${vacunas}');
    print('Tiene alguna enfermedad: ${enfermedad}');
    print('Tipo de publicacion: ${tipopublicacion}');
    print('Descripcion: ${descripcionpublicacion}');
    try {
      await _database.RegistrarPublicacion(titulo, tipomascota, razaanimal, vacunas,
          enfermedad, tipopublicacion, descripcionpublicacion);
      yield RegistroPublicacionState.completado();
    } catch (e) {
      print('OCURRIO UN ERROR: ${e}');
      yield RegistroPublicacionState.falla();
    }
  }
}

