import 'package:flutter/material.dart';
import 'package:inatro_app/app/views/colors/colors.dart';

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
        contentPadding: EdgeInsets.all(10),
        content: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget> [
                Text("Consulte diversas matriculas de veiculos dentro da plataforma do Inatro de forma simples e rapida usando metodo de pagamento movel."),
                Text("A cada nova consulta eh cobrado 935,00 MTN e veja todas as consultas feitas anteriormente.")
              ],
            ),
          ),
        actionsPadding: EdgeInsets.all(10),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            }, 
            child: Text("Voltar",style: TextStyle(color: primary),)
          )
        ],
        actionsAlignment: MainAxisAlignment.center,
      );

    });

/*
      return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text("Consultas Rápidas",
        textAlign: TextAlign.center,
          style: TextStyle(
              color: secondary.shade500,
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),
        ),
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Text("Consulte diversas matriculas de veiculos dentro da plataforma do Inatro de forma simples e rapida usando metodo de pagamento movel. A Cada nova consulta eh cobrado 935,00 MTN e veja todas as consultas feitas anteriormente."),
          ),
          SizedBox(height: 5),
          TextButton(
            onPressed: () {}, 
            child: Text("Voltar")
          )
        ],
      );
    });
    */

  }
}
  