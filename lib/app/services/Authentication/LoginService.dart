import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inatro_app/app/views/pages/HomePage.dart';

class LoginService {
  static void login(BuildContext context, TextEditingController identityController, TextEditingController passwordController, Function(bool) setLoading) async {
    try {
      setLoading(true);

      String identity = identityController.text;
      String password = passwordController.text;

      if (identity.isEmpty || password.isEmpty) {
        Get.snackbar("Preencha todos os campos.", "") ;
      }

      if (!RegExp(r'^\d{12}[A-Z]$').hasMatch(identity)) {
        Get.snackbar("Número de BI inválido.", "");
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('usuário')
          .where('identidade', isEqualTo: identity)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: querySnapshot.docs.first['email'],
          password: password,
        );
        Get.snackbar("Usuário autenticado com sucesso!", "");
        //print("Usuário autenticado com sucesso");
        Get.offAll(() => const HomePage());
      } else {
        Get.snackbar("Usuário não encontrado!", "");
        //print('Usuário não encontrado.');
        setLoading(false);
      }
    } catch (e) {
      print("Erro durante o login: $e");
      setLoading(false);
    }
  }
}