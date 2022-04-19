part of 'post_bloc.dart';

class RegistroPublicacionState {
  final bool TituloPublicacion;
  final bool TipoMascota;
  final bool RazaAnimal;
  final bool Vacunas;
  final bool Enfermedades;
  final bool TipoPublicacion;
  final bool DescripcionPublicacion;
  final bool Envio;
  final bool Completado;
  final bool Falla;

  RegistroPublicacionState(
      {this.TituloPublicacion,
      this.TipoMascota,
      this.RazaAnimal,
      this.Vacunas,
      this.Enfermedades,
      this.TipoPublicacion,
      this.DescripcionPublicacion,
      this.Envio,
      this.Completado,
      this.Falla});

  factory RegistroPublicacionState.initial() {
    return RegistroPublicacionState(
        TituloPublicacion: true,
        TipoMascota: true,
        RazaAnimal: true,
        Vacunas: true,
        Enfermedades: true,
        TipoPublicacion: true,
        DescripcionPublicacion: true,
        Envio: false,
        Completado: false,
        Falla: false);
  }

  factory RegistroPublicacionState.carga() {
    return RegistroPublicacionState(
        TituloPublicacion: true,
        TipoMascota: true,
        RazaAnimal: true,
        Vacunas: true,
        Enfermedades: true,
        TipoPublicacion: true,
        DescripcionPublicacion: true,
        Envio: true,
        Completado: false,
        Falla: false);
  }

  factory RegistroPublicacionState.falla() {
    return RegistroPublicacionState(
        TituloPublicacion: true,
        TipoMascota: true,
        RazaAnimal: true,
        Vacunas: true,
        Enfermedades: true,
        TipoPublicacion: true,
        DescripcionPublicacion: true,
        Envio: false,
        Completado: false,
        Falla: true);
  }

  factory RegistroPublicacionState.completado() {
    return RegistroPublicacionState(
        TituloPublicacion: true,
        TipoMascota: true,
        RazaAnimal: true,
        Vacunas: true,
        Enfermedades: true,
        TipoPublicacion: true,
        DescripcionPublicacion: true,
        Envio: false,
        Completado: true,
        Falla: false);
  }

  RegistroPublicacionState TituloEvent({bool TituloPublicacion}) {
    return Copiar(
        TituloPublicacion: TituloPublicacion,
        TipoMascota: TipoMascota,
        RazaAnimal: RazaAnimal,
        Vacunas: Vacunas,
        Enfermedades: Enfermedades,
        TipoPublicacion: TipoPublicacion,
        DescripcionPublicacion: DescripcionPublicacion,
        Envio: false,
        Completado: false,
        Falla: false);
  }

  RegistroPublicacionState TipoMascotaEvent({bool TipoMascota}) {
    return Copiar(
        TituloPublicacion: TituloPublicacion,
        TipoMascota: TipoMascota,
        RazaAnimal: RazaAnimal,
        Vacunas: Vacunas,
        Enfermedades: Enfermedades,
        TipoPublicacion: TipoPublicacion,
        DescripcionPublicacion: DescripcionPublicacion,
        Envio: false,
        Completado: false,
        Falla: false);
  }

  RegistroPublicacionState RazaAnimalEvent({bool RazaAnimal}) {
    return Copiar(
        TituloPublicacion: TituloPublicacion,
        TipoMascota: TipoMascota,
        RazaAnimal: RazaAnimal,
        Vacunas: Vacunas,
        Enfermedades: Enfermedades,
        TipoPublicacion: TipoPublicacion,
        DescripcionPublicacion: DescripcionPublicacion,
        Envio: false,
        Completado: false,
        Falla: false);
  }

  RegistroPublicacionState VacunasEvent({bool Vacunas}) {
    return Copiar(
        TituloPublicacion: TituloPublicacion,
        TipoMascota: TipoMascota,
        RazaAnimal: RazaAnimal,
        Vacunas: Vacunas,
        Enfermedades: Enfermedades,
        TipoPublicacion: TipoPublicacion,
        DescripcionPublicacion: DescripcionPublicacion,
        Envio: false,
        Completado: false,
        Falla: false);
  }

  RegistroPublicacionState EnfermedadesEvent({bool Enfermedades}) {
    return Copiar(
        TituloPublicacion: TituloPublicacion,
        TipoMascota: TipoMascota,
        RazaAnimal: RazaAnimal,
        Vacunas: Vacunas,
        Enfermedades: Enfermedades,
        TipoPublicacion: TipoPublicacion,
        DescripcionPublicacion: DescripcionPublicacion,
        Envio: false,
        Completado: false,
        Falla: false);
  }

  RegistroPublicacionState TipoPublicacionEvent({bool TipoPublicacion}) {
    return Copiar(
        TituloPublicacion: TituloPublicacion,
        TipoMascota: TipoMascota,
        RazaAnimal: RazaAnimal,
        Vacunas: Vacunas,
        Enfermedades: Enfermedades,
        TipoPublicacion: TipoPublicacion,
        DescripcionPublicacion: DescripcionPublicacion,
        Envio: false,
        Completado: false,
        Falla: false);
  }

  RegistroPublicacionState DescripcionPublicacionEvent(
      {bool DescripcionPublicacion}) {
    return Copiar(
        TituloPublicacion: TituloPublicacion,
        TipoMascota: TipoMascota,
        RazaAnimal: RazaAnimal,
        Vacunas: Vacunas,
        Enfermedades: Enfermedades,
        TipoPublicacion: TipoPublicacion,
        DescripcionPublicacion: DescripcionPublicacion,
        Envio: false,
        Completado: false,
        Falla: false);
  }

  RegistroPublicacionState Copiar(
      {bool TituloPublicacion,
      bool TipoMascota,
      bool RazaAnimal,
      bool Vacunas,
      bool Enfermedades,
      bool TipoPublicacion,
      bool DescripcionPublicacion,
      bool Envio,
      bool Completado,
      bool Falla}) {
    return RegistroPublicacionState(
        TituloPublicacion: TituloPublicacion,
        TipoMascota: TipoMascota,
        RazaAnimal: RazaAnimal,
        Vacunas: Vacunas,
        Enfermedades: Enfermedades,
        TipoPublicacion: TipoPublicacion,
        DescripcionPublicacion: DescripcionPublicacion,
        Envio: Envio,
        Completado: Completado,
        Falla: Falla);
  }

  @override
  List<Object> get props => [];
}
