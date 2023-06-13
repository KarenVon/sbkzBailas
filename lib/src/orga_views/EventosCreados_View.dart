import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../fb_objects/EventsInfo.dart';

class EventosCreados_View extends StatelessWidget {
  const EventosCreados_View({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        leading: const Image(image: AssetImage("assets/logoSolo.png")),
        title: Text('Mis eventos'),
      ),
      backgroundColor: Colors.cyan[50],
      body: FutureBuilder<List<EventsInfo>>(
        future: getEventosCreados(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error al obtener los eventos');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No se encontraron eventos creados');
          } else {
            List<EventsInfo> eventosCreados = snapshot.data!;
            return ListView.builder(
              itemCount: eventosCreados.length,
              itemBuilder: (context, index) {
                EventsInfo evento = eventosCreados[index];
                return ListTile(
                    title: Text(evento.name ?? ''),
                    onTap: () {

                    }
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<EventsInfo>> getEventosCreados() async {
    // Obtener el ID del usuario actualmente autenticado
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    // Realizar la consulta para obtener el perfil del usuario
    DocumentSnapshot<Map<String, dynamic>> perfilSnapshot = await FirebaseFirestore.instance
        .collection('perfiles')
        .doc(userId)
        .get();

    print('Perfil snapshot: ${perfilSnapshot.data()}'); // Comprobación de depuración

    // Verificar si se encontró el perfil y si contiene el array de ID de eventos
    if (perfilSnapshot.exists && perfilSnapshot.data()?.containsKey('eventosCreados') == true) {
      List<dynamic> eventosIds = perfilSnapshot.data()?['eventosCreados'];

      print('Eventos IDs: $eventosIds'); // Comprobación de depuración

      // Consultar los eventos basados en los ID obtenidos del perfil
      QuerySnapshot<Map<String, dynamic>> eventosSnapshot = await FirebaseFirestore.instance
          .collection('eventos')
          .where(FieldPath.documentId, whereIn: eventosIds)
          .get();

      print('Eventos snapshot: ${eventosSnapshot.docs}'); // Comprobación de depuración

      // Convertir los documentos obtenidos en objetos EventsInfo
      List<EventsInfo> eventosCreados = eventosSnapshot.docs.map((doc) {
        return EventsInfo.fromFirestore(doc, null);
      }).toList();

      return eventosCreados;
    } else {
      return [];
    }
  }
}
