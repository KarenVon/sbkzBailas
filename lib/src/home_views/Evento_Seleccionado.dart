
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbk_bailas/src/fb_objects/EventsInfo.dart';

import '../singleton/DataHolder.dart';

class Evento_Seleccionado extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _evento();
  }
}


class _evento extends State<Evento_Seleccionado>{
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<EventsInfo> info = [];

  @override
  void initState() {
    super.initState();
    descargarInfo();
    //print("DEBUG: "+DataHolder().selectedChatRoom.name!);
  }

  void descargarInfo() async{
    String path = DataHolder().sCOLLECTION_EVENTOS_INFO+ "/" +
        DataHolder().selectedEvent.uid;

    print("---------------------> $path");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Text("VISTA DE EVENTO SELECCIONADO"),
    );
  }

}