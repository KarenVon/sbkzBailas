import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sbk_bailas/src/textos/PoliticaPrivacidad.dart';

//clase que nos servirá para añadir los terminos y politica de privacidad de la app
class TermsOfUse extends StatelessWidget {
  const TermsOfUse({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "Al crear tu cuenta, estas de acuerdo con nuestros\n",
          style: Theme.of(context).textTheme.bodyText1,
          children: [
            TextSpan(
                text: "Terminos & Condiciones ",
                style: TextStyle(fontWeight: FontWeight.bold),
                //añadimos botón
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    //Abrir el texto de Terminos y condiciones
                    showDialog(
                      context: context,
                      builder: (context) {
                        return PoliticaPrivacidad(
                          mdFileName: 'terms_conditions.md',
                        );
                      },
                    );
                  }),
            TextSpan(text: "y "),
            TextSpan(
                text: "Política de Privacidad ",
                style: const TextStyle(fontWeight: FontWeight.bold),
                //añadimos botón
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    //Abrir el texto de Política de Privacidad
                    showDialog(
                      context: context,
                      builder: (context) {
                        return PoliticaPrivacidad(
                          mdFileName: 'privacy_policy.md',
                        );
                      },
                    );
                  }),
          ],
        ),
      ),
    );
  }
}
