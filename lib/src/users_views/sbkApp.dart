import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbk_bailas/src/users_Views/Eventos_View.dart';
import '../initial_views/Login_View.dart';


/*Vista desde donde se van mostrando las diferentes vista del navigationBar*/
class sbkApp extends StatefulWidget {
  // The navigator key is necessary to navigate using static methods
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  @override
  _sbkApp createState() => _sbkApp();
}

class _sbkApp extends State<sbkApp> {



  //navigation bar:
  int currentIndex = 0;
  final screens = [
    Eventos_View(),
    Login_View(),
    //Register_View(),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //return MaterialApp(
      //home:
     return Scaffold(
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
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Eventos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_sharp),
              label: 'Organizador',
            ),

            //BottomNavigationBarItem(
            //  icon: Icon(Icons.ad_units),
            //  label: 'Contacta',
            //),
          ],
        ),
      //),
    );
  }
}
