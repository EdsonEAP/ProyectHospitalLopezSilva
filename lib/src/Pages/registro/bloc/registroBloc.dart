///Import Flutter

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/Mixins/alerts.dart';
import 'package:flutter_application_1/src/Pages/homeView/home.dart';
import 'package:flutter_application_1/src/Pages/login/Models/loginModel.dart';
import 'package:flutter_application_1/src/Pages/login/Services/loginServices.dart';
import 'package:flutter_application_1/src/Pages/login/vistalongin.dart';
import 'package:flutter_application_1/src/Pages/registro/Services/registroServices.dart';
import 'dart:convert';

import 'package:flutter_application_1/src/Preferences/preferences.dart';

class RegisterBloc with Alerts {
  RegisterService registerService = RegisterService();

  StreamController<String> botonRegisterC =
      StreamController<String>.broadcast();
  Stream<String> get botonRegisterS => botonRegisterC.stream;

  final prefs = PreferenciasUsuario();

  static final RegisterBloc _instance = RegisterBloc._internal();
  factory RegisterBloc() {
    return _instance;
  }

  requestRegister(context,
      {String? email,
      String? address,
      String? age,
      String? phone,
      String? document,
      String? surnames,
      String? first_name,
      String? second_name,
      String? type_document,
      String? terms,
      String? type_sure,
      String? gender,
      String? password,
      String? fecha_nacimiento}) async {
    botonRegisterC.sink.add("ERROR");
    dynamic response = await registerService.registerS(
        password: password ?? "",
        fecha_nacimiento: fecha_nacimiento ?? "",
        address: address ?? "",
        age: age ?? "",
        phone: phone ?? "",
        document: document ?? "",
        surnames: surnames ?? "",
        first_name: first_name ?? "",
        second_name: second_name ?? "",
        type_document: type_document ?? "",
        terms: terms ?? "",
        type_sure: type_sure ?? "",
        gender: gender ?? "",
        email: email ?? "");

    if (response == null || response["status"] == false) {
      botonRegisterC.sink.add("REGISTRAR");
      showErrorDialog(
          context: context, textContent: response["message"] ?? "Error");
      return;
    }

    if (response["status"] == true) {
      await showErrorDialog(context: context, textContent: response["message"]);
      botonRegisterC.sink.add("REGISTRAR");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginView(),
          ));
    }
  }

  dispose() {
    botonRegisterC.close();
  }

  RegisterBloc._internal();
}
