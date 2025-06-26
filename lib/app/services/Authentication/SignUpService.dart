import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inatro_app/app/services/FirebaseAuthentication/FirebaseAuthentication.dart';
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

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('usuario')
          .where('identidade', isEqualTo: identity)
          .get();
      if (querySnapshot.docs.isEmpty) {
        final FirebaseAuthentication auth = FirebaseAuthentication();
        User? user = await auth.signUpWithEmailAndPassword(email, password);

        String userId = user!.uid;
        await FirebaseFirestore.instance.collection('usuario').doc(userId).set({
          'nome': nome,
          'email': email,
          'telefone': phone,
          'identidade': identity,
        });
        Get.snackbar(
          "",
          "",
          titleText: Text(
            "Seja bem-vindo! ${nome.split(" ")[0]}",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          messageText: const Text(
            "Faça o login com sua credencias.",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          icon: const Icon(Icons.check_box, color: Colors.white),
          //backgroundColor: primary.shade400,
        );
        setLoading(false);
        Get.offAll(() => const LoginPage());
      } else {
        Get.snackbar(
          "",
          "",
          titleText: const Text(
            "Identidade já existente!",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          messageText: const Text(
            "Tente novamente.",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          icon: const Icon(Icons.error, color: Colors.white),
          backgroundColor: Colors.red.shade400,
        );
        setLoading(false);
      }
    } catch (e) {
      Get.snackbar(
        "",
        "",
        titleText: const Text(
          "Erro de Registro",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        messageText: const Text(
          "Algo deu errado! tente novamente.",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        icon: const Icon(Icons.error, color: Colors.white),
        backgroundColor: Colors.red.shade400,
      );
      setLoading(false);
      print("Erro durante o cadastro: $e");     
    }
  }
}
