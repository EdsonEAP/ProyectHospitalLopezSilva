import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/Pages/buscaTuMedico/Models/buscaTuMedicoModel.dart';
import 'package:flutter_application_1/src/Pages/buscaTuMedico/bloc/buscaTuMediBloc.dart';
import 'package:flutter_application_1/src/Pages/citaPresencial/Bloc/citaPresencialBloc.dart';
import 'package:flutter_application_1/src/widget/classGeneral.dart';
import 'package:flutter_application_1/src/widget/colum_builder.dart';
import 'package:flutter_application_1/src/widget/drawer.dart';
import 'package:flutter_application_1/src/widget/widgets.dart';

int animated = 1;
CitaPresencialBloc buscarMedicoBloc = CitaPresencialBloc();
String? dropdownEspecialidad;
CitaPresencialBloc citaPresencialBloc = CitaPresencialBloc();
List<String> listHorarios = [];

class InfoMedicoView extends StatefulWidget {
  static const String name = "InfoMedicoView";

  InfoMedicoView({
    Key? key,
  }) : super(key: key);

  @override
  _InfoMedicoViewState createState() => _InfoMedicoViewState();
}

class _InfoMedicoViewState extends State<InfoMedicoView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    buscarHorarioMedico(
        lugar: prefs.busquedaLugarDoctor,
        nombreMedico: prefs.busquedaNombreDoctor,
        especialidad: prefs.busquedaEspecialidadDoctor);
    super.initState();
  }

  void buscarHorarioMedico(
      {required String nombreMedico,
      required String especialidad,
      required String lugar}) async {
    listHorarios = await citaPresencialBloc.requestHorarioMedico(context,
        medico: nombreMedico,
        especialidad: especialidad,
        centro_atencion: lugar);
    print("pasaraaaa");

    print(listHorarios);
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
          height: size.height,
          width: size.width,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(children: [
              Opacity(
                opacity: 0.5,
                child: Container(
                  color: General.grissApp,
                  height: size.height * 0.05,
                  width: size.width,
                  child: Center(
                      child: Text(
                    "VISUALIZAR HORARIOS",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                height: size.height * 0.9,
                width: size.width,
                child: StreamBuilder<List<String>>(
                    stream: buscarMedicoBloc.listadoMedicS,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        if (snapshot.data!.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 150),
                              child: Text(
                                "No hay Registros",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 112, 107, 107)),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            width: size.width,
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
                                              snapshot.data![i],
                                              prefs.busquedaEspecialidadDoctor),
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
                    }),
              )
            ]),
          ),
        ));
  }
}

Container tarjetConsultarHorario(
  Size size,
  String? medico,
  String? especialidad,
) {
  return Container(
    margin: EdgeInsets.all(10),
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
          child: Text(
            "Horarios de Atención",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
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
                    prefs.busquedaNombreDoctor,
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
              Row(
                children: [
                  Text(
                    "Horario: ",
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
            ],
          ),
        ),
      ],
    ),
  );
}
