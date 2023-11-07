class BuscarMedicoM {
  String? nombres;
  Null? imagen;
  String? cargo;
  String? especialidad;
  String? centroAtencion;
  String? titulo;
  Null? premios;
  String? sociedad;
  //Horarios? horarios;

  BuscarMedicoM({
    this.nombres,
    this.imagen,
    this.cargo,
    this.especialidad,
    this.centroAtencion,
    this.titulo,
    this.premios,
    this.sociedad,
    // this.horarios
  });

  BuscarMedicoM.fromJson(Map<String, dynamic> json) {
    nombres = json['nombres'];
    imagen = json['imagen'];
    cargo = json['cargo'];
    especialidad = json['especialidad'];
    centroAtencion = json['centro_atencion'];
    titulo = json['titulo'];
    premios = json['premios'];
    sociedad = json['sociedad'];
    // horarios = json['horarios'] != null
    //     ? new Horarios.fromJson(json['horarios'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombres'] = this.nombres;
    data['imagen'] = this.imagen;
    data['cargo'] = this.cargo;
    data['especialidad'] = this.especialidad;
    data['centro_atencion'] = this.centroAtencion;
    data['titulo'] = this.titulo;
    data['premios'] = this.premios;
    data['sociedad'] = this.sociedad;
    // if (this.horarios != null) {
    //   data['horarios'] = this.horarios!.toJson();
    // }
    return data;
  }
}

// class Horarios {
//   List<int>? lunes30;
//   List<int>? martes31;

//   Horarios({this.lunes30, this.martes31});

//   Horarios.fromJson(Map<String, dynamic> json) {
//     lunes30 = json['Lunes 30'].cast<int>();
//     martes31 = json['Martes 31'].cast<int>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Lunes 30'] = this.lunes30;
//     data['Martes 31'] = this.martes31;
//     return data;
//   }
// }
