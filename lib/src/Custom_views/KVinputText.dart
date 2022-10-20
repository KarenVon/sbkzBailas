

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KVInputText extends StatelessWidget{

  final String sValorInicial;
  final int iLongitudPalabra;
  final String sHelperText;
  final String sTitulo;
  final Icon icIzq;
  final bool blIsPasswordInput;

  KVInputText ({Key? key,
    this.sValorInicial="",
    this.iLongitudPalabra=20,
    this.sHelperText="",
    this.sTitulo="", this.icIzq= const Icon(Icons.account_circle_outlined),
    this.blIsPasswordInput=false}) : super (key:key);

  final TextEditingController _controller=TextEditingController();

  String getText(){
    return _controller.text;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      cursorColor: Colors.cyan,
      initialValue: this.sValorInicial,
      maxLength: iLongitudPalabra,
      decoration: InputDecoration(
        icon: this.icIzq,
        labelText: this.sTitulo,
        labelStyle: TextStyle(
            color: Colors.white
        ),
        helperText: this.sHelperText,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan,),
            borderRadius: BorderRadius.circular(double.infinity)),
      ),
    );

  }

}