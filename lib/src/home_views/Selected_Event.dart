import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbk_bailas/src/fb_objects/EventsInfo.dart';
import 'package:sbk_bailas/src/singleton/DataHolder.dart';

class Selected_Event extends StatefulWidget {
  
  final EventsInfo selectedEventInfo;
  Selected_Event({super.key, required this.selectedEventInfo});

  @override
  State<StatefulWidget> createState() {
    return _evento();
  }
}

class _evento extends State<Selected_Event> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    descargarEventos();
  }

  Future<void> descargarEventos() async {
    String path = DataHolder().sCOLLECTION_EVENTOS_INFO +
        "/" + DataHolder().selectedEvent.uid; //ojo es variable

    final docRef = db.collection(path).withConverter(
        fromFirestore: EventsInfo.fromFirestore,
        toFirestore: (EventsInfo eventsInfo, _) => eventsInfo.toFirestore());

    final docSnap = await docRef.get();

    setState(() {
      for (int i = 0; i < docSnap.docs.length; i++) {
        //eventsInfo.add(docSnap.docs[i].data()); //descargar los eventos
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          //leading: Icon(Icons.menu),
          leading: const Image(image: AssetImage("assets/logoSolo.png")),
          title: Text("${widget.selectedEventInfo.name}"),
          foregroundColor: CupertinoColors.white,
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ],
        ),
        body:
        SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 25, bottom: 20, left: 10, right: 10),
              margin: EdgeInsets.fromLTRB(7, 7, 7, 7),
              alignment: Alignment.center,
              child: Text(
                  style: const TextStyle(
                    fontFamily: 'rcBold',
                    fontSize: 18,
                  ),
                  "${widget.selectedEventInfo.description}"),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 20, left: 10, right: 10),
              margin: EdgeInsets.fromLTRB(7, 7, 7, 7),
              alignment: Alignment.center,
              child: Text(
                  style: const TextStyle(
                    fontFamily: 'rcBold',
                    fontSize: 18,
                  ),
                  "${widget.selectedEventInfo.date}"),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 200, left: 10, right: 10),
              margin: EdgeInsets.fromLTRB(7, 7, 7, 7),
              alignment: Alignment.center,
              child: Text(
                  style: const TextStyle(
                    fontFamily: 'rcBold',
                    fontSize: 18,
                  ),
                  "${widget.selectedEventInfo.price}"),
            ),
          ],
        ),
        ),
    );
  }
}
