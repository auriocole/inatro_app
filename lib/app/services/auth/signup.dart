import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inatro_app/app/services/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:inatro_app/app/views/pages/login_page.dart';

class SignUpHelper {
  
  static void signup (BuildContext context, TextEditingController _usernameController, TextEditingController _emailController ,TextEditingController _identidadeController, TextEditingController _passwordController, TextEditingController _telefoneController, Function(bool) setLoading) async {   
    try {
      setLoading(true);  

      String nome = _usernameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      String telefone = _telefoneController.text;
      String identidade = _identidadeController.text;

      if (nome.isEmpty || email.isEmpty || password.isEmpty || telefone.isEmpty || identidade.isEmpty) {
        throw "Preencha todos os campos.";  
      }

      if (!RegExp(r'^\d{12}[A-Z]$').hasMatch(identidade) ){
        throw "Numero de BI inválido.";
      }

      if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(nome)) {
        throw "Nome inválido. Use apenas letras e espaços.";
      }

      if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
        throw "Email inválido.";
      }

      if (password.length < 6) {
        throw "A senha deve ter pelo menos 6 caracteres.";  
      }

      if (telefone.length != 9){
        throw "Numero de telefone inválido.";
      }

      final FirebaseAuthService _auth = FirebaseAuthService();
      User? user = await _auth.signUpWithEmailAndPassword(email, password);

      String userId = user!.uid;
      await FirebaseFirestore.instance.collection('usuario').doc(userId).set({
        'nome': nome,
        'email': email,
        'telefone': telefone,
        'identidade': identidade,
      });
      print("Usuário cadastrado com sucesso");
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(-1.0, 0.0);
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
          transitionDuration: Duration(milliseconds: 700),
        ),
        (route) => false,
      );
      setLoading(false); 
    } catch (e) {
      setLoading(false);
      print("Erro durante o cadastro: $e");     
    }
  }
}
