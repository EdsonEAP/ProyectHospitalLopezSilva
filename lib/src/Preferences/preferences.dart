import 'package:flutter_application_1/src/Pages/login/vistalongin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }
  SharedPreferences? _prefs;
  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  //Ed

  bool get guardadoUserAndPassword {
    return _prefs?.getBool('guardadoUserAndPassword') ?? false;
  }

  set guardadoUserAndPassword(bool value) {
    _prefs?.setBool('guardadoUserAndPassword', value);
  }

  String get nombreUsuario {
    return _prefs?.getString('nombreUsuario') ?? '';
  }

  set nombreUsuario(String value) {
    _prefs?.setString('nombreUsuario', value);
  }

  String get documentoDni {
    return _prefs?.getString('documentoDni') ?? '';
  }

  set documentoDni(String value) {
    _prefs?.setString('documentoDni', value);
  }

  String get correo {
    return _prefs?.getString('correo') ?? '';
  }

  set correo(String value) {
    _prefs?.setString('correo', value);
  }

  String get busquedaNombreDoctor {
    return _prefs?.getString('busquedaNombreDoctor') ?? '';
  }

  set busquedaNombreDoctor(String value) {
    _prefs?.setString('busquedaNombreDoctor', value);
  }

  String get busquedaEspecialidadDoctor {
    return _prefs?.getString('busquedaEspecialidadDoctor') ?? '';
  }

  set busquedaEspecialidadDoctor(String value) {
    _prefs?.setString('busquedaEspecialidadDoctor', value);
  }

  String get busquedaLugarDoctor {
    return _prefs?.getString('busquedaLugarDoctor') ?? '';
  }

  set busquedaLugarDoctor(String value) {
    _prefs?.setString('busquedaLugarDoctor', value);
  }

  PreferenciasUsuario._internal();
}
