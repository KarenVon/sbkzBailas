

import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbk_bailas/src/custom_widgets/AnimSearchBar.dart';
import 'package:sbk_bailas/src/home_views/Selected_Event.dart';
import '../Grid_views/RoomCard.dart';
import '../fb_objects/EventsInfo.dart';

/*Vista que nos muestra todos los eventos que están creados y guardados en firebase
* esta creado con un grid view que meustra la imagen del evento que esta en firebase
* y el nnombre del evento, cuando hago click en un evento me llega a Selected_event*/
class Eventos_View extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _eventos();
  }
}

class _eventos extends State<Eventos_View> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String sNombre = "";

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

  //queries:
    final salsaQuery = docRef.where("type", isEqualTo: "Salsa");
    final bachataQuery = docRef.where("type", isEqualTo: "Bachata");
    final kizombaQuery = docRef.where("type", isEqualTo: "Kizomba");

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
    final ButtonStyle style = TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shadowColor: Colors.black26,
    );
    final _seachController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        foregroundColor: CupertinoColors.white,
          actions: <Widget>[
            TextButton(
              style: style,
              onPressed: (){},

              child: const Text('| SALSA |'),
            ),
            TextButton(
              style: style,
              onPressed: () {},
              child: const Text('| BACAHATA |'),
            ),
            TextButton(
              style: style,
              onPressed: () {},
              child: const Text('| KIZOMBA |'),
            ),
            IconButton(icon: Icon(Icons.notifications_none),
                onPressed: (){

             },)
          ],
        ),
      body: Column(
        children: <Widget>[
          AnimSearchBar(
              width: 400,
              textController: _seachController,
              onSuffixTap: {
                setState((){
          }
                )
          }, onSubmitted: (String ) {  },
          ),
          Expanded(
            child: GridView.builder(
            scrollDirection: Axis.vertical,
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
          // !_searchBoolean ? _defaultListView() : _searchListView()
        //como hago para que por defecto carguen todos pero si uso el buscador que solo me cargue la busqueda
      ),
      ],
    ),
    );

  }
}

