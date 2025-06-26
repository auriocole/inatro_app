import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inatro_app/app/views/colors/Colors.dart';
import 'package:inatro_app/app/views/pages/HomePage.dart';

class LoginService {
  static void login(BuildContext context, TextEditingController identityController, TextEditingController passwordController, Function(bool) setLoading) async {
    try {
      setLoading(true);

      String identity = identityController.text;
      String password = passwordController.text;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('usuario')
          .where('identidade', isEqualTo: identity)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: querySnapshot.docs.first['email'],
          password: password,
        );
        String name = querySnapshot.docs.first['nome'];
        Get.snackbar(
          "",
          "",
          titleText: Text(
            "Olá! ${name.split(" ")[0]}",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          messageText: const Text(
            "Seja bem vindo(a).",
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
        Get.offAll(() => const HomePage());
      } else {
        Get.snackbar(
          "",
          "",
          titleText: const Text(
            "Credenciais não conferem!",
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        // Credenciais inválidas
        Get.snackbar(
          "",
          "",
          titleText: const Text(
            "Credenciais não conferem!",
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
        print("Erro durante o login: $e");
      } if (e.code == 'network-request-failed') {
        // Credenciais inválidas
        Get.snackbar(
          "",
          "",
          titleText: const Text(
            "Sem internet!",
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
          icon: const Icon(Icons.network_check, color: Colors.white),
          backgroundColor: Colors.red.shade400,
        );
        setLoading(false);
        print("Erro durante o login: $e");
      }
    } catch (e) {
      Get.snackbar(
        "",
        "",
        titleText: const Text(
          "Erro de autenticação!",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        messageText: const Text(
          "Algo deu errado, Tente novamente.",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        icon: const Icon(Icons.error, color: Colors.white),
        backgroundColor: Colors.red.shade400,
      );
      print("Erro durante o login: $e");
      setLoading(false);
    }
  }
}