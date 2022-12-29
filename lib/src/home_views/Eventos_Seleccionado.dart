
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Evento_Seleccionado extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _evento();
  }
}

class _evento extends State<Evento_Seleccionado>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Text("VISTA DE EVENTO SELECCIONADO"),
    );
  }

}