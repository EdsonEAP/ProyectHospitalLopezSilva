import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/Pages/homeView/home.dart';
import 'package:flutter_application_1/src/Pages/registro/registro.dart';
import 'package:flutter_application_1/src/Preferences/preferences.dart';
import 'package:flutter_application_1/src/Routes/routes.dart';
import 'src/Pages/login/vistalongin.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    runApp(const MyApp());
  }, (Object error, StackTrace stack) async {});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.red,
      debugShowCheckedModeBanner: false,
      title: 'Recursos Humanos',
      initialRoute: LoginView.name,
      routes: Routes.rutas,
    );
  }
}
