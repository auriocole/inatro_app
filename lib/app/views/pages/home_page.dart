// ignore_for_file: prefer_const_constructors, unused_field
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inatro_app/app/features/user_data/user_data.dart';
import 'package:inatro_app/app/views/colors/colors.dart';
import 'package:inatro_app/app/views/pages/login_page.dart';
import 'package:inatro_app/app/views/pages/landing_page.dart';
import 'package:inatro_app/app/views/widgets/payment/metodo_pagamento_widget.dart';
import 'package:inatro_app/app/views/widgets/navbar/nav_bar.dart';
import 'package:inatro_app/app/views/widgets/userData/profile_widget.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget currentPage = LandingPage();
  bool isFloatingButtonVisible = true;
  late Map<String, String> _userData;

 @override
 void initState() {
    super.initState();
    _userData = {};
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    Map<String, String> userData = await UserData.getUserData();

    setState(() {
      _userData = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        foregroundColor: secondary,
        actions: <Widget> [
          IconButton(
            icon: const Icon(Icons.person_2_outlined),
            onPressed: () async { 
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => ProfileWidget(userData: _userData),
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
              transitionDuration: Duration(milliseconds: 500),  
              ),
              (route) => false,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.output),
            onPressed: () async {
              try {
                FirebaseAuth.instance.signOut();
                await Future.delayed(Duration(seconds: 1));  
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
                transitionDuration: Duration(milliseconds: 900),  
                ),
                (route) => false,
                );
              } catch (e) {
                print('Erro ao navegar para a página de login: $e');
              }
            },
          )
        ],
      ),
      drawer: NavBar(userData: _userData),
      body: currentPage,
      floatingActionButton: currentPage is LandingPage
      ? FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: primary,
        child: const Icon(Icons.search, color: Colors.white),
        onPressed: () {
          FormasDePagamentoHelper.showFormasDePagamento(context);
        }
      )
      : null,
    );
  }  
}