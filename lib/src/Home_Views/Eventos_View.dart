

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Eventos_View extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _eventos();
  }
}

class _eventos extends State<Eventos_View>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black12,
     body: SafeArea(
       child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.cyan[100],
              child: const Text("Evento1"),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.cyan[200],
              child: const Text('Evento2'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.cyan[100],
              child: const Text('Evento3'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.cyan[200],
              child: const Text('Evento4'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.cyan[100],
              child: const Text('Evento5'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.cyan[200],
              child: const Text('Evento6'),
            ),
          ],
    ),
    ),
    );
  }
}