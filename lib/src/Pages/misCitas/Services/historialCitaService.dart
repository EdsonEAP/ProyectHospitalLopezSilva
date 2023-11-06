import 'package:flutter_application_1/src/Utils/ineternet.dart';

class HistorialCitaService {
  Future historialClienteS({required String dni}) async {
    Map<String, dynamic> body = {"document": dni};
    print("Send data Service-->loginS--> body$body");
    var response = await Internet.httpPostcook(
        url: "http://10.0.2.2:8000/api/cita/historial", body: body);
    print("Request....");
    print("Result....$response");
    //LoginM.fromJson(response);

    return response;
  }
}
