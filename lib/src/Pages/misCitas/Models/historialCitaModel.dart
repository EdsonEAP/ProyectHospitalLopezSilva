class HistorialClienteM {
  String? pacienteNombre;
  String? document;
  String? medicoNombre;
  String? especiality;
  String? lugar;
  String? fecha;
  String? estadoCita;
  static final HistorialClienteM _instance = HistorialClienteM._internal();
  factory HistorialClienteM() {
    return _instance;
  }
  // HistorialClienteM(
  //     {this.pacienteNombre,
  //     this.document,
  //     this.medicoNombre,
  //     this.especiality,
  //     this.lugar,
  //     this.fecha,
  //     this.estadoCita});

  HistorialClienteM.fromJson(Map<String, dynamic> json) {
    pacienteNombre = json['paciente_nombre'];
    document = json['document'];
    medicoNombre = json['medico_nombre'];
    especiality = json['especiality'];
    lugar = json['lugar'];
    fecha = json['fecha'];
    estadoCita = json['estado_cita'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paciente_nombre'] = this.pacienteNombre;
    data['document'] = this.document;
    data['medico_nombre'] = this.medicoNombre;
    data['especiality'] = this.especiality;
    data['lugar'] = this.lugar;
    data['fecha'] = this.fecha;
    data['estado_cita'] = this.estadoCita;
    return data;
  }

  HistorialClienteM._internal();
}
