import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbk_bailas/src/Home_Views/Orga_View.dart';
import 'package:sbk_bailas/src/login_views/Register_View.dart';

import '../Custom_views/KVinputText.dart';
import 'TermsOfUse.dart';

class Login_View extends StatelessWidget {
  Login_View({Key? key}) : super(key: key);

  //función para logearse con el usuario creado en consola firebase
  void loginPressed(
      String emailAddress, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      print("ME HE LOGEADO");
      Navigator.of(context).popAndPushNamed('/orgaview');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('DEBUG: No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('DEBUG: Wrong password provided for that user.');
      } else {
        print('DEBUG: ' + e.toString());
      }
    }
  }

  void irRegistro(context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => Register_View()));
  }

  @override
  Widget build(BuildContext context) {
    //subo aqui arriba los inputText para poder usarlos en el loginpressed
    KVInputText inputUser = KVInputText(
        iLongitudPalabra: 50,
        sHelperText: 'introduzca su usuario',
        sTitulo: 'USUARIO',
        icIzq: Icon(Icons.account_circle_outlined),
        textEditingController: TextEditingController());

    KVInputText inputPass = KVInputText(
        iLongitudPalabra: 20,
        sHelperText: 'introduzca su contraseña',
        sTitulo: 'PASSWORD',
        icIzq: Icon(Icons.password),
        blIsPasswordInput: true,
        textEditingController: TextEditingController());

    return Scaffold(
      //backgroundColor: Colors.black12,
      body: ListView(
        children: [
          Container(
            //padding: const EdgeInsets.all(5),
            //margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            alignment: Alignment.center,
            child: Image.asset('assets/abrazo.png'),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
            margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
            decoration: BoxDecoration(
              color: Colors.cyan,
              border: Border.all(color: Colors.cyan, width: 4),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //los hemos subido arriba, encima del scaffold
                inputUser,
                inputPass,
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    print("Registrandome");
                    //Navigator.of(context).pushNamed('/registroview');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Register_View()));
                  },
                  child: const Text('Quiero registrarme.'),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.cyan),
                      textStyle: MaterialStateProperty.all(
                          TextStyle(fontSize: 15, color: Colors.white))),
                  onPressed: () {
                    //print("----->>>>>>>> ME HE LOGEADO "+inputUser.getText()+" "+inputPass.getText());
                    //loginPressed(inputUser.getText(),inputPass.getText(),context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Orga_View()));
                  },
                  child: const Text("LOGIN"),
                  //  style: TextStyle(color: Colors.cyan),
                ),
                //clase para añadir terminos y condiciones + política de privacidad
                TermsOfUse()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
