
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbk_bailas/src/singleton/DataHolder.dart';
import 'users_Views/Eventos_View.dart';
import 'orga_Views/Orga_View.dart';
import 'users_Views/sbkApp.dart';
import 'initial_views/Login_View.dart';
import 'initial_views/Register_View.dart';
import 'initial_views/SVLogoWait.dart';

class App extends StatelessWidget{

  App({Key? key}) : super(key:key);

  FirebaseFirestore db = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    // This makes the visual density adapt to the platform that you run
    // the app on. For desktop platforms, the controls will be smaller and
    // closer together (more dense) than on mobile platforms.
    VisualDensity.adaptivePlatformDensity;

    MaterialApp materialAppMobile= MaterialApp(
      /*title: 'Custom Fonts',
      // Establecer Raleway como la fuente predeterminada de la aplicación
      theme: ThemeData(fontFamily: 'Raleway'),
      home: sbkApp(),*/
    );

    if (DataHolder().platformAdmin.isAndroidPlatform() ||
        DataHolder().platformAdmin.isIOSPlatform()) {
      materialAppMobile = MaterialApp(
      title: 'SBKZ bailas',
      initialRoute: '/splashview',

      routes: {
        '/sbkapp':(context) => sbkApp(),
        '/loginview':(context) => Login_View(),
        '/registroview':(context) =>  Register_View(),
        '/eventosview':(context) => Eventos_View(),
        '/orgaview':(context) => Orga_View(),
        '/splashview': (context) => const SVLogoWait("assets/logo.png"),

      },
    );
  }

    else if (DataHolder().platformAdmin.isWebPlatform()) {
      materialAppMobile = MaterialApp(
        title: "Log in App Karen",
        //initialRoute: isUserLogged(),
        initialRoute: '/splashview',
        routes: {
          '/sbkapp':(context) => sbkApp(),
          '/loginview':(context) => Login_View(),
          '/registroview':(context) =>  Register_View(),
          '/eventosview':(context) => Eventos_View(),
          '/orgaview':(context) => Orga_View(),
          '/splashview': (context) => const SVLogoWait("assets/abrazo.png"),
        },
      );
    }

    return materialAppMobile;
  }


}