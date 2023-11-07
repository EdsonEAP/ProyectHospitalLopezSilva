import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/Pages/buscaTuMedico/buscaTuMedico.dart';
import 'package:flutter_application_1/src/Pages/citaPresencial/citaPresencial.dart';
import 'package:flutter_application_1/src/Pages/homeView/home.dart';
import 'package:flutter_application_1/src/Pages/login/vistalongin.dart';
import 'package:flutter_application_1/src/Pages/misCitas/misCitas.dart';
import 'package:flutter_application_1/src/Pages/terminosYCondiciones/terminosYCondicionesView.dart';
import 'package:flutter_application_1/src/Pages/ubicanos/ubicanos.dart';
import 'package:flutter_application_1/src/Preferences/preferences.dart';

final prefs = PreferenciasUsuario();

class DrawerGeneral {
  ListView drawerGeneral(Size size, BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 100,
          child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              child: Container(
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  SizedBox(width: size.width * 0.15),
                  Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: 200,
                    child: Text(
                      prefs.nombreUsuario,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Roboto',
                        color: Color(0xFF212121),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ]),
              )),
        ),
        ListTile(
          leading: Icon(
            Icons.home,
            color: Colors.white,
          ),
          title: Text(
            'INICIO',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, HomeView.name);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.date_range,
            color: Colors.white,
          ),
          title: Text(
            'CITA PRESENCIAL',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, CitaPresencialView.name);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.search,
            color: Colors.white,
          ),
          title: Text(
            'BUSCA TU MÉDICO',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, BuscaTuMedicoView.name);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.event,
            color: Colors.white,
          ),
          title: Text(
            'MIS CITAS',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, MisCitasView.name);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.location_on,
            color: Colors.white,
          ),
          title: Text(
            'UBICANOS',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, UbicanosView.name);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.description,
            color: Colors.white,
          ),
          title: Text(
            'TÉRMINOS Y CONDICIONES',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(
                context, TerminosYCondicionesView.name);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
          title: Text(
            'CERRAR SESIÓN',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            prefs.busquedaEspecialidadDoctor = "";
            prefs.busquedaLugarDoctor = "";
            prefs.busquedaNombreDoctor = "";
            prefs.documentoDni = "";
            prefs.correo = "";
            Navigator.pushReplacementNamed(context, LoginView.name);
          },
        ),
      ],
    );
  }
}
