
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
  await Future.delayed(Duration(seconds: 3));
  //despues de cargar todos los recursos,
  Navigator.of(context).popAndPushNamed('/sbkapp');
}

    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      //me ayuda a conocer la altura de la pantalla
      DataHolder().platformAdmin.initDisplayData(context);

      //print("DEBUG: LA PLATAFORMA TIENE UNA ALTURA: " +
          DataHolder().platformAdmin.dSCREEN_HEIGHT.toString();

      return Scaffold(
        backgroundColor: Colors.cyan,
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage(widget.sLogoPath),
                  width: DataHolder().platformAdmin.dSCREEN_WIDTH,),
                SizedBox(
                    height: DataHolder().platformAdmin.dSCREEN_HEIGHT / 20),
                Text("CARGANDO...", style: TextStyle(
                    fontSize: DataHolder().platformAdmin.dSCREEN_HEIGHT / 50,
                    color: Colors.white)),
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
