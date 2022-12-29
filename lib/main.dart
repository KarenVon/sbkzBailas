import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sbk_bailas/src/App.dart';
import 'firebase_options.dart';

void main() async {

  //para asegurarnos que se esta inicializando flutter
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //para comprobar si el usuario ya se ha logeado
  FirebaseAuth.instance.authStateChanges().listen((User? user){
    if (user==null) {
      print('User is singned out!');
    }else{
      print('User is singned in!');
    }
  });

  runApp(App());
}
