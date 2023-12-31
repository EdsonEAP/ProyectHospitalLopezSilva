import 'package:flutter_application_1/src/Pages/login/Models/loginModel.dart';
import 'package:flutter_application_1/src/Utils/ineternet.dart';

class RegisterService {
  Future registerS(
      {required String email,
      required String address,
      required String age,
      required String phone,
      required String document,
      required String surnames,
      required String first_name,
      required String second_name,
      required String type_document,
      required String terms,
      required String type_sure,
      required String gender,
      required String fecha_nacimiento,
      required String password}) async {
    Map<String, dynamic> body = {
      "document": document,
      "first_name": first_name,
      "second_name": second_name,
      "surnames": surnames,
      "gender": gender,
      "email": email,
      "phone": phone,
      "age": age,
      "address": address,
      "terms": terms,
      "type_document": type_document,
      "type_sure": type_sure,
      "fecha_nacimiento": fecha_nacimiento,
      "password": password
    };
    print("Send data Service-->loginS--> body$body");
    var response = await Internet.httpPostcook(
        url: "http://167.172.17.215/user", body: body);
    print("Request....");
    print("Result....$response");

    return response;
  }
}
