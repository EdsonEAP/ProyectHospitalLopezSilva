import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/widget/classGeneral.dart';

class WidgetsRepetidos {
  inputLogin(
      {required String seleccione,
      required bool oculto,
      required TextEditingController controlador, required bool active}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextField(
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            enabledBorder: const OutlineInputBorder(
                borderSide:
                    const BorderSide(color: General.colorApp, width: 0.0),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            fillColor: Color(0xffF2F2F2).withOpacity(0.7),
            border: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromRGBO(242, 242, 242, 1), width: 0.0),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            hintText: seleccione,
            // prefixIcon: Image.asset(
            //   imageurl,
            //   fit: BoxFit.scaleDown,
            // ),
          ),
          enabled: active,
          obscureText: oculto,
          controller: controlador,
          style: TextStyle(fontSize: 12)),
    );
  }

  cajaSelect(
      context,
      String titulo,
      double alto,
      double ancho,
      List<String> list,
      String hint,
      String? valueString,
      Function(String value) onchange) {
    final Size size = MediaQuery.of(context).size;
    //String dropdownValue = 'Option 1';
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Container(
          //margin: const EdgeInsets.only(top:1.0),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: ancho,
          height: alto,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // ignore: prefer_const_constructors

              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: size.width,
                height: 43,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: General.colorApp, // Color del borde verde
                      width: 0, // Ancho del borde
                    ),
                    color: Color(0xffF2F2F2).withOpacity(0.7),
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButton(
                  underline: Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide.none))),
                  hint: Container(
                      child: Text(
                    titulo,
                    style: TextStyle(fontSize: 12),
                  )),
                  isExpanded: true,
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Icon(Icons.arrow_drop_down_sharp),
                  ),
                  value: valueString,
                  items: list.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(
                        value,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis, fontSize: 12),
                      ),
                    );
                  }).toList(),
                  onChanged: (dynamic value) {
                    setState((() {
                      valueString = value;
                      onchange(value);
                      print(valueString);
                    }));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
