import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sbk_bailas/src/singleton/App.dart';
import 'firebase_options.dart';

void main() async {

  //para asegurarnos que se esta inicializando flutter
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(App());
}
