import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../fb_objects/EventsInfo.dart';

class EventosCreados_View extends StatefulWidget {
  const EventosCreados_View({Key? key});

  @override
  _EventosCreados_ViewState createState() => _EventosCreados_ViewState();
}

class _EventosCreados_ViewState extends State<EventosCreados_View> {
  List<EventsInfo> eventosCreados = [];

  @override
  void initState() {
    super.initState();
    cargarEventosCreados();
  }

  Future<void> cargarEventosCreados() async {
    List<EventsInfo> eventos = await getEventosCreados();
    setState(() {
      eventosCreados = eventos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        leading: const Image(image: AssetImage("assets/logoSolo.png")),
        title: Text('Mis eventos'),
      ),
      backgroundColor: Colors.cyan[50],
      body: eventosCreados.isEmpty
          ? Center(
        child: Text('No se encontraron eventos creados'),
      )
          : ListView.builder(
        itemCount: eventosCreados.length,
        itemBuilder: (context, index) {
          EventsInfo evento = eventosCreados[index];
          return Card(
            child: ListTile(
              title: Text(evento.name ?? ''),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  eliminarEvento(evento);
                },
              ),
              onTap: () {
                // Lógica cuando se hace clic en el evento
              },
            ),
          );
        },
      ),
    );
  }


  Future<void> eliminarEvento(EventsInfo evento) async {
    // Mostrar un diálogo de alerta para confirmar la eliminación del evento
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: Text(
              '¿Estás seguro de que quieres eliminar el evento "${evento
                  .name}"?'),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(
                    false); // No se confirma la eliminación
              },
            ),
            TextButton(
              child: const Text('Sí'),
              onPressed: () {
                Navigator.of(context).pop(true); // Se confirma la eliminación
              },
            ),
          ],
        );
      },
    );

    // Si el usuario confirmó la eliminación, se procede a eliminar el evento
    if (confirmado == true) {
      // Obtener el ID del usuario actualmente autenticado
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      try {
        // Eliminar el evento de la colección "eventos"
        await FirebaseFirestore.instance.collection('eventos')
            .doc(evento.eid)
            .delete();

        // Eliminar el ID del evento de la lista de eventos creados en el perfil del usuario
        await FirebaseFirestore.instance.collection('perfiles')
            .doc(userId)
            .update({
          'eventosCreados': FieldValue.arrayRemove([evento.eid]),
        });

        // Actualizar la lista de eventos
        setState(() {
          eventosCreados.remove(evento);
        });

        // Mostrar un mensaje de éxito o realizar alguna otra acción necesaria
        print('Evento eliminado exitosamente');
      } catch (error) {
        // Mostrar un mensaje de error o realizar alguna otra acción necesaria
        print('Error al eliminar el evento: $error');
      }
    }
  }


  Future<List<EventsInfo>> getEventosCreados() async {
    // Obtener el ID del usuario actualmente autenticado
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    // Realizar la consulta para obtener el perfil del usuario
    DocumentSnapshot<
        Map<String, dynamic>> perfilSnapshot = await FirebaseFirestore.instance
        .collection('perfiles')
        .doc(userId)
        .get();

    print('Perfil snapshot: ${perfilSnapshot
        .data()}'); // Comprobación de depuración

    // Verificar si se encontró el perfil y si contiene el array de ID de eventos
    if (perfilSnapshot.exists &&
        perfilSnapshot.data()?.containsKey('eventosCreados') == true) {
      List<dynamic> eventosIds = perfilSnapshot.data()?['eventosCreados'];

      print('Eventos IDs: $eventosIds'); // Comprobación de depuración

      // Consultar los eventos basados en los ID obtenidos del perfil
      QuerySnapshot<
          Map<String, dynamic>> eventosSnapshot = await FirebaseFirestore
          .instance
          .collection('eventos')
          .where(FieldPath.documentId, whereIn: eventosIds)
          .get();

      print('Eventos snapshot: ${eventosSnapshot
          .docs}'); // Comprobación de depuración

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
