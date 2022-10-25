

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbk_bailas/src/Home_Views/Eventos_View.dart';
import 'package:sbk_bailas/src/Home_Views/Login_View.dart';

class sbkApp extends StatefulWidget {
  @override
  _sbkApp createState() => _sbkApp();
  }

  class _sbkApp extends State<sbkApp>{
    int currentIndex=0;

    final screens=[
      Eventos_View(),
      Login_View(),
    ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return MaterialApp(
     home: Scaffold(
       body: Container(
         decoration:const BoxDecoration(
           gradient: LinearGradient(
             begin: Alignment.topCenter,
             end: Alignment(0.1, 0.4),
             colors: [Colors.white,Colors.black12],
           ),
         ),
         child: Column(
           children: [
             Container(
               padding: const EdgeInsets.all(40),
               //margin: const EdgeInsets.only(bottom: 20),
               child: Image.asset('assets/logo.png'),
             ),
             Container(
               padding: const EdgeInsets.only(top: 40.0),
               child: const Text ('Bienvenid@ a tu aplicación favorita de baile.\n '
                   'Aquí encontrarás todos los eventos\n de moda del momento.\n\n'
                   '¡Manténte informado!',
               style: TextStyle(fontFamily: AutofillHints.familyName,
                   fontSize: 16,
                   fontWeight: FontWeight.bold,
                   color: Colors.cyan,),
               textAlign: TextAlign.center,
               ),
             ),
           ],
         ),
       ),


           bottomNavigationBar: BottomNavigationBar(
             type: BottomNavigationBarType.fixed,
             backgroundColor: Colors.cyan,
             selectedItemColor: Colors.white,
             unselectedItemColor: Colors.white.withOpacity(.60),
             selectedFontSize: 14,
             unselectedFontSize: 14,
             //indice para seleccionar los diferentes botones del bottomNavigationBar
             currentIndex: currentIndex,
             onTap: (index) => setState(() => currentIndex=index),
             items: const [
               BottomNavigationBarItem(
                 icon: Icon(Icons.menu),
                 label: 'Eventos',
               ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.account_circle_sharp),
                 label: 'Organizador',
               ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.account_circle_sharp),
                 label: 'Asistente',
               ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.ad_units),
                 label: 'Contacta',
               ),
             ],
           ),
    ),
   );

  }
  }
