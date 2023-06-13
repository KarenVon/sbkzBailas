import 'package:cloud_firestore/cloud_firestore.dart';

class EventsInfo {
  final String eid;
  final String? name;
  final String? description;
  final String? date;
  final String? price;
  final String? image;
  final String? type;
  final String? user;

  EventsInfo( {
    this.name="",
    this.description="",
    this.date="" ,
    this.price="",
    this.eid="",
    this.image="",
    this.type="",
    this.user="",
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
        image: data? ['image'],
        type: data? ['type'],
        user: data? ['user'],
        eid: snapshot.id,
    );
  }

  Map<String, dynamic> toFirestore(){
    return{
      if (name != null) "name": name,
      if (description != null) "description": description,
      if (date != null) "date": date,
      if (price != null) "price": price,
      if (image != null) "image": image,
      if (type != null) "type": type,
      if (type != null) "user": user,
    };
  }
}