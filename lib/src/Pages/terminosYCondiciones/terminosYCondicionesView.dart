import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/widget/classGeneral.dart';
import 'package:flutter_application_1/src/widget/drawer.dart';

TextEditingController userController = TextEditingController();
TextEditingController passController = TextEditingController();
int animated = 1;

class TerminosYCondicionesView extends StatefulWidget {
  static const String name = "TerminosYCondicionesView";

  const TerminosYCondicionesView({Key? key}) : super(key: key);

  @override
  _TerminosYCondicionesViewState createState() =>
      _TerminosYCondicionesViewState();
}

class _TerminosYCondicionesViewState extends State<TerminosYCondicionesView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 171, 211, 224),
        title: Center(
          child: Container(
            margin: EdgeInsets.only(right: 50),
            child: Image.asset(
              'assets/icon/logofarmacia.png',
              width: 50,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        actions: [Row(children: [])],
      ),
      drawer: Drawer(
        backgroundColor: General.colorApp,
        child: DrawerGeneral().drawerGeneral(size, context),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Opacity(
                opacity: 0.5,
                child: Container(
                  color: General.grissApp,
                  height: size.height * 0.05,
                  width: size.width,
                  child: Center(
                    child: Text(
                      "TERMINOS Y CONDICIONES",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bienvenido a la aplicación móvil de la C.M.I CÉSAR LÓPEZ SILVA. Los siguientes términos y condiciones rigen el uso de esta aplicación. Al utilizar esta aplicación, aceptas cumplir con estos términos y condiciones. Si no estás de acuerdo con alguno de estos términos, te pedimos que no utilices la aplicación.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "1. Propósito de la Aplicación:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "La aplicación móvil de la C.M.I CÉSAR LÓPEZ SILVA tiene como objetivo proporcionar a los usuarios acceso a información sobre los servicios ofrecidos por la C.M.I, así como la posibilidad de realizar citas, acceder a resultados de exámenes y otras funcionalidades relacionadas con la atención médica.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "2. Información y Contenido:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "La información proporcionada en esta aplicación tiene fines informativos y educativos y no debe ser considerada como asesoramiento médico. Siempre se recomienda consultar a un profesional de la salud calificado para obtener diagnósticos y tratamientos específicos.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "3. Responsabilidad del Usuario:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "El usuario es responsable de la veracidad y precisión de la información proporcionada durante el uso de la aplicación. Cualquier uso indebido de la aplicación o violación de estos términos y condiciones puede dar lugar a la suspensión o terminación de la cuenta del usuario.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "4. Privacidad y Protección de Datos:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "La C.M.I CÉSAR LÓPEZ SILVA se compromete a proteger la privacidad y seguridad de la información proporcionada por los usuarios. Consulta nuestra Política de Privacidad para obtener más detalles sobre cómo manejamos tus datos.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "5. Propiedad Intelectual:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Todos los derechos de propiedad intelectual relacionados con la aplicación, incluyendo pero no limitado a marcas registradas, derechos de autor y diseños, son propiedad exclusiva de la C.M.I CÉSAR LÓPEZ SILVA.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "6. Cambios y Actualizaciones:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "La C.M.I CÉSAR LÓPEZ SILVA se reserva el derecho de modificar, actualizar o descontinuar la aplicación o sus funciones en cualquier momento sin previo aviso.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "7. Limitación de Responsabilidad:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "La C.M.I CÉSAR LÓPEZ SILVA no se hace responsable de ningún daño o perjuicio que pueda surgir del uso de esta aplicación, incluyendo daños directos, indirectos, incidentales, consecuentes o punitivos.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "8. Legislación Aplicable:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Estos términos y condiciones se rigen por las leyes del Perú y cualquier disputa que surja en relación con estos términos estará sujeta a la jurisdicción de los tribunales de [ciudad].",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "9. Contacto:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Si tienes preguntas o comentarios sobre estos términos y condiciones, por favor contáctanos a través de cesarlopezsilva@gmail.com ",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Al utilizar esta aplicación, aceptas los términos y condiciones establecidos anteriormente.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
