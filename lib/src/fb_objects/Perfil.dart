//Creo el objeto perfil para almacenar los datos de los usuarios
//clase copiada de la documentacion de firebase
import 'package:cloud_firestore/cloud_firestore.dart';

class Perfil {
  final String? name;
  final String? city;
  final String? country;
  final int? age;
  final String uid;

  Perfil({
    this.name = "",
    this.city = "",
    this.country = "",
    this.age = 0,
    this.uid = "",
  });

  factory Perfil.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Perfil(
        name: data?['name'],
        city: data?['city'],
        country: data?['country'],
        age: data?['age'],
        uid: snapshot.id);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (city != null) "city": city,
      if (country != null) "country": country,
      if (age != 0) "age": age,
    };
  }
}
