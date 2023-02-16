import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Custom_views/KVinputText.dart';
import '../fb_objects/EventsInfo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Orga_View extends StatefulWidget {
  const Orga_View({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _organizador();
  }
}

class _organizador extends State<Orga_View> {
  TextEditingController _controllerNombre = TextEditingController();
  TextEditingController _controllerFecha = TextEditingController();
  TextEditingController _controllerPrecio = TextEditingController();
  TextEditingController _controllerDescripcion = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    //checkExistingProfile();
  }

  void acceptPressed(String name, String descripcion, String date,
      String precio, String imagen, BuildContext context) async {
    //para crear un nuevo evento en firebase usando el objeto evento que hemos creado
    EventsInfo evento = EventsInfo(
        name: name,
        description: descripcion,
        date: date,
        price: precio,
        image: imagen);

    await db
        .collection("eventos")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(evento.toFirestore())
        .onError((e, _) => print("Error writing document: $e"));
    //Navigator.of(context).popAndPushNamed("/homeview");
  }

  GlobalKey<FormState> key = GlobalKey();
  CollectionReference _reference =
      FirebaseFirestore.instance.collection("eventos");
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    KVInputText inputNombre = KVInputText(
        iLongitudPalabra: 50,
        sHelperText: "Escriba el nombre del evento",
        sTitulo: "Evento",
        icIzq: Icon(Icons.near_me_rounded));
    KVInputText inputFecha = KVInputText(
        iLongitudPalabra: 30,
        sHelperText: "Escriba la fecha en la que tendrá lugar",
        sTitulo: "Fecha",
        icIzq: Icon(Icons.calendar_month_rounded));
    KVInputText inputPrecio = KVInputText(
        iLongitudPalabra: 5,
        sHelperText: "Escriba el precio del fullpass",
        sTitulo: "€",
        icIzq: Icon(Icons.monetization_on));
    KVInputText inputDescripcion = KVInputText(
        iLongitudPalabra: 300,
        sHelperText: "Escriba una breve descripción del evento",
        sTitulo: "Descripción",
        icIzq: Icon(Icons.description));
    KVInputText inputImagen = KVInputText(
        iLongitudPalabra: 100,
        //sHelperText: "Inserte la imagen de su evento",
        sTitulo: "Imagen",
        icIzq: Icon(Icons.image));

    return Scaffold(
      appBar: AppBar(
          backgroundColor: CupertinoColors.white,
          leading: const Image(image: AssetImage("assets/logo.png")),
          title: const Text('Añade un Evento'),
          foregroundColor: Colors.cyan),
      backgroundColor: Colors.cyan.shade500,
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 30, bottom: 50, left: 12, right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputNombre,
            inputFecha,
            inputPrecio,
            inputDescripcion,
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 40),
              child: FloatingActionButton(
                onPressed: () async {
                  /*Step 1: PickImage
                    * Install image_picker : flutter pub add image_picker
                    * import the corresponding library*/

                  ImagePicker imagePicker = ImagePicker();
                  XFile? file =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  print('${file?.path}');

                  if (file == null) return;
                  //Import dart:core
                  String uniqueFileName =
                      DateTime.now().millisecondsSinceEpoch.toString();

                  /*Step 2: uploas to Firebae storage
                    * Install farebase_storage: flutter pub add firebase_storage
                    * import the corresponding library: import 'package:firebase_storage/firebase_storage.dart';*/

                  //Get a reference to storage root
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referenceDirImages = referenceRoot.child('images');

                  //Create a reference for the image to be stored
                  Reference referenceImageToUpload =
                      referenceDirImages.child(uniqueFileName);

                  //Handle errors/success
                  try {
                    //Store the file
                    await referenceImageToUpload.putFile(File(file!.path));
                    //Success: get the download URL
                    imageUrl = await referenceImageToUpload.getDownloadURL();
                  } catch (error) {
                    //Some error ocurred
                  }
                },
                backgroundColor: CupertinoColors.white,
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.cyan,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (imageUrl.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please upload an image')));
                  return;
                }
                if (key.currentState!.validate()) {
                  String itemNombre = _controllerNombre.text;
                  String itemFecha = _controllerFecha.text;
                  String itemPrecio = _controllerPrecio.text;
                  String itemDescripcion = _controllerDescripcion.text;

                 Map<String, String> dataToSend = {
                    'nombre': itemNombre,
                    'fecha': itemFecha,
                    'precio': itemPrecio,
                    'descripcion': itemDescripcion,
                    'imagen': imageUrl,
                  };
                  //Add a new item
                  _reference.add(dataToSend);

                  acceptPressed(
                      inputNombre.getText()!,
                      inputFecha.getText()!,
                      inputPrecio.getText()!,
                      inputDescripcion.getText()!,
                      inputImagen.getText()!,
                      context);
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black12),
                  textStyle: MaterialStateProperty.all(
                      const TextStyle(fontSize: 15))),
              child: const Text('Agregar Evento'),
            ),
          ],
        ),
      ),
    );
  }
}
