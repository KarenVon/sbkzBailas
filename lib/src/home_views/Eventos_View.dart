

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbk_bailas/src/singleton/DataHolder.dart';

import '../Grid_views/RoomCard.dart';
import '../fb_objects/EventsInfo.dart';

class Eventos_View extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _eventos();
  }
}

class _eventos extends State<Eventos_View> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String sNombre = "---";

  List<EventsInfo> eventosBD = [];

  @override
  void initState() {
    super.initState();
    getEventosList();
  }

  void getEventosList() async {
    final docRef = db.collection("eventos").
    withConverter(fromFirestore: EventsInfo.fromFirestore,
        toFirestore: (EventsInfo eventsinfo, _) => eventsinfo.toFirestore());

    final docsSnap = await docRef.get();

    setState(() {
      for (int i = 0; i < docsSnap.docs.length; i++) {
        eventosBD.add(docsSnap.docs[i].data());
      }
    });
  }

  void listItemShortClicked(int index) {
    //print("DEBUG: " + index.toString());
    //print("DEBUG: " + eventosBD[index].name!);
    DataHolder().selectedEvent = eventosBD[index];

    print(DataHolder().selectedEvent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child:
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: eventosBD.length,
            itemBuilder: (BuildContext context, int index) {

              return GestureDetector(
                child: RoomCard(sImgURL: eventosBD[index].image!,
                sName: eventosBD[index].name!,onShortClick: listItemShortClicked,
                index: index,),
              );
            }
        ),
      ),
    );
  }
}

