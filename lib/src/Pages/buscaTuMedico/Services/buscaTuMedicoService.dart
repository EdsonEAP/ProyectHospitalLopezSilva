import 'package:flutter_application_1/src/Utils/ineternet.dart';

class BuscaMedicoService {
  Future buscaMedicoS(
      {required String nombres,
      required String especialidad,
      required String centro_atencion}) async {
    Map<String, dynamic> body = {
      "nombres": nombres,
      "especialidad": especialidad,
      "centro_atencion": centro_atencion
    };
    print("Send data Service-->loginS--> body$body");
    var response = await Internet.httpPostcook(
        url: "http://10.0.2.2:8000/api/doctors/search", body: body);
    print("Request....");
    print("Result....$response");
    //LoginM.fromJson(response);

    return response;
  }
}
