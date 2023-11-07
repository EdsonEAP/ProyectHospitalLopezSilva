import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/Pages/buscaTuMedico/buscaTuMedico.dart';
import 'package:flutter_application_1/src/Pages/citaPresencial/citaPresencial.dart';
import 'package:flutter_application_1/src/Pages/login/Models/loginModel.dart';
import 'package:flutter_application_1/src/Pages/login/vistalongin.dart';
import 'package:flutter_application_1/src/Pages/misCitas/misCitas.dart';
import 'package:flutter_application_1/src/widget/classGeneral.dart';
import 'package:flutter_application_1/src/widget/drawer.dart';

TextEditingController userController = TextEditingController();
TextEditingController passController = TextEditingController();
int animated = 1;
LoginM modelLogin = LoginM();

class HomeView extends StatefulWidget {
  static const String name = "HomeView";

  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
                Row(
                  children: [
                    cardHome(
                      size,
                      modelLogin.address ?? "CITA PRESENCIAL",
                      Icons.date_range,
                      "assets/doctor/doctor1.jpg",
                      () {
                        Navigator.pushNamed(context, CitaPresencialView.name);
                      },
                    ),
                    cardHome(size, "BUSCA TU MÉDICO", Icons.search,
                        "assets/icon/doctor.jpg", () {
                      Navigator.pushNamed(context, BuscaTuMedicoView.name);
                    })
                  ],
                ),
                Row(
                  children: [
                    cardHome(size, "MIS CITAS", Icons.calendar_today,
                        "assets/doctor/doctor3.jpeg", () {
                      Navigator.pushNamed(context, MisCitasView.name);
                    }),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  InkWell cardHome(
    Size size,
    String titulo,
    IconData iconoName,
    String urlImage,
    Function() onTapFunction,
  ) {
    return InkWell(
      onTap: onTapFunction,
      child: Container(
        margin: EdgeInsets.only(top: 10, left: size.width * 0.02),
        height: size.height * 0.4,
        width: size.width * 0.47,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: size.height * 0.4,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    image: DecorationImage(
                      image: AssetImage(urlImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.8,
                  child: Container(
                    height: size.height * 0.05,
                    width: size.width * 0.5,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(10.0)),
                      color: General.grissApp,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            iconoName,
                            color: Colors.white,
                          ),
                          Text(
                            '  ${titulo}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
