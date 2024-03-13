import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inatro_app/app/views/pages/home_page.dart';

class LoginHelper {
  static void login(BuildContext context, TextEditingController identidadeController, TextEditingController passwordController, Function(bool) setLoading) async {
    try {
      setLoading(true);

      String identidade = identidadeController.text;
      String password = passwordController.text;

      // Validações dos campos
      if (identidade.isEmpty || password.isEmpty) {
        throw "Preencha todos os campos.";
      }

      if (!RegExp(r'^\d{12}[A-Z]$').hasMatch(identidade)) {
        throw "Número de BI inválido.";
      }

      // Consultar Firestore para obter o ID do usuário com base na identidade
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('usuario')
          .where('identidade', isEqualTo: identidade)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Fazer login usando Firebase Auth
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: querySnapshot.docs.first['email'],
          password: password,
        );
        await Future.delayed(Duration(seconds: 1));
        print("Usuário autenticado com sucesso");
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              var tween = Tween(begin: begin, end: end);
              var offsetAnimation = animation.drive(tween);
              var fadeTween = Tween(begin: 0.0, end: 1.0);
              var fadeAnimation = animation.drive(fadeTween);
              return FadeTransition(
                opacity: fadeAnimation,
                child: SlideTransition(
                  position: offsetAnimation,
                  child: child,
                ),
              );
            },
            transitionDuration: Duration(milliseconds: 900),
          ),
          (route) => false,
        );
        setLoading(false);
      } else {
        print('Usuário não encontrado.');
        setLoading(false);
      }
    } catch (e) {
      print("Erro durante o login: $e");
      setLoading(false);
    }
  }
}