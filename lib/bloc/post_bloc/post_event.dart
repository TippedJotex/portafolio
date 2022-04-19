part of 'post_bloc.dart';

abstract class RegistroPublicacionEvent extends Equatable {
  const RegistroPublicacionEvent();

  @override
  List<Object> get props => [];
}

class TituloEvent extends RegistroPublicacionEvent {
  final String titulo;
  const TituloEvent({this.titulo});

  @override
  List<Object> get props => [titulo];
}

class TipoMascotaEvent extends RegistroPublicacionEvent {
  final String tipomascota;
  const TipoMascotaEvent({this.tipomascota});

  @override
  List<Object> get props => [tipomascota];
}

class RazaAnimalEvent extends RegistroPublicacionEvent {
  final String razaanimal;
  const RazaAnimalEvent({this.razaanimal});

  @override
  List<Object> get props => [razaanimal];
}

class VacunasEvent extends RegistroPublicacionEvent {
  final String vacunas;
  const VacunasEvent({this.vacunas});

  @override
  List<Object> get props => [vacunas];
}

class EnfermedadesEvent extends RegistroPublicacionEvent {
  final String enfermedad;
  const EnfermedadesEvent({this.enfermedad});

  @override
  List<Object> get props => [enfermedad];
}

class TipoPublicacionEvent extends RegistroPublicacionEvent {
  final String tipopublicacion;
  const TipoPublicacionEvent({this.tipopublicacion});

  @override
  List<Object> get props => [tipopublicacion];
}

class DescripcionPublicacionEvent extends RegistroPublicacionEvent {
  final String descripcionpublicacion;
  const DescripcionPublicacionEvent({this.descripcionpublicacion});

  @override
  List<Object> get props => [descripcionpublicacion];
}

class EnviarPublicacion extends RegistroPublicacionEvent {
  final String titulo;
  final String tipomascota;
  final String razaanimal;
  final String vacunas;
  final String enfermedad;
  final String tipopublicacion;
  final String descripcionpublicacion;
  const EnviarPublicacion(
      {this.titulo,
      this.tipomascota,
      this.razaanimal,
      this.vacunas,
      this.enfermedad,
      this.tipopublicacion,
      this.descripcionpublicacion});

  @override
  List<Object> get props => [
        titulo,
        tipomascota,
        razaanimal,
        vacunas,
        enfermedad,
        tipopublicacion,
        descripcionpublicacion
      ];
}
