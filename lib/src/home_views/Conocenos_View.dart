

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*Vista que nos muestra un breve resumen sobre quienes somos*/

class Conocenos_View extends StatefulWidget {
  @override
  _conocenos createState() => _conocenos();

}

class _conocenos extends State<Conocenos_View>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body:
        Container(
          decoration:const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment(0.1, 0.4),
              colors: [Colors.white,Colors.black12],
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(40),
                //margin: const EdgeInsets.only(bottom: 20),
                child: Image.asset('assets/logo.png'),
              ),
              Container(
                padding: const EdgeInsets.only(top: 40.0),
                child: const Text ('Bienvenid@ a tu aplicación favorita de baile.\n '
                    'Aquí encontrarás todos los eventos\n de moda del momento.\n\n'
                    '¡Manténte informado!',
                  style: TextStyle(fontFamily: AutofillHints.familyName,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan,),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),

      ),
    );

  }
}
