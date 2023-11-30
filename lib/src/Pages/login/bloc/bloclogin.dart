///Import Flutter

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/Mixins/alerts.dart';
import 'package:flutter_application_1/src/Pages/homeView/home.dart';
import 'package:flutter_application_1/src/Pages/login/Models/loginModel.dart';
import 'package:flutter_application_1/src/Pages/login/Services/loginServices.dart';
import 'dart:convert';

import 'package:flutter_application_1/src/Preferences/preferences.dart';

class LoginBloc with Alerts {
  LoginM modelLogin = LoginM();
  LoginService loginService = LoginService();

  StreamController<String> botonLoginC = StreamController<String>.broadcast();
  Stream<String> get botonLoginS => botonLoginC.stream;

  final prefs = PreferenciasUsuario();

  static final LoginBloc _instance = LoginBloc._internal();
  factory LoginBloc() {
    return _instance;
  }

  final String hola = "hola";

  requestLogin(context, {String? user, String? pass}) async {
    botonLoginC.sink.add("ERROR");
    dynamic response =
        await loginService.loginS(user: user ?? "", pass: pass ?? "");
    if (response == null || response["status"] == false) {
      botonLoginC.sink.add("INGRESAR");
      showErrorDialog(
          context: context, textContent: response["message"] ?? "Error");
      return;
    }

    if (response["status"] == true) {
      var data = response["data"];
      print("pruebaaaaaaaaaaaaaaaaaaaaaaaaa");

      List<LoginM> listItems = [];
      List<dynamic> miLista2 = [];

      for (var clave in response["data"].keys) {
        var valor = response["data"][clave];
        print("$clave: $valor");
        miLista2.add({clave.toString(): valor});
      }

      for (var item in miLista2) {
        LoginM temp = LoginM.fromJson(item);
        listItems.add(temp);
      }
      LoginM temps = LoginM.fromJson(response["data"]);

      prefs.nombreUsuario =
          (temps.firstName ?? "") + " " + (temps.surnames ?? "");
      prefs.documentoDni = temps.document ?? "";
      prefs.correo = temps.email ?? "";

      botonLoginC.sink.add("INGRESAR");
      Navigator.pushReplacementNamed(context, HomeView.name);
    }
  }

  dispose() {
    botonLoginC.close();
  }

  LoginBloc._internal();
}
