
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbk_bailas/src/Home_Views/sbkApp.dart';

import '../Home_Views/Eventos_View.dart';
import '../Home_Views/Login_View.dart';

class App extends StatelessWidget{

  const App({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Tu aplicación de baile',
      initialRoute: '/sbkapp',
      routes: {
        '/sbkapp':(context) => sbkApp(),
        '/loginview':(context) => Login_View(),
        '/eventosview':(context) => Eventos_View(),

      },
    );
  }

}