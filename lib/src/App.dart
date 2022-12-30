
import 'package:flutter/material.dart';
import 'package:sbk_bailas/src/Home_Views/Conocenos_View.dart';
import 'package:sbk_bailas/src/Home_Views/Evento_Seleccionado.dart';
import 'package:sbk_bailas/src/Home_Views/Register_View.dart';
import 'package:sbk_bailas/src/Home_Views/sbkApp.dart';
import 'package:sbk_bailas/src/singleton/DataHolder.dart';
import 'Home_Views/Eventos_View.dart';
import 'Home_Views/Login_View.dart';
import 'Home_Views/Orga_View.dart';
import 'login_views/SVLogoWait.dart';

class App extends StatelessWidget{

  const App({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    // This makes the visual density adapt to the platform that you run
    // the app on. For desktop platforms, the controls will be smaller and
    // closer together (more dense) than on mobile platforms.
    VisualDensity.adaptivePlatformDensity;

    MaterialApp materialAppMobile=const MaterialApp();

    if (DataHolder().platformAdmin.isAndroidPlatform() ||
        DataHolder().platformAdmin.isIOSPlatform()) {
      materialAppMobile = MaterialApp(
      title: 'SBKZ bailas',
      initialRoute: '/splashview',
      routes: {
        '/sbkapp':(context) => sbkApp(),
        '/conocenosview':(context) => Conocenos_View(),
        '/loginview':(context) => Login_View(),
        '/registroview':(context) => const Register_View(),
        '/eventosview':(context) => Eventos_View(),
        '/orgaview':(context) => Orga_View(),
        '/evento':(context) => Evento_Seleccionado(),
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
          '/conocenosview':(context) => Conocenos_View(),
          '/loginview':(context) => Login_View(),
          '/registroview':(context) => const Register_View(),
          '/eventosview':(context) => Eventos_View(),
          '/orgaview':(context) => Orga_View(),
          '/evento':(context) => Evento_Seleccionado(),
          '/splashview': (context) => const SVLogoWait("assets/abrazo.png"),
        },
      );
    }

    return materialAppMobile;
  }


}