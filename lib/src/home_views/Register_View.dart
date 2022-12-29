

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Custom_views/KVinputText.dart';

class Register_View extends StatelessWidget {

 const Register_View({Key? key}) : super (key:key);

 Future<void> registerPressed(String emailAddress, String password, BuildContext context) async {
   try {
     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: emailAddress,
       password: password,
     );
     Navigator.of(context).popAndPushNamed('/orgavieew');
   } on FirebaseAuthException catch (e) {
     if (e.code == 'weak-password') {
       print('The password provided is too weak.');
     } else if (e.code == 'email-already-in-use') {
       print('The account already exists for that email.');
     }
   } catch (e) {
     print(e);
   }
 }

  @override
  Widget build(BuildContext context) {

    //subo aqui arriba los inputText para poder usarlos en el loginpressed
    KVInputText inputUser= KVInputText (iLongitudPalabra: 50,
      sHelperText: 'introduzca usuario',
      sTitulo: 'USUARIO',
      icIzq: Icon(Icons.account_circle_outlined),);

    KVInputText inputPass= KVInputText(iLongitudPalabra: 20,
      sHelperText: 'introduzca una contraseña',
      sTitulo: 'PASSWORD',
      icIzq: Icon(Icons.password),
      blIsPasswordInput: true,);

    KVInputText inputPassBis= KVInputText(iLongitudPalabra: 20,
      sHelperText: 'repita la contraseña',
      sTitulo: 'REPIT PASSWORD',
      icIzq: Icon(Icons.password),
      blIsPasswordInput: true,);

    return Scaffold(
      backgroundColor: Colors.black12,
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
                  inputPassBis,
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 12,
                          color: Colors.white,fontWeight:FontWeight.bold ),
                    ),
                    onPressed: () {},
                    child: const Text('Quiero registrarme.'),
                  ),

                  // const SizedBox(height: 10),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: (){
                            print("----->>>>>>>> REGISTRO ACEPTAR");
                          },
                          child: Text ("Aceptar"),
                        ),
                        OutlinedButton(
                          onPressed: (){
                            print("----->>>>>>>> REGISTRO CANCELAR");
                            Navigator.of(context).popAndPushNamed('/loginview');

                          },
                          child: Text ("Cancelar"),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
      ),
    );
  }
}
