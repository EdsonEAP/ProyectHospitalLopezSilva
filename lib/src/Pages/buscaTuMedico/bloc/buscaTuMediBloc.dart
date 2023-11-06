import 'dart:async';

import 'package:flutter_application_1/src/Mixins/alerts.dart';
import 'package:flutter_application_1/src/Pages/Services/generalServices.dart';
import 'package:flutter_application_1/src/Pages/buscaTuMedico/Models/buscaTuMedicoModel.dart';
import 'package:flutter_application_1/src/Pages/buscaTuMedico/Services/buscaTuMedicoService.dart';
import 'package:flutter_application_1/src/Pages/misCitas/Models/historialCitaModel.dart';
import 'package:flutter_application_1/src/Pages/misCitas/Services/historialCitaService.dart';
import 'package:flutter_application_1/src/Preferences/preferences.dart';

class BuscaMedicoBloc with Alerts {
  GeneralService generalService = GeneralService();

  final prefs = PreferenciasUsuario();
  BuscarMedicoM buscarMedicoM = BuscarMedicoM();
  BuscaMedicoService buscaMedicoService = BuscaMedicoService();

  StreamController<List<BuscarMedicoM>> buscarCitaHistorialC =
      StreamController.broadcast();
  Stream<List<BuscarMedicoM>> get buscarCitaHistorialS =>
      buscarCitaHistorialC.stream;

  static final BuscaMedicoBloc _instance = BuscaMedicoBloc._internal();
  factory BuscaMedicoBloc() {
    return _instance;
  }

  requestBuscaMedico(context,
      {String? nombres, String? especialidad, String? centro_atencion}) async {
    dynamic response = await buscaMedicoService.buscaMedicoS(
        nombres: nombres ?? "",
        especialidad: especialidad ?? "",
        centro_atencion: centro_atencion ?? "");

    if (response == null || response["status"] == false) {
      showErrorDialog(
          context: context, textContent: response["message"] ?? "Error");

      buscarCitaHistorialC.sink.add([]);

      return;
    }

    if (response["message"] == "No se encontró resultados") {
      showErrorDialog(
          context: context, textContent: "No se encontraron resultados");
      buscarCitaHistorialC.sink.add([]);
      return;
    }

    if (response["status"] == true && response["data"].isNotEmpty) {
      List<BuscarMedicoM> listItems = [];

      for (var item in response["data"]) {
        BuscarMedicoM temp = BuscarMedicoM.fromJson(item);
        listItems.add(temp);
      }

      buscarCitaHistorialC.sink.add(listItems);
    }
  }

  requestComboEspecialidad(
    context,
  ) async {
    dynamic response = await generalService.comboEspecialidades();

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
      List<BuscarMedicoM> listItems = [];

      for (var item in response["data"]) {
        BuscarMedicoM temp = BuscarMedicoM.fromJson(item);
        listItems.add(temp);
      }

      buscarCitaHistorialC.sink.add(listItems);
    }
  }

  dispose() {
    buscarCitaHistorialC.close();
  }

  BuscaMedicoBloc._internal();
}
