

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  late final EventsInfo filtroEvento;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _eventos();
  }
}

class _eventos extends State<Eventos_View> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String sNombre = "";
  late final String text;

  //Listas para las descargas de firbase
  List<EventsInfo> totalEvents= [];
  List<EventsInfo> nexteventsList= [];
  List<EventsInfo> temp = [];
  List<EventsInfo> kizomba = [];
  List<EventsInfo> salsa = [];
  List<EventsInfo> bachata = [];
  List<EventsInfo> busquedaEventos = [];

  //El Controller para la barra de búsqueda
  final TextEditingController _searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    //obtiene la lista de todos los eventos
    getEventosList();
    //El listener de la barra de búsqueda
    //_searchController.addListener(_onSearchChanged);
  }
 //la función para el listener
  _onSearchChanged(){
    print(_searchController.text);
    searchResultList();
  }


  //llamada a firestore para descargar la lista de eventos para ello creo el objeto totalEventos
  void getEventosList() async {
    final docRef = db.collection("eventos").
    withConverter(fromFirestore: EventsInfo.fromFirestore,
        toFirestore: (EventsInfo eventsinfo, _) => eventsinfo.toFirestore());

    final docsSnap = await docRef.get();

    for (int i = 0; i < docsSnap.docs.length; i++) {
      totalEvents.add(docsSnap.docs[i].data());
    }
    setState(() {
      nexteventsList.clear();
      nexteventsList.addAll(totalEvents);
    });
  }

  void listItemShortClicked(int index) {
    print("DEBUG: " + index.toString());
    print("DEBUG: " + nexteventsList[index].name!);

    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)
    => Selected_Event(selectedEventInfo: nexteventsList[index],)));
  }

  //llamada a firebase para descargar eventos Kizomba
  void getEventosKizomba() async {

    //temp.addAll(nexteventsList);
    kizomba.clear();
    for(var evento in totalEvents) {

      if(evento.type!.compareTo("Kizomba") == 0) {
        kizomba.add(evento);
      }
    }
    setState(() {
      nexteventsList.clear();
      nexteventsList.addAll(kizomba);
    });

  }

  //lamada a firebase para descargar eventos salsa
  void getEventosSalsa() async {

    salsa.clear();
    for(var evento in totalEvents) {

      if(evento.type!.compareTo("Salsa") == 0) {
        salsa.add(evento);
      }
    }
    setState(() {
      nexteventsList.clear();
      nexteventsList.addAll(salsa);
    });

  }
  //llamada a firebase para descargar eventos bachata
  void getEventosBachata() async {

    bachata.clear();
    for(var evento in totalEvents) {
      if(evento.type!.compareTo("Bachata") == 0) {
        bachata.add(evento);
      }
    }
    setState(() {
      nexteventsList.clear();
      nexteventsList.addAll(bachata);
    });
  }

//función de barra de búsqueda
  void searchResultList() async {
    busquedaEventos.clear();
    final documentReference = db.collection("eventos")
        .where("palnombre", arrayContains: FirebaseAuth.instance.currentUser?.uid)
        .withConverter(fromFirestore: EventsInfo.fromFirestore,
        toFirestore: (EventsInfo eventsinfo, _) => eventsinfo.toFirestore());

    final documentoDevuelto = await documentReference.get();

    for (int i = 0; i < documentoDevuelto.docs.length; i++) {
      busquedaEventos.add(documentoDevuelto.docs[i].data());
    }
    setState(() {
      nexteventsList.clear();
      nexteventsList.addAll(busquedaEventos);
    });
    /*
    var showResults = [];
    if(_searchController.text!=""){
      for(var filtroEventos in totalEvents ){
        //var palnombre = filtroEventos['palnombre'].toString().toLowerCase();
        if (widget.filtroEvento.palnombre!.contains(_searchController.text.toLowerCase()))
        {
          showResults.add(filtroEventos);
        }
      }
    }
    else{
      showResults = List.from(totalEvents);
    }
    setState(() {
      busquedaEventos = showResults;
    });*/
  }

@override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shadowColor: Colors.black26,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        foregroundColor: CupertinoColors.white,
          actions: <Widget>[
            TextButton(
              style: style,
              onPressed: (){
                bachata.clear();
                salsa.clear();
                kizomba.clear();
                busquedaEventos.clear();
                nexteventsList.clear();
                nexteventsList.addAll(totalEvents);
              },
              child: const Text('| TODOS |'),
            ),
            TextButton(
              style: style,
              onPressed: (){

                getEventosSalsa();
              },
              child: const Text('| SALSA |'),
            ),
            TextButton(
              style: style,
              onPressed: () {

                getEventosBachata();
              },
              child: const Text('| BACAHATA |'),
            ),
            TextButton(
              style: style,
              onPressed: () {

                getEventosKizomba();
              },
              child: const Text('| KIZOMBA |'),
            ),
            IconButton(icon: const Icon(Icons.notifications_none),
                onPressed: (){ },)
          ],
        ),
      body: Column(
        children: <Widget>[
          AnimSearchBar(
              width: 400,
              textController: _searchController,
              onSuffixTap: {
                setState((){
                  //searchResultList();
          }
                )
          }, onSubmitted: (string ) {  },
              color: Colors.cyan[50],
              helpText: "Inserta nombre del evento...",
              //autoFocus: true,
              closeSearchOnSuffixTap: true,
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
      ),
      ],
    ),
    );

  }
}

