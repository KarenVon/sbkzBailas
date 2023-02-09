

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbk_bailas/src/home_views/Selected_Event.dart';
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

  List<EventsInfo> nexteventsList= [];

  @override
  void initState() {
    super.initState();
    getEventosList();
  }

  //llamada a firestore para descargar la lista de eventos para ello creo el objeto NextEvents
  void getEventosList() async {

    final docRef = db.collection("eventos").
    withConverter(fromFirestore: EventsInfo.fromFirestore,
        toFirestore: (EventsInfo eventsinfo, _) => eventsinfo.toFirestore());

    final docsSnap = await docRef.get();

    setState(() {
      for (int i = 0; i < docsSnap.docs.length; i++) {
        nexteventsList.add(docsSnap.docs[i].data());
      }
    });
  }

  void listItemShortClicked(int index) {
    print("DEBUG: " + index.toString());
    print("DEBUG: " + nexteventsList[index].name!);
    //DataHolder().selectedEvent = eventosBD[index];
   // print(DataHolder().selectedEvent);

    //DataHolder().selectedEvent = nexteventsList[index];
    //Navigator.of(context).pushNamed("/evento");

    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)
    => Selected_Event(selectedEventInfo: nexteventsList[index],)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: nexteventsList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: RoomCard(sImgURL: nexteventsList[index].image!,
                sName: nexteventsList[index].name!,onShortClick: listItemShortClicked,
                index: index,),
              );
            }
        ),
      ),
    );
  }
}

