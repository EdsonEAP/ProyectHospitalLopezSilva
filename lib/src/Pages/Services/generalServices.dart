import 'package:flutter_application_1/src/Pages/login/Models/loginModel.dart';
import 'package:flutter_application_1/src/Utils/ineternet.dart';

class GeneralService {
  Future comboHospital() async {
    var response =
        await Internet.httpGet(url: "http://167.172.17.215/centros", body: "");
    print("Request....");
    print("Result....$response");

    return response;
  }

  Future comboEspecialidades() async {
    var response = await Internet.httpGet(
        url: "http://167.172.17.215/especialidades", body: "");
    print("Request....");
    print("Result....$response");

    return response;
  }

  Future comboDoctores() async {
    var response =
        await Internet.httpGet(url: "http://167.172.17.215/doctor", body: "");
    print("Request....");
    print("Result....$response");

    return response;
  }
}
