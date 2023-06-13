
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbk_bailas/src/users_views/sbkApp.dart';
import 'package:sbk_bailas/src/orga_views/CrearEvento_View.dart';
import '../initial_views/Register_View.dart';
import 'EventosCreados_View.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.cyan,
          leading: const Image(image: AssetImage("assets/logo.png")),
          title: const Text('BIENVENIDO ORGANIZAD@R'),
          foregroundColor: Colors.white,
            actions: <Widget>[
              IconButton(icon: const Icon(Icons.home_filled),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => sbkApp()));
              },)
        ],
      ),
      backgroundColor: Colors.cyan[50],
      body: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ListTile(
                    leading: const Icon(Icons.add_card),
                    title: const Text('Crear un nuevo evento'),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CrearEvento_View()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.remove_circle_outline_rounded),
                    title: const Text('Eliminar o modificar un evento'),
                    onTap: (){
                     Navigator.push(context,
                          MaterialPageRoute(builder: (_) => EventosCreados_View()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.login_sharp),
                    title: const Text('Cerrar sesión'),
                    onTap: (){
                       FirebaseAuth.instance.signOut();
                       Navigator.push(context,
                           MaterialPageRoute(builder: (_) => sbkApp()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.group_remove_outlined),
                    title: const Text('Darme de baja'),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Register_View()));
                    },
                  ),
                ],
                ),
        );

  }
}
