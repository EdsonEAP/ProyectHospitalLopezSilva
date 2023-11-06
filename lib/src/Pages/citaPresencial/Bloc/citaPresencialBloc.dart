import 'dart:convert';

import 'package:flutter_application_1/src/Mixins/alerts.dart';
import 'package:flutter_application_1/src/Pages/Services/generalServices.dart';
import 'package:flutter_application_1/src/Pages/buscaTuMedico/Models/buscaTuMedicoModel.dart';
import 'dart:async';

import 'package:flutter_application_1/src/Pages/citaPresencial/Services/citaPresencialServices.dart';

class CitaPresencialBloc with Alerts {
  GeneralService generalServices = GeneralService();

  StreamController<String> citaPresencialC =
      StreamController<String>.broadcast();
  Stream<String> get citaPresencialS => citaPresencialC.stream;

  StreamController<String> buscarCitaHistorialC =
      StreamController<String>.broadcast();
  Stream<String> get buscarCitaHistorials => buscarCitaHistorialC.stream;

  StreamController<String> buscarHorarioMedicoC =
      StreamController<String>.broadcast();
  Stream<String> get buscarHorarioMedicoS => buscarHorarioMedicoC.stream;

  StreamController<List<String>> listadoMedicC =
      StreamController<List<String>>.broadcast();
  Stream<List<String>> get listadoMedicS => listadoMedicC.stream;

  static final CitaPresencialBloc _instance = CitaPresencialBloc._internal();
  CitaPresencialService buscaMedicoService = CitaPresencialService();

  factory CitaPresencialBloc() {
    return _instance;
  }
  requestBuscaMedico(context,
      {String? medico, String? especialidad, String? centro_atencion}) async {
    dynamic response = await buscaMedicoService.buscaMedicoS(
        medico: medico ?? "",
        especialidad: especialidad ?? "",
        centro_atencion: centro_atencion ?? "");

    if (response == null || response["status"] == false) {
      showErrorDialog(
          context: context, textContent: response["message"] ?? "Error");

      buscarCitaHistorialC.sink.add("error");

      return;
    }

    if (response["data"].isEmpty) {
      buscarCitaHistorialC.sink.add("error");

      return;
    }

    if (response["status"] == true && response["data"].isNotEmpty) {
      List<String> nombresList = [];

      if (response.containsKey("data")) {
        List<dynamic> dataList = response["data"];
        for (var entry in dataList) {
          if (entry.containsKey("nombres")) {
            String nombres = entry["nombres"];
            nombresList.add(nombres);
          }
        }
      }
      buscarCitaHistorialC.sink.add("correcto");

      return nombresList;

      // print("eddddddddddy");
      // print(response["data"][0]["horarios"]);
      // List<String> formattedHorarios = [];

      // response["data"][0]["horarios"].forEach((dia, horas) {
      //   horas.forEach((hora) {
      //     formattedHorarios.add('$dia: $hora');
      //   });
      // });

      // print(formattedHorarios);

      // buscarCitaHistorialC.sink.add('correcto');
      // return formattedHorarios;
    }
  }

  requestHorarioMedico(context,
      {String? medico, String? especialidad, String? centro_atencion}) async {
    dynamic response = await buscaMedicoService.buscaMedicoS(
        medico: medico ?? "",
        especialidad: especialidad ?? "",
        centro_atencion: centro_atencion ?? "");

    if (response == null || response["status"] == false) {
      showErrorDialog(
          context: context, textContent: response["message"] ?? "Error");

      buscarHorarioMedicoC.sink.add("error");
      listadoMedicC.sink.add([]);
      return;
    }

    if (response["data"].isEmpty) {
      buscarHorarioMedicoC.sink.add("error");
      listadoMedicC.sink.add([]);
      return;
    }

    if (response["status"] == true && response["data"].isNotEmpty) {
      print("eddddddddddy");
      List<String> formattedHorarios = [];

      response["data"][0]["horarios"].forEach((dia, horas) {
        horas.forEach((hora) {
          formattedHorarios.add('$dia: $hora');
        });
      });

      print(formattedHorarios);

      buscarHorarioMedicoC.sink.add('correcto');
      listadoMedicC.sink.add(formattedHorarios);
      return formattedHorarios;
    }
  }

  registerCitaPresencial(context,
      {String? document,
      String? nombre,
      String? medico,
      String? medico_nombre,
      String? date,
      String? especiality,
      String? email,
      String? horario,
      String? lugar}) async {
    dynamic response = await buscaMedicoService.registrarCita(
        document: document ?? "",
        nombre: nombre ?? "",
        medico: medico ?? "",
        medico_nombre: medico_nombre ?? "",
        date: date ?? "",
        especiality: especiality ?? "",
        email: email ?? "",
        horario: horario ?? "",
        lugar: lugar ?? "");

    if (response == null || response["status"] == false) {
      showErrorDialog(
          context: context, textContent: response["message"] ?? "Error");

      return;
    }

    if (response["data"].isEmpty) {
      showErrorDialog(context: context, textContent: "Error");
      return;
    }

    if (response["status"] == true && response["data"].isNotEmpty) {
      print("enviandoooooooooooooooo");
      showErrorDialog(
          context: context, textContent: response["message"] ?? "Error");

      return;
    }
  }

  requestComboLugar() async {
    dynamic response = await generalServices.comboHospital();
    if (response == null) return;
    if (response["status"] == false) {
      citaPresencialC.sink.add("error");
      return [];
    }
    List<String> centros = [];

    if (response["status"] == true) {
      centros = [for (var data in response["data"]) data["centro"]];
      citaPresencialC.sink.add("correcto");
      return centros;
    }
  }

  requestCombosEspecialidades() async {
    dynamic response = await generalServices.comboEspecialidades();
    if (response == null) return;
    if (response["status"] == false) {
      citaPresencialC.sink.add("error");
      return [];
    }
    List<String> centros = [];

    if (response["status"] == true) {
      centros = [for (var data in response["data"]) data["especialidad"]];
      citaPresencialC.sink.add("correcto");
      return centros;
    }
  }

  dispose() {
    citaPresencialC.close();
    buscarCitaHistorialC.close();
    buscarHorarioMedicoC.close();
  }

  CitaPresencialBloc._internal();
}
