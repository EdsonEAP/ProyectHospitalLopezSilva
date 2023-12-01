import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/Pages/login/Models/loginModel.dart';
import 'package:flutter_application_1/src/Pages/login/bloc/bloclogin.dart';
import 'package:flutter_application_1/src/Pages/login/vistalongin.dart';
import 'package:flutter_application_1/src/Pages/registro/bloc/registroBloc.dart';
import 'package:flutter_application_1/src/Pages/terminosRegister/terminosRegister.dart';
import 'package:flutter_application_1/src/Preferences/preferences.dart';
import 'package:flutter_application_1/src/widget/classGeneral.dart';
import 'package:flutter_application_1/src/widget/widgets.dart';

class RegistroView extends StatefulWidget {
  static const String name = "RegistroView";

  const RegistroView({Key? key}) : super(key: key);

  @override
  _RegistroViewState createState() => _RegistroViewState();
}

//TextEditingController tipoDocumentoController = TextEditingController();
TextEditingController documentoController = TextEditingController();
TextEditingController primerNombreController = TextEditingController();
TextEditingController segundoNombreController = TextEditingController();
TextEditingController apellidoController = TextEditingController();
//TextEditingController generoController = TextEditingController();
TextEditingController edadController = TextEditingController();
TextEditingController diaNacimientoController = TextEditingController();
//TextEditingController mesNacimientoController = TextEditingController();
TextEditingController yearNacimientoController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController celularController = TextEditingController();
TextEditingController direccionController = TextEditingController();
//TextEditingController seguroController = TextEditingController();
TextEditingController passController = TextEditingController();
TextEditingController repeatpassController = TextEditingController();
Map<String, String> mesesNumericos = {
  "Enero": "01",
  "Febrero": "02",
  "Marzo": "03",
  "Abril": "04",
  "Mayo": "05",
  "Junio": "06",
  "Julio": "07",
  "Agosto": "08",
  "Septiembre": "09",
  "Octubre": "10",
  "Noviembre": "11",
  "Diciembre": "12",
};
RegisterBloc registerBloc = RegisterBloc();

final prefs = PreferenciasUsuario();
int animated = 1;
String? dropdownDni;
String? dropdownSexo;
String? dropdownSeguro;
String? dropdownMes;
String? mesEnLetras;
bool valueTerminosYCondiciones = false;

