import 'package:flutter/material.dart';
import 'package:inatro_app/app/views/colors/Colors.dart';

class QueryInfoDialog {
  static void showQueryInfoDialog(BuildContext context, String title, String content) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(title,
        textAlign: TextAlign.center,
          style: TextStyle(
              color: secondary.shade500,
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),
        ),
        contentPadding: const EdgeInsets.all(10),
        content: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget> [
                Text(content),
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
  