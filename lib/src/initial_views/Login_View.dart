import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbk_bailas/src/Orga_views/CrearEvento_View.dart';
import '../custom_widgets/KVinputText.dart';
import 'Register_View.dart';
import 'TermsOfUse.dart';

/*Vista desde donde los organizadores puedes logearse para crear eventos,
* en esta vista estan los terminos de uso, política y privacidad*/

class Login_View extends StatelessWidget {
  Login_View({Key? key}) : super(key: key);


  //función para logearse con el usuario creado en consola firebase
  void loginPressed(
      String emailAddress, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      print("ME HE LOGEADO");
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const CrearEvento_View()));
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

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //subo aqui arriba los inputText para poder usarlos en el loginpressed
    KVInputText inputUser = KVInputText(
        iLongitudPalabra: 50,
        //sHelperText: 'introduzca su usuario',
        sTitulo: 'USUARIO',
        icIzq: const Icon(Icons.account_circle_outlined),
        textEditingController: TextEditingController(),
        validator: (String? value) {
          if (value!.isEmpty ||
              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
            return "EMAIL NO VALIDO";
          } else {
            return null;
          }
        });
    KVInputText inputPass = KVInputText(
        iLongitudPalabra: 20,
        //sHelperText: 'introduzca su contraseña',
        sTitulo: 'CONTRASEÑA',
        icIzq: const Icon(Icons.password),
        blIsPasswordInput: true,
        textEditingController: TextEditingController(),
        validator: (String? value) {
          print("---------->>>>>>>>>>>>>>>!!!!!!!!!!!!!!!!!!!!! ");
          if (value!.isEmpty || value.length!<6 ) {
            return "CONTRASEÑA INCORRECTA";
          } else {
            return null;
          }
        });

    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.cyan,
        leading: Image(image: AssetImage("assets/logoSolo.png")),
        title: const Text('BIENVENIDO ORGANIZAD@R'),
        foregroundColor: CupertinoColors.white,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ],
      ),
      backgroundColor: Colors.cyan[50],
      body: Form(
        key: _formkey,
        child:ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 25, 10, 12),
            margin: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            child: Text('¿Eres organizador de eventos de baile?',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'RobotoMono',fontSize: 20, fontWeight: FontWeight.bold,
                  color: Colors.black),),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 5, 10, 30),
            child: const Text('En SBKZ bailamos nos encargamos de gestionar tu evento.',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'RobotoMono',fontSize: 12, fontWeight: FontWeight.bold,
                  color: Colors.black),),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            /*decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.cyan, width: 4),
              borderRadius: BorderRadius.circular(5),
            ),*/
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //los hemos subido arriba, encima del scaffold
                inputUser,
                inputPass,
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.cyan),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 15, color: Colors.white))),
                  onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        //print("----->>>>>>>> VALIDACION BIEN ");
                        loginPressed(
                            inputUser.getText()!, inputPass.getText()!, context);
                      }
                      else{
                        //print("----->>>>>>>> FALLA VALIDACION ");
                      }
                  },
                  child: const Text("LOGIN"),
                  //  style: TextStyle(color: Colors.cyan),
                ),
                //clase para añadir terminos y condiciones + política de privacidad
                TermsOfUse()
              ],
            ),
          ),
          Container(

            child:  TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Register_View()));
                },
                child: const Text('Soy organizador y quiero registrarme o darme de baja.',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,
                    //shadows: CupertinoContextMenu.kEndBoxShadow,
                    color: Colors.cyan),),
              ),
          ),
        ],
      ),
      ),
    );
  }
}
