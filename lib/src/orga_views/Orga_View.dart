
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              IconButton(icon: const Icon(Icons.login_outlined),
              onPressed: (){
                FirebaseAuth.instance.signOut();
              },)
        ],
      ),
      backgroundColor: Colors.cyan[50],
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 30, bottom: 50, left: 12, right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              size: 70,
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(child:Container(
              decoration: BoxDecoration(
                color: Colors.cyan[50],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                ),
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ListTile(
                    leading: const Icon(Icons.add_card),
                    title: const Text('Crear un nuevo evento'),
                    onTap: (){},
                  ),
                  ListTile(
                    leading: const Icon(Icons.remove_circle_outline_rounded),
                    title: const Text('Eliminar un evento'),
                    onTap: (){},
                  ),
                  ListTile(
                    leading: const Icon(Icons.login_sharp),
                    title: const Text('Cerrar sesión'),
                    onTap: (){},
                  ),
                  ListTile(
                    leading: const Icon(Icons.group_remove_outlined),
                    title: const Text('Darme de baja'),
                    onTap: (){},
                  ),
                ],

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
