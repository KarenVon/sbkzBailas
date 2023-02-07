

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbk_bailas/src/Home_Views/Conocenos_View.dart';
import 'package:sbk_bailas/src/Home_Views/Eventos_View.dart';
import 'package:sbk_bailas/src/login_views/Login_View.dart';


class sbkApp extends StatefulWidget {
  @override
  _sbkApp createState() => _sbkApp();

  }

  class _sbkApp extends State<sbkApp>{
    int currentIndex=0;

    final screens=[
      Conocenos_View(),
      Eventos_View(),
      Login_View(),
      Center(child: Text('Asistente', style: TextStyle(fontSize: 60))),
      Center(child: Text('Consultas', style: TextStyle(fontSize: 60))),
    ];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return MaterialApp(
     home: Scaffold(
       body: screens[currentIndex],

           bottomNavigationBar: BottomNavigationBar(
             type: BottomNavigationBarType.fixed,
             backgroundColor: Colors.cyan,
             selectedItemColor: Colors.white,
             unselectedItemColor: Colors.white.withOpacity(.60),
             showUnselectedLabels: false,
             selectedFontSize: 14,
             unselectedFontSize: 14,
             //indice para seleccionar los diferentes botones del bottomNavigationBar
             currentIndex: currentIndex,
             onTap: (index) => setState(() => currentIndex=index),
             items: const [
               BottomNavigationBarItem(
                 icon: Icon(Icons.add_business_outlined),
                 label: 'Conócenos',
               ),
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
