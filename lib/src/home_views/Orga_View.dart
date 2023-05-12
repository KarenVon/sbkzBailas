import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Custom_widgets/KVinputText.dart';
import '../fb_objects/EventsInfo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

/*Vista del organizador desde donde puede crear eventos para que se carguen en firebase,
* es necesario que el evento tenga una foto para que se pueda subir a firebase.
* Solamente aquellas personas que sean organizadoras y quieran subir un evento deben
* registrarse como usuario*/
class Orga_View extends StatefulWidget {
  const Orga_View({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _organizador();
  }
}

class _organizador extends State<Orga_View> {

  KVInputText inputNombre = KVInputText(
      iLongitudPalabra: 50,
      sHelperText: "Escriba el nombre del evento",
      sTitulo: "Evento",
      icIzq: Icon(Icons.near_me_rounded),
      textEditingController: TextEditingController());
  KVInputText inputFecha = KVInputText(
      iLongitudPalabra: 30,
      sHelperText: "Escriba la fecha en la que tendrá lugar",
      sTitulo: "Fecha",
      icIzq: Icon(Icons.calendar_month_rounded),
      textEditingController: TextEditingController());
  KVInputText inputPrecio = KVInputText(
      iLongitudPalabra: 5,
      sHelperText: "Escriba el precio del fullpass",
      sTitulo: "€",
      icIzq: Icon(Icons.monetization_on),
      textEditingController: TextEditingController());
  KVInputText inputDescripcion = KVInputText(
      iLongitudPalabra: 300,
      sHelperText: "Escriba una breve descripción del evento",
      sTitulo: "Descripción",
      icIzq: Icon(Icons.description),
      textEditingController: TextEditingController());
  KVInputText inputImagen = KVInputText(
      iLongitudPalabra: 100,
      //sHelperText: "Inserte la imagen de su evento",
      sTitulo: "Imagen",
      icIzq: Icon(Icons.image),
      textEditingController: TextEditingController());


  bool _isButtonDisabled=true;

  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
  }

  void acceptPressed(EventsInfo evento, BuildContext context) async {
    await db.collection("eventos").add(evento.toFirestore());

  }
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {


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

                  /*Step 2: upload to Firebae storage
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
                    setState(() {
                      _isButtonDisabled=false;
                    });
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
                //print("---------->>>>>>>>> 2222222222"+imageUrl.toString());
                if (_isButtonDisabled) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Debes insertar una imagen')));
                }
                else {
                  String itemNombre = inputNombre.getText()!;
                  String itemFecha = inputFecha.getText()!;
                  String itemPrecio = inputPrecio.getText()!;
                  String itemDescripcion = inputDescripcion.getText()!;

                  //para crear un nuevo evento en firebase usando el objeto evento que hemos creado
                  EventsInfo evento = EventsInfo(
                      name: itemNombre,
                      description: itemDescripcion,
                      date: itemFecha,
                      price: itemPrecio,
                      image: imageUrl);

                  acceptPressed(
                      evento,
                      context);
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black12),
                  textStyle: MaterialStateProperty.all(
                      const TextStyle(fontSize: 15))),
              child: _isButtonDisabled ? null : const Text('Agregar Evento'),

            ),
          ],
        ),
      ),
    );
  }
}
