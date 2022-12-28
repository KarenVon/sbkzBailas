import 'package:cloud_firestore/cloud_firestore.dart';

class EventsInfo {
  final String uid;
  final String? name;
  final String? description;
  final String? date;
  final String? price;
  final String? image;

  EventsInfo( {
    this.name="",
    this.description="",
    this.date="" ,
    this.price="",
    this.uid="",
    this.image=""
  });
  factory EventsInfo.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ){
    final data = snapshot.data();
    return EventsInfo(
        name: data?['name'],
        description: data? ['description'],
        date: data? ['date'],
        price: data? ['price'],
        image: data?['image'],
        uid: snapshot.id
    );
  }

  Map<String, dynamic> toFirestore(){
    return{
      if (name != null) "name": name,
      if (description != null) "description": description,
      if (date != null) "date": date,
      if (price != null) "price": price,
      if (image != null) "image": image,
    };
  }
}