import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/Pages/homeView/home.dart';
import 'package:flutter_application_1/src/Pages/login/vistalongin.dart';
import 'package:flutter_application_1/src/Pages/misCitas/Models/historialCitaModel.dart';
import 'package:flutter_application_1/src/Pages/misCitas/bloc/historialCitaBloc.dart';
import 'package:flutter_application_1/src/Preferences/preferences.dart';
import 'package:flutter_application_1/src/widget/classGeneral.dart';
import 'package:flutter_application_1/src/widget/colum_builder.dart';
import 'package:flutter_application_1/src/widget/drawer.dart';
import 'package:flutter_application_1/src/widget/widgets.dart';

TextEditingController citaController = TextEditingController();
int animated = 1;
String? dropdownLugar;
String? dropdownEspecialidad;
HistorialCitaBloc historialCitaBloc = HistorialCitaBloc();
final prefs = PreferenciasUsuario();

class MisCitasView extends StatefulWidget {
  static const String name = "MisCitasView";

  const MisCitasView({Key? key}) : super(key: key);

  @override
  _MisCitasViewState createState() => _MisCitasViewState();
}

class _MisCitasViewState extends State<MisCitasView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    inicio();
    super.initState();
  }

  void inicio() async {
    citaController.text = prefs.nombreUsuario;
    await historialCitaBloc.requestHistorialCita(context, dni: "75013406");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: General.colorApp,
          title: Center(
            child: Container(
              margin: EdgeInsets.only(right: 50),
              child: Image.asset(
                'assets/icon/logofarmacia.png',
                width: 50,
              ),
            ),
          ),
          // Agregar un ícono de menú al AppBar

          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Abre el Drawer al hacer clic en el ícono de menú
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
          height: size.height * 0.9,
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
                      "MIS CITAS",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  height: size.height * 0.9,
                  width: size.width,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: WidgetsRepetidos().inputLogin(
                                active: false,
                                seleccione: "Nombre:",
                                oculto: false,
                                controlador: citaController),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        "MIS CITAS PROGRAMADAS",
                        style: TextStyle(
                            color: General.colorApp,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      StreamBuilder<List<HistorialClienteM>>(
                          stream: historialCitaBloc.buscarCitaHistorialS,
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              if (snapshot.data!.isEmpty) {
                                return const Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 200),
                                    child: Text(
                                      "No hay Registros",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 112, 107, 107)),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  width: size.width,
                                  height: size.height * 0.6,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ColumnBuilder(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, i) {
                                              return Column(children: [
                                                tarjetConsultarHorario(
                                                    size,
                                                    snapshot
                                                        .data![i].medicoNombre,
                                                    snapshot
                                                        .data![i].especiality,
                                                    snapshot.data![i].lugar,
                                                    snapshot.data![i].fecha,
                                                    snapshot
                                                        .data![i].estadoCita),
                                                Divider()
                                              ]);
                                            })
                                      ],
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return Center(
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                              ));
                            }
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Container tarjetConsultarHorario(Size size, String? medico,
      String? especialidad, String? lugar, String? fecha, String? texto) {
    return Container(
      margin: EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: General.colorApp,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: <Widget>[
                // Espacio entre el círculo y el texto
                Text(
                  texto ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: (texto == "PENDIENTE")
                        ? Colors.green
                        : Colors.red, // Color del texto
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  width: 12, // Ancho del círculo
                  height: 12, // Altura del círculo
                  decoration: BoxDecoration(
                    color: (texto == "PENDIENTE")
                        ? Colors.green
                        : Colors.red, // Color del círculo
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Médico: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      medico ?? "",
                      style: TextStyle(
                        color: General.colorApp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.01),
                Row(
                  children: [
                    Text(
                      "Especialidad: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      especialidad ?? "",
                      style: TextStyle(
                        color: General.colorApp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.01),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lugar: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: size.width * 0.9,
                      child: Text(
                        lugar ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: General.colorApp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Horario: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: size.width * 0.7,
                      child: Text(
                        fecha ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: General.colorApp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  streamBotonReactive(context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<String>(
      initialData: "INGRESAR",
      stream: loginBloc.botonLoginS,
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.data == "INGRESAR") {
          animated = 1;
        } else if (snapshot.data == "ERROR") {
          animated = 2;
        }
        return AnimatedContainer(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: size.width * 0.5 / animated,
          curve: Curves.fastOutSlowIn,
          duration: const Duration(seconds: 2),
          child: InkWell(
            onTap: () => {
              // prefs.emailSave = userController.text,
              // loginM.userEmail = prefs.emailSave,
              // prefs.user = userController.text,
              // prefs.password = passController.text,
              // loginBloc.botonLoginC.sink.add("ERROR"),
              // loginBloc.requestLogin(context,
              //     user: userController.text, pass: passController.text),
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.5,
              decoration: BoxDecoration(
                color: General.colorApp,
                borderRadius: BorderRadius.circular(30),
              ),
              child: snapshot.data == "INGRESAR"
                  ? Center(
                      child: Text(
                        snapshot.data ?? '',
                        style: TextStyle(
                          color: Colors.white, // Cambia el color a blanco
                          fontSize:
                              12, // Cambia el tamaño del texto según tus necesidades
                        ),
                      ),
                    )
                  : Center(
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
