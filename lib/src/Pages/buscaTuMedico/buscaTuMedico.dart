import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/Pages/buscaTuMedico/Models/buscaTuMedicoModel.dart';
import 'package:flutter_application_1/src/Pages/buscaTuMedico/Page/InfoMedico/infoMedicoView.dart';
import 'package:flutter_application_1/src/Pages/buscaTuMedico/bloc/buscaTuMediBloc.dart';
import 'package:flutter_application_1/src/Pages/citaPresencial/Bloc/citaPresencialBloc.dart';
import 'package:flutter_application_1/src/Pages/homeView/home.dart';
import 'package:flutter_application_1/src/Pages/login/vistalongin.dart';
import 'package:flutter_application_1/src/Preferences/preferences.dart';
import 'package:flutter_application_1/src/widget/classGeneral.dart';
import 'package:flutter_application_1/src/widget/colum_builder.dart';
import 'package:flutter_application_1/src/widget/drawer.dart';
import 'package:flutter_application_1/src/widget/widgets.dart';

final prefs = PreferenciasUsuario();

TextEditingController nombreMedicoController = TextEditingController();
int animated = 1;
String? dropdownLugar;
String? dropdownEspecialidad;
BuscaMedicoBloc buscarMedicoBloc = BuscaMedicoBloc();
BuscarMedicoM buscarMedicoM = BuscarMedicoM();
List<String> especialidad = [];
List<String> lugar = [];
CitaPresencialBloc citaPresencialBloc = CitaPresencialBloc();
List<String> listLugar = [];
List<String> listEspecialiades = [];
List<String> listHorarios = [];

class BuscaTuMedicoView extends StatefulWidget {
  static const String name = "BuscaTuMedicoView";

  const BuscaTuMedicoView({Key? key}) : super(key: key);

  @override
  _BuscaTuMedicoViewState createState() => _BuscaTuMedicoViewState();
}

class _BuscaTuMedicoViewState extends State<BuscaTuMedicoView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    inicio();
    super.initState();
  }

  void inicio() async {
    listLugar = await citaPresencialBloc.requestComboLugar();
    listEspecialiades = await citaPresencialBloc.requestCombosEspecialidades();
  }

  void buscarHorarioMedico(
      {required String nombreMedico,
      required String especialidad,
      required String lugar}) async {
    listHorarios = await citaPresencialBloc.requestHorarioMedico(context,
        medico: nombreMedico,
        especialidad: especialidad,
        centro_atencion: lugar);
    print("nunca pasaraaaa");

    print(listHorarios);
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
                      "BUSCA TU MEDICO",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  height: size.height * 0.9,
                  width: size.width,
                  child: StreamBuilder<String>(
                      initialData: "correcto",
                      stream: citaPresencialBloc.citaPresencialS,
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          if (snapshot.data!.isEmpty ||
                              snapshot.data == "error") {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 200),
                                child: Text(
                                  "No hay Registros",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 112, 107, 107)),
                                ),
                              ),
                            );
                          } else {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: WidgetsRepetidos().inputLogin(
                                          active: true,
                                          seleccione: "Nombre",
                                          oculto: false,
                                          controlador: nombreMedicoController),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: WidgetsRepetidos().cajaSelect(
                                          context,
                                          "Especialidad",
                                          size.height * 0.089,
                                          size.width * 0.5,
                                          listEspecialiades,
                                          "",
                                          dropdownEspecialidad, (v) {
                                        setState(() {
                                          dropdownEspecialidad = v;
                                        });
                                      }),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: WidgetsRepetidos().cajaSelect(
                                          context,
                                          "Lugar",
                                          size.height * 0.089,
                                          size.width * 0.5,
                                          listLugar,
                                          "",
                                          dropdownLugar, (v) {
                                        setState(() {
                                          dropdownLugar = v;
                                        });
                                      }),
                                    ),
                                  ],
                                ),
                                streamBotonReactive(context),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                StreamBuilder<List<BuscarMedicoM>>(
                                    stream:
                                        buscarMedicoBloc.buscarCitaHistorialS,
                                    builder: (context, snapshot) {
                                      if (snapshot.data != null) {
                                        if (snapshot.data!.isEmpty) {
                                          return const Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 150),
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
                                            height: size.height * 0.45,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  ColumnBuilder(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      itemCount:
                                                          snapshot.data!.length,
                                                      itemBuilder:
                                                          (context, i) {
                                                        return Column(
                                                            children: [
                                                              tarjetConsultarHorario(
                                                                  size,
                                                                  snapshot
                                                                      .data![i]
                                                                      .nombres,
                                                                  snapshot
                                                                      .data![i]
                                                                      .especialidad,
                                                                  snapshot
                                                                      .data![i]
                                                                      .centroAtencion,
                                                                  () {
                                                                prefs
                                                                    .busquedaEspecialidadDoctor = snapshot
                                                                        .data![
                                                                            i]
                                                                        .especialidad ??
                                                                    "";
                                                                prefs
                                                                    .busquedaNombreDoctor = snapshot
                                                                        .data![
                                                                            i]
                                                                        .nombres ??
                                                                    "";
                                                                prefs
                                                                    .busquedaLugarDoctor = snapshot
                                                                        .data![
                                                                            i]
                                                                        .centroAtencion ??
                                                                    "";
                                                                buscarHorarioMedico(
                                                                    nombreMedico:
                                                                        snapshot.data![i].nombres ??
                                                                            "",
                                                                    especialidad:
                                                                        snapshot.data![i].especialidad ??
                                                                            "",
                                                                    lugar: snapshot
                                                                            .data![i]
                                                                            .centroAtencion ??
                                                                        '"');

                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                InfoMedicoView()));
                                                              }),
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
                            );
                          }
                        } else {
                          return Center(
                              child: CircularProgressIndicator(
                            color: Colors.white,
                          ));
                        }
                      }),
                )
              ],
            ),
          ),
        ));
  }

  Container tarjetConsultarHorario(
    Size size,
    String? medico,
    String? especialidad,
    String? lugar,
    Function()? onTap,
  ) {
    return Container(
      height: size.height * 0.17,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: size.height * 0.01),
            height: size.height * 0.085,
            width: size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        medico ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: General.colorApp,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                  Text(
                    especialidad ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: General.grissApp),
                  ),
                  Text(
                    lugar ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: General.grissApp,
                    ),
                  ),
                ]),
          ),
          InkWell(
            onTap: onTap,
            child: Container(
                margin: EdgeInsets.only(bottom: size.height * 0.01),
                padding: const EdgeInsets.symmetric(vertical: 14),
                width: size.width,
                decoration: BoxDecoration(
                  color: General.colorApp,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(
                    'Consultar horario',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white, // Cambia el color a blanco
                      fontSize:
                          12, // Cambia el tamaño del texto según tus necesidades
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
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
            buscarMedicoBloc.requestBuscaMedico(context,
                nombres: nombreMedicoController.text,
                especialidad: dropdownEspecialidad,
                centro_atencion: dropdownLugar)
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
                        color: Colors.white,
                        fontSize: 12,
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
