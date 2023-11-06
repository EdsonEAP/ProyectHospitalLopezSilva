import 'package:flutter_application_1/src/Utils/ineternet.dart';

class CitaPresencialService {
  Future buscaMedicoS(
      {required String medico,
      required String especialidad,
      required String centro_atencion}) async {
    Map<String, dynamic> body = {
      "nombres": medico,
      "especialidad": especialidad,
      "centro_atencion": centro_atencion
    };
    print("Send data Service-->loginS--> body$body");
    var response = await Internet.httpPostcook(
        url: "http://10.0.2.2:8000/api/doctors/search", body: body);
    print("Result....$response");
    //LoginM.fromJson(response);

    return response;
  }

  Future registrarCita(
      {required String document,
      required String nombre,
      required String medico,
      required String medico_nombre,
      required String date,
      required String especiality,
      required String email,
      required String horario,
      required String lugar}) async {
    Map<String, dynamic> body = {
      "document": document,
      "nombre": nombre,
      "medico": medico,
      "medico_nombre": medico_nombre,
      "date": date,
      "especiality": especiality,
      "email": email,
      "horario": horario,
      "lugar": lugar
    };
    print("Send data Service-->loginS--> body$body");
    var response = await Internet.httpPostcook(
        url: "http://10.0.2.2:8000/cita", body: body);
    print("Result....$response");
    //LoginM.fromJson(response);

    return response;
  }
}
