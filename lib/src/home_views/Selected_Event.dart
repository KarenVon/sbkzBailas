import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbk_bailas/src/fb_objects/EventsInfo.dart';
import 'package:sbk_bailas/src/singleton/DataHolder.dart';

/*Vista que nos muestra el eventos seleccionado desde la vista Eventos_view
* en esta vista podemos ver más detalles sobre el evento y además tiene un
* custom scroll view que hace que se carge la imagen en la parte superior de la pantalla
* y que se pueda deslizar la info del evento*/

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
          title: Text("${widget.selectedEventInfo.name}",
            style: const TextStyle(fontFamily: 'RobotoMono'),),
          foregroundColor: CupertinoColors.white,
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              backgroundColor: Colors.white,
              flexibleSpace:  FlexibleSpaceBar(
                background: Image.network('${widget.selectedEventInfo.image}'),
              ),
        ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 2, left: 10, right: 10),
                    child: const Text ('DESCRIPCIÓN',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        decoration: TextDecoration.underline,
                        shadows: [Shadow(color: Colors.cyan, blurRadius: 2)]
                      ),),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 5, left: 10, right: 10),
                    margin: EdgeInsets.fromLTRB(7, 7, 7, 7),
                    alignment: Alignment.center,
                    child: Text(
                        style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        //decoration: TextDecoration.underline,
                        //shadows: [Shadow(color: Colors.white, blurRadius: 10)]
                        ),
                        "${widget.selectedEventInfo.description}"),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 2, left: 10, right: 10),
                    child: const Text ('FECHA:',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          decoration: TextDecoration.underline,
                          shadows: [Shadow(color: Colors.cyan, blurRadius: 2)]
                      ),),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 5, left: 10, right: 10),
                    margin: EdgeInsets.fromLTRB(7, 7, 7, 7),
                    alignment: Alignment.center,
                    child: Text(
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            //decoration: TextDecoration.underline,
                           // shadows: [Shadow(color: Colors.black26, blurRadius: 1)]
                        ),
                        "${widget.selectedEventInfo.date}"),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 2, left: 10, right: 10),
                    child: const Text ('ENTRADAS:',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          decoration: TextDecoration.underline,
                          shadows: [Shadow(color: Colors.cyan, blurRadius: 2)]
                      ),),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 5, left: 10, right: 10),
                    margin: EdgeInsets.fromLTRB(7, 7, 7, 7),
                    alignment: Alignment.center,
                    child: Text(
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            //decoration: TextDecoration.underline,
                            //shadows: [Shadow(color: Colors.cyan, blurRadius: 2)]
                        ),
                        "${widget.selectedEventInfo.price}"),
                  ),
                ],
              ),
            ),
            ],
    ),
    );
  }
}
