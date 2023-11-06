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
          height: 100, // Ajusta la altura del DrawerHeader aquí
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
            Icons.home, // Icono de una casa
            color: Colors.white, // Color del icono
          ),
          title: Text(
            'INICIO',
            style: TextStyle(
              color: Colors.white, // Color del texto
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, HomeView.name);

            // Aquí puedes agregar acciones para la opción 1
          },
        ),
        ListTile(
          leading: Icon(
            Icons.date_range, // Icono de una casa
            color: Colors.white, // Color del icono
          ),
          title: Text(
            'CITA PRESENCIAL',
            style: TextStyle(
              color: Colors.white, // Color del texto
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, CitaPresencialView.name);
            // Aquí puedes agregar acciones para la opción 1
          },
        ),
        ListTile(
          leading: Icon(
            Icons.search, // Icono de una casa
            color: Colors.white, // Color del icono
          ),
          title: Text(
            'BUSCA TU MÉDICO',
            style: TextStyle(
              color: Colors.white, // Color del texto
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, BuscaTuMedicoView.name);
            // Aquí puedes agregar acciones para la opción 1
          },
        ),
        ListTile(
          leading: Icon(
            Icons.event, // Icono de una casa
            color: Colors.white, // Color del icono
          ),
          title: Text(
            'MIS CITAS',
            style: TextStyle(
              color: Colors.white, // Color del texto
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, MisCitasView.name);
            // Aquí puedes agregar acciones para la opción 1
          },
        ),
        ListTile(
          leading: Icon(
            Icons.location_on, // Icono de una casa
            color: Colors.white, // Color del icono
          ),
          title: Text(
            'UBICANOS',
            style: TextStyle(
              color: Colors.white, // Color del texto
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, UbicanosView.name);
            // Aquí puedes agregar acciones para la opción 1
          },
        ),
        ListTile(
          leading: Icon(
            Icons.description, // Icono de una casa
            color: Colors.white, // Color del icono
          ),
          title: Text(
            'TÉRMINOS Y CONDICIONES',
            style: TextStyle(
              color: Colors.white, // Color del texto
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(
                context, TerminosYCondicionesView.name);
            // Aquí puedes agregar acciones para la opción 1
          },
        ),
        ListTile(
          leading: Icon(
            Icons.exit_to_app, // Icono de una casa
            color: Colors.white, // Color del icono
          ),
          title: Text(
            'CERRAR SESIÓN',
            style: TextStyle(
              color: Colors.white, // Color del texto
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
          onTap: () {
            prefs.busquedaEspecialidadDoctor = "";
            prefs.busquedaLugarDoctor = "";
            prefs.busquedaNombreDoctor = "";
            prefs.documentoDni = "";
            prefs.correo = "";
            Navigator.pushReplacementNamed(context, LoginView.name);
            // Aquí puedes agregar acciones para la opción 1
          },
        ),
      ],
    );
  }
}
