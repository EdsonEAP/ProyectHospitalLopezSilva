import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/widget/classGeneral.dart';
import 'package:flutter_application_1/src/widget/drawer.dart';

TextEditingController userController = TextEditingController();
TextEditingController passController = TextEditingController();
int animated = 1;

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
          child: Container()
        ));
  }
}
