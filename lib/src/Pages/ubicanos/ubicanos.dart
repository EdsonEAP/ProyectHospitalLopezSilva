import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/widget/classGeneral.dart';
import 'package:flutter_application_1/src/widget/drawer.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as LatLng;

TextEditingController userController = TextEditingController();
TextEditingController passController = TextEditingController();
int animated = 1;

class UbicanosView extends StatefulWidget {
  static const String name = "UbicanosView";

  const UbicanosView({Key? key}) : super(key: key);

  @override
  _UbicanosViewState createState() => _UbicanosViewState();
}

class _UbicanosViewState extends State<UbicanosView> {
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
      body: Stack(
        children: [
          Container(
            height: size.height * 0.9,
            width: size.width,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng.LatLng(-12.2307319, -76.9234661),
                zoom: 16,
                maxZoom: 18,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  additionalOptions: {
                    'userAgent': 'com.example.app',
                  },
                ),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng.LatLng(-12.2307319, -76.9234661),
                      builder: (ctx) => Container(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Center(
                                    child: Text(
                                        'Centro Materno Infantil Cesar Lopez Silva'),
                                  ),
                                  content: Image.asset(
                                    'assets/icon/hospital.jpg',
                                    width: 150,
                                    height: 150,
                                  ),
                                );
                              },
                            );
                          },
                          child: Icon(
                            Icons.location_on,
                            color: Color.fromARGB(255, 255, 17, 0),
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Opacity(
            opacity: 0.7,
            child: Container(
              color: General.grissApp,
              height: size.height * 0.05,
              width: size.width,
              child: Center(
                  child: Text(
                "UBICANOS",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
