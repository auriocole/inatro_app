import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inatro_app/app/services/FirebaseAuthentication/FirebaseAuthentication.dart';
import 'package:inatro_app/app/views/pages/HomePage.dart';
import 'package:inatro_app/app/views/pages/LoginPage.dart';

class SignUpService {
  static void signup (BuildContext context, TextEditingController usernameController, TextEditingController emailController ,TextEditingController identityController, TextEditingController passwordController, TextEditingController phoneController, Function(bool) setLoading) async {
    try {
      setLoading(true);  

      String nome = usernameController.text;
      String email = emailController.text;
      String password = passwordController.text;
      String phone = phoneController.text;
      String identity = identityController.text;

      if (nome.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty || identity.isEmpty) {
        Get.snackbar("Preencha todos os campos!", "");
      }

      if (!RegExp(r'^\d{12}[A-Z]$').hasMatch(identity) ){
        Get.snackbar("Numero de BI inválido!", "");
      }

      if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(nome)) {
        Get.snackbar("Nome inválido! Use apenas letras e espaços.", "");
      }

      if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
        Get.snackbar("Email inválido!", "");
      }

      if (password.length < 6) {
        Get.snackbar("A senha deve ter pelo menos 6 caracteres!", "");  
      }

      if (phone.length != 9){
        Get.snackbar("Numero de telefone inválido!", "");
      }

      final FirebaseAuthentication auth = FirebaseAuthentication();
      User? user = await auth.signUpWithEmailAndPassword(email, password);

      String userId = user!.uid;
      await FirebaseFirestore.instance.collection('usuario').doc(userId).set({
        'nome': nome,
        'email': email,
        'telefone': phone,
        'identidade': identity,
      });
      Get.snackbar("Bem-Vindo!","Usuário cadastrado com sucesso");
      Get.offAll(() => const HomePage());
    } catch (e) {
      setLoading(false);
      print("Erro durante o cadastro: $e");     
    }
  }
}
