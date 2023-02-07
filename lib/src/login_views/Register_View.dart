import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Custom_views/KVinputText.dart';
import '../Home_Views/Orga_View.dart';

class Register_View extends StatelessWidget {
  Register_View({Key? key}) : super(key: key);

  var txt = TextEditingController();

  Future<void> registerPressed(
      String emailAddress, String password, BuildContext context) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      //si se registra correctamente --> vista de organizador (insertar evento)
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const Orga_View()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        txt.text = "USUARIO YA EXISTE, PRUEBA RECUPERAR CONTRASEÑA";
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //subo aqui arriba los inputText para poder usarlos en el loginpressed
    KVInputText inputUser = KVInputText(
      iLongitudPalabra: 50,
      sHelperText: 'introduzca usuario',
      sTitulo: 'USUARIO',
      icIzq: Icon(Icons.account_circle_outlined),
    );

    KVInputText inputPass = KVInputText(
      iLongitudPalabra: 20,
      sHelperText: 'introduzca una contraseña',
      sTitulo: 'CONTRASEÑA',
      icIzq: Icon(Icons.password),
      blIsPasswordInput: true,
    );

    KVInputText inputPassBis = KVInputText(
      iLongitudPalabra: 20,
      sHelperText: 'repita la contraseña',
      sTitulo: 'REPITA CONTRASEÑA',
      icIzq: Icon(Icons.password),
      blIsPasswordInput: true,
    );

    return Scaffold(
      /* appBar: AppBar(
        backgroundColor: CupertinoColors.white,
        title: Text('REGISTRO NUEVO ORGANIZADOR'),
    foregroundColor: Colors.cyan,
    ),
    backgroundColor: Colors.cyan.shade300,
    //para quetodo se pueda encuadrar correctamente en la pantalla cuando aparezca el teclado
    body: SingleChildScrollView(
    padding: const EdgeInsets.only(top: 100, bottom:20,left: 10 ,right: 10),

    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          inputUser,
          inputPass,
          inputPassBis,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Respond to button press
                  if(inputPass.getText() == inputPassBis.getText()){
                    registerPressed(inputUser.getText(), inputPass.getText(),context);
                  }
                  else{
                    txt.text= "ERROR : las constraseñas no coinciden";
                  }
                },
                child: Text('Aceptar'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black12),
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15))),

              ),

              ElevatedButton(
                onPressed: () {
                  // Respond to button press
                  //print("--------- registrado");
                  Navigator.of(context).popAndPushNamed('/loginview');
                },
                child: Text('Cancelar'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black12),
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15))),
              )
            ],
          ),
          //txtMensajes,
        ],
      ),
    ),
    ),
    );*/
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 100.0),
            child: const Text(
              'Si eres organizador y quieres promocionar tu evento...\n '
              '¡Registrate aquí!.\n\n',
              style: TextStyle(
                fontFamily: AutofillHints.familyName,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: Colors.cyan,
              border: Border.all(color: Colors.cyan, width: 8),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //los he subido arriba, encima del scaffold
                inputUser,
                inputPass,
                inputPassBis,
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.cyan),
                      textStyle: MaterialStateProperty.all(
                          TextStyle(fontSize: 15, color: Colors.white))),
                  onPressed: () {
                    print("DEBUG "+ inputUser.getText());
                    print("DEBUG "+ inputPass.getText());
                    print("DEBUG "+ inputPassBis.getText());
                    // Respond to button press
                    if (inputPass.getText() == inputPassBis.getText()) {
                     registerPressed(
                          inputUser.getText(), inputPass.getText(), context);
                    } else {
                      txt.text = "ERROR : las constraseñas no coinciden";
                    }
                    //Navigator.push(context, MaterialPageRoute(builder: (_) => const Orga_View()));
                  },
                  child: Text("REGISTRARME"),
                  //  style: TextStyle(color: Colors.cyan),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
