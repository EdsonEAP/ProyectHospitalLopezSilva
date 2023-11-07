import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/Mixins/alerts.dart';
import 'package:flutter_application_1/src/Pages/citaPresencial/Bloc/citaPresencialBloc.dart';
import 'package:flutter_application_1/src/Pages/login/vistalongin.dart';
import 'package:flutter_application_1/src/Preferences/preferences.dart';
import 'package:flutter_application_1/src/widget/classGeneral.dart';
import 'package:flutter_application_1/src/widget/drawer.dart';
import 'package:flutter_application_1/src/widget/fechayHora.dart';
import 'package:flutter_application_1/src/widget/widgets.dart';

String? dropdownLugar;
String? dropdownEspecialidad;
String? medico;
String? horario;
TextEditingController citaController = TextEditingController();
TextEditingController passController = TextEditingController();
TextEditingController usuarioController = TextEditingController();
TextEditingController correoController = TextEditingController();

int animated = 1;

DateTime selectedDate = DateTime.now();
final prefs = PreferenciasUsuario();
CitaPresencialBloc citaPresencialBloc = CitaPresencialBloc();
List<String> listLugar = [];
List<String> listEspecialiades = [];
List<String> listDoctores = [];
List<String> listHorarios = [];

class CitaPresencialView extends StatefulWidget with Alerts {
  static const String name = "CitaPresencialView";

  const CitaPresencialView({Key? key}) : super(key: key);

  @override
  _CitaPresencialViewState createState() => _CitaPresencialViewState();
}

class _CitaPresencialViewState extends State<CitaPresencialView> with Alerts {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    listLugar.clear();
    dropdownLugar = null;
    listEspecialiades.clear();
    dropdownEspecialidad = null;
    listDoctores.clear();
    medico = null;
    listHorarios.clear();
    horario = null;
    inicio();

