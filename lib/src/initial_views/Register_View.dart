
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


/*Vista desde donde los organizadores pueden solicitur registrarse para
posteriormente poder crear sus eventos*/

class Register_View extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register_View>{
  final controllerName = TextEditingController();
  final controllerMail = TextEditingController();
  final controllerMessage = TextEditingController();
  //para acceder al estado del formulario
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.cyan[50],
      body:SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
          children: [
            Container(
              //padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              alignment: Alignment.center,
              child:ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('assets/abrazo.png',
                  fit: BoxFit.cover,
              width: 2000,
              colorBlendMode: BlendMode.darken,),
            ),
            ),
            const Text('Dejanos tus datos y nos pondremos en contacto contigo lo antes posible:\n',
              style: TextStyle(fontSize: 14,
                  color: Colors.cyan),),
            buildTextField(title: 'NOMBRE', controller: controllerName),
            const SizedBox(height: 10),
            buildTextField(title: 'EMAIL', controller: controllerMail),
            const SizedBox(height: 10),
            buildTextField(
                title: 'MENSAJE',
                controller: controllerMessage,
                maxLines: 4),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                foregroundColor: Colors.white,
                minimumSize: Size.fromHeight(50),
                shape: RoundedRectangleBorder(),
                textStyle: const TextStyle(fontSize: 14,
                    fontWeight: FontWeight.bold,),
              ),
              child: Text('ENVIAR'),
              onPressed: () => sendEmail(
                name: controllerName.text,
                mail: controllerMail.text,
                message: controllerMessage.text,
              ),
            ),
          ],
        ),
      ) ,
    ),
    );
  }

  Future sendEmail({
    required String name,
    required String mail,
    required String message,
  }) async {
    final serviceId='service_gne2daf';
    final templateId ='template_nuwjzdg';
    final userId ='1AwfFDmLz3aol-Yf8';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
        url,
        headers: {
          'origin': 'http://localhost',
          'Content-type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name,
            'user_email': mail,
            'user_message': message,
          }
        }),
        );
    print(response.body);

    if (response.statusCode == 200) {
// Borrar los campos del formulario
      _formKey.currentState?.reset();

// Mostrar mensaje en pantalla
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Éxito'),
          content: Text('Tu mensaje se ha enviado correctamente.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
    }
  }


Widget buildTextField({required String title,
required TextEditingController controller, int maxLines =1,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold,
              color: Colors.cyan),
        ),
        const SizedBox(height: 0),
        TextField(
          cursorColor: Colors.cyan,
          controller: controller,
          maxLines: maxLines,
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black38)
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan)
            ),
            suffixIconColor: Colors.cyan,

          ),
        )
      ],
    );
