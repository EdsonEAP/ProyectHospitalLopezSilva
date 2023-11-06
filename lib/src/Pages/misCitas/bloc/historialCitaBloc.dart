import 'dart:async';

import 'package:flutter_application_1/src/Mixins/alerts.dart';
import 'package:flutter_application_1/src/Pages/misCitas/Models/historialCitaModel.dart';
import 'package:flutter_application_1/src/Pages/misCitas/Services/historialCitaService.dart';
import 'package:flutter_application_1/src/Preferences/preferences.dart';

class HistorialCitaBloc with Alerts {
  HistorialClienteM historialClienteM = HistorialClienteM();
  HistorialClienteM modelLogin = HistorialClienteM();
  HistorialCitaService historialCitaService = HistorialCitaService();
  final prefs = PreferenciasUsuario();

  StreamController<List<HistorialClienteM>> buscarCitaHistorialC =
      StreamController.broadcast();
  Stream<List<HistorialClienteM>> get buscarCitaHistorialS =>
      buscarCitaHistorialC.stream;

  static final HistorialCitaBloc _instance = HistorialCitaBloc._internal();
  factory HistorialCitaBloc() {
    return _instance;
  }

  requestHistorialCita(context, {String? dni}) async {
    dynamic response =
        await historialCitaService.historialClienteS(dni: dni ?? "");
    if (response == null || response["status"] == false) {
      showErrorDialog(
          context: context, textContent: response["message"] ?? "Error");

      buscarCitaHistorialC.sink.add([]);

      return;
    }
    if (response["data"].isEmpty) {
      // showErrorDialog(context: context, textContent: "No se encontraron citas");
      buscarCitaHistorialC.sink.add([]);
      return;
    }
    if (response["status"] == true && response["data"].isNotEmpty) {
      List<HistorialClienteM> listItems = [];

      for (var item in response["data"]) {
        HistorialClienteM temp = HistorialClienteM.fromJson(item);
        listItems.add(temp);
      }

      buscarCitaHistorialC.sink.add(listItems);
    }
  }

  dispose() {
    buscarCitaHistorialC.close();
  }

  HistorialCitaBloc._internal();
}
