
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../singleton/DataHolder.dart';

class SVLogoWait extends StatefulWidget{

  //para poder cambiar el logo
  final String sLogoPath;
  const SVLogoWait(this.sLogoPath, {super.key});

  @override
  State<StatefulWidget> createState() {

    return _SVLogoWaitState();
  }
}

class _SVLogoWaitState extends State<SVLogoWait> {

  void initState(){
  super.initState();
  if (DataHolder().platformAdmin.isAndroidPlatform() ||
  DataHolder().platformAdmin.isIOSPlatform() ||
  DataHolder().platformAdmin.isWebPlatform()) {

  loadAllData();
  }
  }

  void loadAllData() async {
  //para simular una carga de datos
  await Future.delayed(Duration(seconds: 2));
  //despues de cargar todos los recursos,
  Navigator.of(context).popAndPushNamed('/sbkapp');
}


    // FirebaseAuth.instance.signOut(); //para que se desloguee automaticamente

    /*if (DataHolder().platformAdmin.isAndroidPlatform() ||
        DataHolder().platformAdmin.isIOSPlatform()) {
      loadAllData();
    } else if (DataHolder().platformAdmin.isWebPlatform()) {
      loadAllData();
    }
  }



  //al iniciar sesion por movil te pido iniciar sesion con mail
  void loadAllDataMovil() async {
    //para simular una carga de datos
    await Future.delayed(Duration(seconds: 2));
    //despues de cargar todos los recursos,
    // revisa si el usuario esta logeado o no
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.of(context).popAndPushNamed('/loginview');
    }
    else {
      //revisamos si el usuario esta creado o no
      bool existe = await checkExistingProfile();
      if (existe) {
        setState(() {
          Navigator.of(context).popAndPushNamed('/homeviewgrid');
        });
      }
      else {
        setState(() {
          Navigator.of(context).popAndPushNamed('/onboarding');
        });
      }
    }
  }

  //al iniciar sesion por web te pido iniciar sesion con movil
  void loadAllDataWeb() async {
    await Future.delayed(Duration(seconds: 2));
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.of(context).popAndPushNamed('/loginphoneview');
    }
    else {
      //revisamos si el usuario esta creado o no
      bool existe = await checkExistingProfile();
      if (existe) {
        setState(() {
          Navigator.of(context).popAndPushNamed('/homeviewgrid');
        });
      }
      else {
        setState(() {
          Navigator.of(context).popAndPushNamed('/onboarding');
        });
      }
    }
  }
*/

    /*Future<bool> checkExistingProfile() async {
    //copiado de HomeView y modificado
    String? idUser = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore db = FirebaseFirestore.instance;
    final docRef = db.collection("perfiles").doc(idUser);

    DocumentSnapshot docSnap = await docRef.get();

    return docSnap.exists;
  }*/

    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      //me ayuda a conocer la altura de la pantalla
      DataHolder().platformAdmin.initDisplayData(context);

      print("DEBUG: LA PLATAFORMA TIENE UNA ALTURA: " +
          DataHolder().platformAdmin.dSCREEN_HEIGHT.toString());

      return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage(widget.sLogoPath),
                  width: DataHolder().platformAdmin.dSCREEN_WIDTH,),
                SizedBox(
                    height: DataHolder().platformAdmin.dSCREEN_HEIGHT / 20),
                Text("CARGANDO...", style: TextStyle(
                    fontSize: DataHolder().platformAdmin.dSCREEN_HEIGHT / 20),),
                SizedBox(
                    height: DataHolder().platformAdmin.dSCREEN_HEIGHT / 20),
                const CircularProgressIndicator(
                  semanticsLabel: 'Circular progress indicator',
                ),
              ],
            )

        ),
      );
    }
  }
