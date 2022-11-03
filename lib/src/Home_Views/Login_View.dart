

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbk_bailas/src/Custom_views/KVinputText.dart';

class Login_View extends StatelessWidget {

  Login_View({Key? key}) : super (key:key);

  //función para logearse con el usuario creado en consola firebase
  void loginPressed(String emailAddress, String password, BuildContext context) async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );

      print("ME HE LOGEADO");
      Navigator.of(context).popAndPushNamed('/orgaview');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('DEBUG: No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('DEBUG: Wrong password provided for that user.');
      }
      else{
        print('DEBUG: '+e.toString());
      }
    }

  }

  @override
  Widget build(BuildContext context) {

    //subo aqui arriba los inputText para poder usarlos en el loginpressed
    KVInputText inputUser= KVInputText (iLongitudPalabra: 50,
      sHelperText: 'introduzca su usuario',
      sTitulo: 'USUARIO',
      icIzq: Icon(Icons.account_circle_outlined),);

    KVInputText inputPass= KVInputText(iLongitudPalabra: 20,
    sHelperText: 'introduzca su contraseña',
    sTitulo: 'PASSWORD',
    icIzq: Icon(Icons.password),
    blIsPasswordInput: true,);

    return Scaffold(
      backgroundColor: Colors.black12,
        body: ListView(
          children: [
            /*Container(
                padding: EdgeInsets.all(5),
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                alignment: Alignment.center,
                child: const Text('¡Bailemos la vida!',
                  style: TextStyle(
                    fontFamily: 'rcBold',
                    fontSize: 30,
                  ),
                ),
            ),*/
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
              border: Border.all(color: Colors.cyan,
              width: 4),
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
                    textStyle: const TextStyle(fontSize: 12,
                        color: Colors.white,fontWeight:FontWeight.bold ),
                  ),
                  onPressed: () {
                    print("Registrandome");
                    Navigator.of(context).popAndPushNamed('/registroview');
                  },
                  child: const Text('Quiero registrarme.'),
                ),

               // const SizedBox(height: 10),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: (){
                          print("----->>>>>>>> ME HE LOGEADO "+inputUser.getText()+" "+inputPass.getText());
                          loginPressed(inputUser.getText(),inputPass.getText(),context);
                        },
                        child: Text ("Login"),
                        //  style: TextStyle(color: Colors.cyan),
                      ),
        ],
      ),
      ),

                ],
              ),
            )
    ]
        ),
    );
  }
  }
