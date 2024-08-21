import 'package:flutter/material.dart';
import 'package:inatro_app/app/views/colors/Colors.dart';

class QueryInfoDialog {
  static void showQueryInfoDialog(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text("Consultas Rápidas",
        textAlign: TextAlign.center,
          style: TextStyle(
              color: secondary.shade500,
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),
        ),
        contentPadding: const EdgeInsets.all(10),
        content: const SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget> [
                Text("Consulte diversas matriculas de veiculos dentro da plataforma do Inatro de forma simples e rapida usando metodo de pagamento movel."),
                Text("A cada nova consulta eh cobrado 935,00 MTN e veja todas as consultas feitas anteriormente.")
              ],
            ),
          ),
        actionsPadding: const EdgeInsets.all(10),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            }, 
            child: const Text("Voltar",style: TextStyle(color: primary),)
          )
        ],
        actionsAlignment: MainAxisAlignment.center,
      );
    }
    );
  }
}
  