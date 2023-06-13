//Creo el objeto perfil para almacenar los datos de los usuarios
//clase copiada de la documentacion de firebase
import 'package:cloud_firestore/cloud_firestore.dart';

class Perfil {
  final String? name;
  final String uid;
  final List<String> eventosCreados; //lista de eventos creados por el usuario

  Perfil({
    this.name = "",
    this.uid = "",
    this.eventosCreados= const [],
  });

  factory Perfil.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Perfil(
        name: data?['name'],
        uid: snapshot.id,
        eventosCreados: data?['eventosCreados']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (eventosCreados != null) "eventosCreados": eventosCreados?.toList(),
    };
  }
}
