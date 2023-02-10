

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Custom_views/KVinputText.dart';
import '../fb_objects/EventsInfo.dart';

class Orga_View extends StatefulWidget {

  const Orga_View({Key? key}) : super (key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _organizador();
  }
}

class _organizador extends State<Orga_View>{
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    //checkExistingProfile();
  }


  void acceptPressed(String name, String descripcion, String date, String precio,
      BuildContext context) async {

    //para crear un nuevo evento en firebase usando el objeto evento que hemos creado
    EventsInfo evento = EventsInfo(name: name, description: descripcion, date: date, price: precio);

    await db.collection("eventos").doc(FirebaseAuth.instance.currentUser?.uid)
        .set(evento.toFirestore()).onError((e, _) =>
        print("Error writing document: $e"));

    //Navigator.of(context).popAndPushNamed("/homeview");
  }

  @override
  Widget build(BuildContext context) {

    KVInputText inputNombre = KVInputText(
      iLongitudPalabra: 30,
      sHelperText: "Escriba el nombre del evento",
      sTitulo: "Evento",
      icIzq: Icon(Icons.near_me_rounded));
    KVInputText inputFecha = KVInputText(
      iLongitudPalabra: 12,
      sHelperText: "Escriba la fecha en la que tendrá lugar",
      sTitulo: "Fecha",
      icIzq: Icon(Icons.calendar_month_rounded));
    KVInputText inputPrecio = KVInputText(
      iLongitudPalabra: 5,
      sHelperText: "Escriba el precio del fullpass",
      sTitulo: "€",
      icIzq: Icon(Icons.monetization_on));
    KVInputText inputDescripcion = KVInputText(
      iLongitudPalabra: 60,
      sHelperText: "Escriba una breve descripción del evento",
      sTitulo: "Descripción",
      icIzq: Icon(Icons.description));
    KVInputText inputImagen = KVInputText(
      iLongitudPalabra: 60,
      sHelperText: "Inserte la imagen de su evento",
      sTitulo: "Imagen",
      icIzq: Icon(Icons.image));


    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.white,
        leading: const Image(image: AssetImage("assets/logo.png")),
        title: const Text('Añade un Evento'),
        foregroundColor: Colors.cyan
      ),
      backgroundColor: Colors.cyan.shade500,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30, bottom:50,left: 12 ,right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputNombre,
            inputFecha,
            inputPrecio,
            inputDescripcion,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    acceptPressed(inputNombre.getText()!, inputFecha.getText()!,
                        inputPrecio.getText()!, inputDescripcion.getText()!,
                        context);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.black12),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 15))),
                  child: const Text('Aceptar'),

                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