class _RegistroViewState extends State<RegistroView> {
  @override
  void initState() {
    //prefs.ultimaPagina = LoginView.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Stack(
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
          Container(
            height: size.height * 1,
            width: size.width * 1,
            child: ListView(
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  height: size.height * 0.15,
                  width: size.width * 0.25,
                  child: Image.asset(
                    'assets/icon/logofarmacia.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  children: [
                    WidgetsRepetidos().cajaSelect(
                        context,
                        "Tipo de documento",
                        size.height * 0.08,
                        size.width * 0.5,
                        ["DNI", "C.E"],
                        "",
                        dropdownDni, (v) {
                      setState(() {
                        dropdownDni = v;
                      });
                    }),
                    Expanded(
                      child: WidgetsRepetidos().inputLogin(
                          active: true,
                          seleccione: "Nro de documento",
                          oculto: false,
                          controlador: documentoController),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: WidgetsRepetidos().inputLogin(
                          active: true,
                          seleccione: "Primero nombre",
                          oculto: false,
                          controlador: primerNombreController),
                    ),
                    Expanded(
                      child: WidgetsRepetidos().inputLogin(
                          active: true,
                          seleccione: "Segundo nombre",
                          oculto: false,
                          controlador: segundoNombreController),
                    ),
                  ],
                ),
                WidgetsRepetidos().inputLogin(
                    active: true,
                    seleccione: "Apellido Completo",
                    oculto: false,
                    controlador: apellidoController),
                Row(
                  children: [
                    WidgetsRepetidos().cajaSelect(
                        context,
                        "Sexo",
                        size.height * 0.08,
                        size.width * 0.5,
                        ["MASCULINO", "FEMENINO"],
                        "",
                        dropdownSexo, (v) {
                      setState(() {
                        dropdownSexo = v;
                      });
                    }),
                    Expanded(
                      child: WidgetsRepetidos().inputLogin(
                          active: true,
                          seleccione: "Edad",
                          oculto: false,
                          controlador: edadController),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: Alignment
                            .centerLeft, // Alinea el texto a la izquierda
                        child: Text(
                          "Fecha de Nacimiento",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: General.grissApp,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: WidgetsRepetidos().inputLogin(
                              active: true,
                              seleccione: "Día",
                              oculto: false,
                              controlador: diaNacimientoController),
                        ),
                        WidgetsRepetidos().cajaSelect(
                            context,
                            "Mes",
                            size.height * 0.08,
                            size.width * 0.5,
                            [
                              "Enero",
                              "Febrero",
                              "Marzo",
                              "Abril",
                              "Mayo",
                              "Junio",
                              "Julio",
                              "Agosto",
                              "Septiembre",
                              "Octubre",
                              "Noviembre",
                              "Diciembre",
                            ],
                            "",
                            dropdownMes, (v) {
                          setState(() {
                            dropdownMes = v;
                            mesEnLetras = mesesNumericos[v] ?? "";
                            print(mesEnLetras);
                          });
                        }),
                        Expanded(
                          child: WidgetsRepetidos().inputLogin(
                              active: true,
                              seleccione: "Año",
                              oculto: false,
                              controlador: yearNacimientoController),
                        ),
                      ],
                    ),
                  ],
                ),

                WidgetsRepetidos().inputLogin(
                    active: true,
                    seleccione: "Email",
                    oculto: false,
                    controlador: emailController),
                WidgetsRepetidos().inputLogin(
                    active: true,
                    seleccione: "Celular",
                    oculto: false,
                    controlador: celularController),
                WidgetsRepetidos().inputLogin(
                    active: true,
                    seleccione: "Dirección",
                    oculto: false,
                    controlador: direccionController),

                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Seguro / Plan de salud",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: General.grissApp,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    WidgetsRepetidos().cajaSelect(
                        context,
                        "Seleccione",
                        size.height * 0.08,
                        size.width * 1,
                        ["PROPIO", "SIS", "ESSALUD"],
                        "",
                        dropdownSeguro, (v) {
                      setState(() {
                        dropdownSeguro = v;
                      });
                    }),
                  ],
                ),
                WidgetsRepetidos().inputLogin(
                    active: true,
                    seleccione: "Contraseña",
                    oculto: true,
                    controlador: passController),
                // WidgetsRepetidos().inputLogin(
                //     active: true,
                //     seleccione: "Repetir contraseña",
                //     oculto: true,
                //     controlador: repeatpassController),
                SizedBox(height: size.height * 0.01),
                Container(
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Leer terminos y condiciones:  ",
                        style: TextStyle(
                          color: General.grissApp,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: "Aquí",
                            style: TextStyle(
                              color: General.colorApp,
                              fontSize: 12,
                              decoration:
                                  TextDecoration.underline, // Subraya el texto
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TerminosRegister(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text(
                      "Acepto los términos y condiciones de uso",
                      style: TextStyle(
                          color: General.grissApp,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )),
                    Checkbox(
                      activeColor: General.colorApp,
                      value: valueTerminosYCondiciones,
                      onChanged: (value) {
                        setState(() {
                          valueTerminosYCondiciones = value!;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                streamBotonReactive(context),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Ya tienes cuenta? ",
                        style: TextStyle(
                          color: General.grissApp,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: "Logueate",
                            style: TextStyle(
                              color: General.colorApp,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(
                                    context, LoginView.name);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Añade aquí otros widgets como textos o elementos adicionales
              ],
            ),
          ),
        ],
      )),
    );
  }
}

streamBotonReactive(context) {
  final size = MediaQuery.of(context).size;
  return StreamBuilder<String>(
    initialData: "REGISTRAR",
    stream: registerBloc.botonRegisterS,
    builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
      if (snapshot.data == "REGISTRAR") {
        animated = 1;
      } else if (snapshot.data == "ERROR") {
        animated = 2;
      }
      return AnimatedContainer(
        width: size.width * 0.5 / animated,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(seconds: 2),
        child: InkWell(
          onTap: () => {
            if (mesEnLetras == null)
              {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Aviso"),
                      content: Text(
                          "Por favor, complete todos los campos requeridos."),
                      actions: <Widget>[
                        TextButton(
                          child: Text("Aceptar"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                ),
              }
            else
              {
                registerBloc.requestRegister(context,
                    fecha_nacimiento: yearNacimientoController.text +
                        "-" +
                        mesEnLetras! +
                        "-" +
                        diaNacimientoController.text,
                    type_document: dropdownDni,
                    document: documentoController.text,
                    first_name: primerNombreController.text,
                    second_name: segundoNombreController.text,
                    surnames: apellidoController.text,
                    gender: dropdownSexo,
                    age: edadController.text,
                    email: emailController.text,
                    phone: celularController.text,
                    address: direccionController.text,
                    type_sure: dropdownSeguro,
                    password: passController.text,
                    terms: valueTerminosYCondiciones ? "1" : '0')
              }
          },
          child: Container(
            margin: const EdgeInsets.only(left: 70, right: 70, bottom: 0),
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: size.width * 0.5,
            decoration: BoxDecoration(
              color: General.colorApp,
              borderRadius: BorderRadius.circular(30),
            ),
            child: snapshot.data == "REGISTRAR"
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
