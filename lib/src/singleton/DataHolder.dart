

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sbk_bailas/src/fb_objects/EventsInfo.dart';

import '../fb_objects/Perfil.dart';
import '../platform/PlatformAdmin.dart';

class DataHolder {

  FirebaseFirestore db = FirebaseFirestore.instance;


  static final DataHolder _dataHolder = new DataHolder._internal();

  //para utilizarlo en tods las clases y evitar escribir mal el nombre y que tengamos errores
  String sCOLLECTION_EVENTOS_INFO = "eventos";


  Perfil perfil = Perfil();
  EventsInfo eventsInfo = EventsInfo();

  String sMensaje="";
  EventsInfo selectedEvent = EventsInfo();

  //Para diferenciar la plataforma de ejecución
  late PlatformAdmin platformAdmin;

  DataHolder._internal(){
    sMensaje= "Tu app de eventos de baile";
    platformAdmin=PlatformAdmin();
  }

  factory DataHolder(){
    return _dataHolder;
  }

}

