

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbk_bailas/src/Custom_views/KVinputText.dart';

class Login_View extends StatelessWidget {

  Login_View({Key? key}) : super (key:key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: ListView(
          children: [
            Container(
                padding: EdgeInsets.all(25),
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                alignment: Alignment.center,
                child: const Text('¡Bailemos la vida!',
                  style: TextStyle(
                    fontFamily: 'rcBold',
                    fontSize: 30,
                  ),
                ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              alignment: Alignment.center,

              child: const Text('Bienvenidos a tu aplicación favorita de baile, aquí '
                  'encontrarás todos los eventos de moda del momento. ¡Manténte '
                  'informado!\n'
                  '¿Bailamos?)',
                style: TextStyle(
                  fontFamily: 'rcLight',
                  fontSize: 14,
                ),
              ),
            ),
      Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 40),
        margin: const EdgeInsets.fromLTRB(10, 30, 10, 30),
        decoration: BoxDecoration(
          color: Colors.cyan,
          border: Border.all(color: Colors.cyan,
              width: 4),
          borderRadius: BorderRadius.circular(5),
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          KVInputText(iLongitudPalabra: 50,
          sHelperText: 'introduzca su usuario',
          sTitulo: 'USUARIO',
          icIzq: Icon(Icons.account_circle_outlined),),
          KVInputText(iLongitudPalabra: 20,
            sHelperText: 'introduzca su contraseña',
            sTitulo: 'PASSWORD',
            icIzq: Icon(Icons.password),),
        ],
      ),
      ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: (){
    },
    child: Text ("Login"),
    ),
                ],
              ),
            )
    ]
        ),
    );
  }
  }
