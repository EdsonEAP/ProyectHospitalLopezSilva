import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/Pages/buscaTuMedico/Page/InfoMedico/infoMedicoView.dart';
import 'package:flutter_application_1/src/Pages/buscaTuMedico/buscaTuMedico.dart';
import 'package:flutter_application_1/src/Pages/citaPresencial/citaPresencial.dart';
import 'package:flutter_application_1/src/Pages/homeView/home.dart';
import 'package:flutter_application_1/src/Pages/login/vistalongin.dart';
import 'package:flutter_application_1/src/Pages/misCitas/misCitas.dart';
import 'package:flutter_application_1/src/Pages/registro/registro.dart';
import 'package:flutter_application_1/src/Pages/terminosRegister/terminosRegister.dart';
import 'package:flutter_application_1/src/Pages/terminosYCondiciones/terminosYCondicionesView.dart';
import 'package:flutter_application_1/src/Pages/ubicanos/ubicanos.dart';

abstract class Routes {
  static Map<String, WidgetBuilder> rutas = {
    LoginView.name: ((context) => const LoginView()),
    RegistroView.name: ((context) => const RegistroView()),
    HomeView.name: ((context) => const HomeView()),
    CitaPresencialView.name: ((context) => const CitaPresencialView()),
    BuscaTuMedicoView.name: ((context) => const BuscaTuMedicoView()),
    MisCitasView.name: ((context) => const MisCitasView()),
    UbicanosView.name: ((context) => const UbicanosView()),
    TerminosYCondicionesView.name: ((context) =>
        const TerminosYCondicionesView()),
    TerminosRegister.name: ((context) => const TerminosRegister()),
    InfoMedicoView.name: ((context) => InfoMedicoView()),
  };
}
