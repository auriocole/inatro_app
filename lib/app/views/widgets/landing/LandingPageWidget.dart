import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inatro_app/app/views/colors/Colors.dart';
import 'package:inatro_app/app/views/widgets/landing/dialogs/QueryInfoDialog.dart';
import 'package:http/http.dart' as http;

class LandingPageWidget extends StatelessWidget {
  const LandingPageWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            opacity: 0.2,
            image: AssetImage('lib/app/assets/bg_3.png')
          )
        ),
        child: Column(
          children: [
            const SizedBox(height: 2),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(10,10,10,0),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: secondary.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [                 
                  Image.asset('lib/app/assets/carro.png', width: 70, height: 60,), 
                  const SizedBox(height: 5),
                  Text(
                    'Consultas Rápidas',
                    style: TextStyle(
                      color: secondary.shade400,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () {
                      QueryInfoDialog.showQueryInfoDialog(context);
                    },
                    child: const Text(
                      'Ver Mais',
                      style: TextStyle(
                        color: primary,
                      ),
                    ),
                  ),                
                ],
              ),
            ),
        
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(10,10,10,0),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: secondary.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Image.asset('lib/app/assets/pagamento2.png', width: 70, height: 60,),
                  const SizedBox(height: 5),
                  Text(
                    'Formas de Pagamento',
                    style: TextStyle(
                      color: secondary.shade400,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Ver Mais',
                      style: TextStyle(
                        color: primary,
                      ),
                    ),
                  ),                
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(10,10,10,0),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: secondary.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Image.asset('lib/app/assets/historico.png', width: 70, height: 60,),
                  const SizedBox(height: 5),
                  Text(
                    'Acesso ao Histórico',
                    style: TextStyle(
                      color: secondary.shade400,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () {
                      _getToken();
                    },
                    child: const Text(
                      'Ver Mais',
                      style: TextStyle(
                        color: primary,
                      ),
                    ),
                  ),               
                ],
              ),
            ),
            const SizedBox(height: 100),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: secondary.shade400,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  const TextSpan(text: '©Copyright '),
                  TextSpan(
                    text: 'Áurio Cole.',
                      style: const TextStyle(
                        color: primary,
                        decoration: TextDecoration.none,
                      ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {}, 
                  ),
                  const TextSpan(text: ' Todos direitos reservados.'),
                ]
              )
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }

  void _getToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? token = await messaging.getToken();
    _sendTokenToServer(token!);
    } catch (e) {
      print(e);
    }
  }

  void _sendTokenToServer(String token) async {
    var url = Uri.parse('http://10.0.2.2:8080/firebase/api/sendToken');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token}),
    );

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("Falha ao enviar o token");
    }
  }
}