    super.initState();
  }

  void inicio() async {
    listLugar = await citaPresencialBloc.requestComboLugar();
    listEspecialiades = await citaPresencialBloc.requestCombosEspecialidades();
    correoController.text = prefs.correo;
  }

  void listasMedicos() async {
    listDoctores = await citaPresencialBloc.requestBuscaMedico(context,
        especialidad: dropdownEspecialidad, centro_atencion: dropdownLugar);
  }

  void buscarHorarioMedico() async {
    listHorarios = await citaPresencialBloc.requestHorarioMedico(context,
        medico: medico,
        especialidad: dropdownEspecialidad,
        centro_atencion: dropdownLugar);
    print("nunca pasaraaaa");

    print(listHorarios);
  }

  @override
  Widget build(BuildContext context) {
    usuarioController.text = prefs.nombreUsuario;

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
                      "CITA PRESENCIAL",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                Stack(
                  children: [
                    Opacity(
                      opacity: 0.3,
                      child: Image(
                        image: AssetImage('assets/icon/doctor.jpg'),
                        width: size.width,
                        height: size.height,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(children: [
                        StreamBuilder<String>(
                            initialData: "correcto",
                            stream: citaPresencialBloc.citaPresencialS,
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                if (snapshot.data!.isEmpty ||
                                    snapshot.data == "error") {
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              height: size.height * 0.08,
                                              width: size.width * 0.23,
                                              child: Text(
                                                "Cita para:",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 11),
                                              ),
                                            ),
                                            Expanded(
                                              child: WidgetsRepetidos()
                                                  .inputLogin(
                                                      active: false,
                                                      seleccione: "",
                                                      oculto: false,
                                                      controlador:
                                                          usuarioController),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              height: size.height * 0.08,
                                              width: size.width * 0.23,
                                              child: Text(
                                                "Correo:",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 11),
                                              ),
                                            ),
                                            Expanded(
                                              child: WidgetsRepetidos()
                                                  .inputLogin(
                                                      active: true,
                                                      seleccione: "",
                                                      oculto: false,
                                                      controlador:
                                                          correoController),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              height: size.height * 0.08,
                                              width: size.width * 0.23,
                                              child: Text(
                                                "Lugar:",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 11),
                                              ),
                                            ),
                                            Center(
                                              child: WidgetsRepetidos()
                                                  .cajaSelect(
                                                      context,
                                                      "Lugar",
                                                      size.height * 0.089,
                                                      size.width * 0.66,
                                                      listLugar,
                                                      "",
                                                      dropdownLugar, (v) {
                                                setState(() {
                                                  // listDoctores.clear();
                                                  // medico = null;
                                                  // listHorarios.clear();
                                                  // horario = null;
                                                  dropdownLugar = v;
                                                });
                                              }),
                                            ),
                                          ],
                                        ),

                                        // Row(
                                        //   children: [
                                        //     Container(
                                        //       alignment: Alignment.centerLeft,
                                        //       height: size.height * 0.08,
                                        //       width: size.width * 0.23,
                                        //       child: Text(
                                        //         "Lugar:",
                                        //         style: TextStyle(
                                        //             color: Color.fromARGB(
                                        //                 255, 0, 0, 0),
                                        //             fontSize: 11),
                                        //       ),
                                        //     ),
                                        //     Expanded(
                                        //       child: WidgetsRepetidos()
                                        //           .cajaSelect(
                                        //               context,
                                        //               "Seleccione",
                                        //               size.height * 0.089,
                                        //               size.width * 0.5,
                                        //               listLugar,
                                        //               "",
                                        //               dropdownLugar, (v) {
                                        //         setState(() {
                                        //           dropdownLugar = v;
                                        //         });
                                        //       }),
                                        //     ),
                                        //   ],
                                        // ),
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              height: size.height * 0.08,
                                              width: size.width * 0.23,
                                              child: Text(
                                                "Especialidad:",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 11),
                                              ),
                                            ),
                                            Expanded(
                                              child: WidgetsRepetidos()
                                                  .cajaSelect(
                                                      context,
                                                      "Seleccione",
                                                      size.height * 0.089,
                                                      size.width * 0.5,
                                                      listEspecialiades,
                                                      "",
                                                      dropdownEspecialidad,
                                                      (v) {
                                                setState(() {
                                                  if (dropdownLugar == null ||
                                                      dropdownLugar == "") {
                                                    showErrorDialog(
                                                        context: context,
                                                        textContent:
                                                            "Debe de seleccionar una lugar de atención");
                                                    return;
                                                  }
                                                  print(
                                                      "pasaaaaaaaaaaa almacen");
                                                  dropdownEspecialidad = v;
                                                  listasMedicos();
                                                });
                                              }),
                                            ),
                                          ],
                                        ),
                                        StreamBuilder<String>(
                                            stream: citaPresencialBloc
                                                .buscarCitaHistorials,
                                            builder: (context, snapshot) {
                                              if (snapshot.data != null) {
                                                if (snapshot.data!.isEmpty ||
                                                    snapshot.data == "error") {
                                                  return const Center(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 200),
                                                      child: Text(
                                                        "No hay Registros",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    112,
                                                                    107,
                                                                    107)),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return Row(
                                                    children: [
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        height:
                                                            size.height * 0.08,
                                                        width:
                                                            size.width * 0.23,
                                                        child: Text(
                                                          "Medico:",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(255,
                                                                      0, 0, 0),
                                                              fontSize: 11),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: WidgetsRepetidos()
                                                            .cajaSelect(
                                                                context,
                                                                "Seleccione",
                                                                size.height *
                                                                    0.089,
                                                                size.width *
                                                                    0.5,
                                                                listDoctores,
                                                                "",
                                                                medico, (v) {
                                                          setState(() {
                                                            if (dropdownEspecialidad ==
                                                                    null ||
                                                                dropdownEspecialidad ==
                                                                    "") {
                                                              showErrorDialog(
                                                                  context:
                                                                      context,
                                                                  textContent:
                                                                      "Debe de seleccionar una  Especialidad");
                                                            }
                                                            if (dropdownLugar ==
                                                                    null ||
                                                                dropdownLugar ==
                                                                    "") {
                                                              showErrorDialog(
                                                                  context:
                                                                      context,
                                                                  textContent:
                                                                      "Debe de seleccionar un centro de salud");

                                                              return;
                                                            }

                                                            print(
                                                                dropdownEspecialidad);
                                                            medico = v;
                                                            buscarHorarioMedico();
                                                          });
                                                        }),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              } else {
                                                return Container();
                                              }
                                            }),
                                        StreamBuilder<String>(
                                            stream: citaPresencialBloc
                                                .buscarHorarioMedicoS,
                                            builder: (context, snapshot) {
                                              if (snapshot.data != null) {
                                                if (snapshot.data!.isEmpty ||
                                                    snapshot.data == "error") {
                                                  return const Center(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 200),
                                                      child: Text(
                                                        "No hay Registros",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    112,
                                                                    107,
                                                                    107)),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return Row(
                                                    children: [
                                                      // Container(
                                                      //   alignment: Alignment
                                                      //       .centerLeft,
                                                      //   height:
                                                      //       size.height * 0.08,
                                                      //   width:
                                                      //       size.width * 0.23,
                                                      //   child: Text(
                                                      //     "Horario:",
                                                      //     style: TextStyle(
                                                      //         color: Color
                                                      //             .fromARGB(255,
                                                      //                 0, 0, 0),
                                                      //         fontSize: 11),
                                                      //   ),
                                                      // ),
                                                      // Expanded(
                                                      //   child: WidgetsRepetidos()
                                                      //       .cajaSelect(
                                                      //           context,
                                                      //           "Seleccione",
                                                      //           size.height *
                                                      //               0.089,
                                                      //           size.width *
                                                      //               0.5,
                                                      //           listHorarios,
                                                      //           "",
                                                      //           horario, (v) {
                                                      //     setState(() {
                                                      //       if (dropdownEspecialidad ==
                                                      //               null ||
                                                      //           dropdownEspecialidad ==
                                                      //               "") {
                                                      //         showErrorDialog(
                                                      //             context:
                                                      //                 context,
                                                      //             textContent:
                                                      //                 "Debe de seleccionar una  Especialidad");
                                                      //       }
                                                      //       if (dropdownLugar ==
                                                      //               null ||
                                                      //           dropdownLugar ==
                                                      //               "") {
                                                      //         showErrorDialog(
                                                      //             context:
                                                      //                 context,
                                                      //             textContent:
                                                      //                 "Debe de seleccionar un centro de salud");

                                                      //         return;
                                                      //       }

                                                      //       print(
                                                      //           dropdownEspecialidad);
                                                      //       horario = v;
                                                      //       buscarHorarioMedico();
                                                      //     });
                                                      //   }),
                                                      // ),
                                                    ],
                                                  );
                                                }
                                              } else {
                                                return Container();
                                              }
                                            }),
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              height: size.height * 0.08,
                                              width: size.width * 0.23,
                                              child: Text(
                                                "Fecha:",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 11),
                                              ),
                                            ),
                                            Expanded(
                                                child: DateTimePickerWidget(
                                              size: size,
                                              initialDate: selectedDate,
                                              onDateChanged: (date) {
                                                print(
                                                    "Fecha seleccionada: $date");
                                              },
                                            )),
                                          ],
                                        ),
                                        streamBotonReactive(context),
                                      ],
                                    ),
                                  );
                                }
                              } else {
                                return Container(
                                  height: size.height * 0.7,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.black,
                                  )),
                                );
                              }
                            }),
                      ]),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
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
            citaPresencialBloc.registerCitaPresencial(
              context,
              date: selectedDate.toString(),
              document: prefs.documentoDni,
              email: correoController.text,
              especiality: dropdownEspecialidad,
              //horario: horario,
              lugar: dropdownLugar,
              medico: "1",
              medico_nombre: medico,
              nombre: prefs.nombreUsuario,
            ),
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
