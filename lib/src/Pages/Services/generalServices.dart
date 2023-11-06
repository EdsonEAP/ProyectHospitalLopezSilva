import 'package:flutter_application_1/src/Pages/login/Models/loginModel.dart';
import 'package:flutter_application_1/src/Utils/ineternet.dart';

class GeneralService {
  Future comboHospital() async {
    var response =
        await Internet.httpGet(url: "http://10.0.2.2:8000/centros", body: "");
    print("Request....");
    print("Result....$response");

    return response;
  }

  Future comboEspecialidades() async {
    var response = await Internet.httpGet(
        url: "http://10.0.2.2:8000/especialidades", body: "");
    print("Request....");
    print("Result....$response");

    return response;
  }

  Future comboDoctores() async {
    var response =
        await Internet.httpGet(url: "http://10.0.2.2:8000/doctor", body: "");
    print("Request....");
    print("Result....$response");

    return response;
  }
}
