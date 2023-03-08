

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KVInputText extends StatelessWidget{

  final String sValorInicial;
  final int iLongitudPalabra;
  final String sHelperText;
  final String sTitulo;
  final Icon icIzq;
  final bool blIsPasswordInput;// Key for form
  final String? Function(String?)? validator;
  late TextFormField formField;
  final TextEditingController textEditingController;


  KVInputText ({Key? key,
    this.sValorInicial="",
    this.iLongitudPalabra=20,
    this.sHelperText="",
    this.sTitulo="",
    this.validator,
    this.icIzq= const Icon(Icons.account_circle_outlined),
    this.blIsPasswordInput=false, required this.textEditingController,}) : super (key:key);



  String? getText(){
   // print("--------------->>>>>>>>>>>>>>>>>>>>>>> "+formField.controller.toString());
    return formField.controller?.text.toString();
  }


  @override
  Widget build(BuildContext context) {
    formField= TextFormField(
      controller: textEditingController,
      validator: this.validator,
      cursorColor: Colors.cyan,
      //initialValue: this.sValorInicial, //hay que quitarlo al meter el controller
      maxLength: iLongitudPalabra,
      obscureText: blIsPasswordInput,
      enableSuggestions: !blIsPasswordInput,
      autocorrect: !blIsPasswordInput,
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

    return formField;
  }

}