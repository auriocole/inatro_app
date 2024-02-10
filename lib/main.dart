// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inatro_app/app/views/colors/colors.dart';
import 'package:inatro_app/app/views/splash_screen/splash_screen.dart';
import 'package:inatro_app/app/views/pages/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDl9-kzLY9ypOfAd0pXaQKs7dt_T_DbuPs", 
      appId: "1:949029319471:web:8737fc91452c81d36a67da", 
      messagingSenderId: "949029319471", 
      projectId: "teste-10b39",
      ),  
    );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inatro App',
      theme: ThemeData(
        primarySwatch: primary,
        fontFamily: 'Montserrat'
      ),
      home: SplashScreen(
        child: LoginPage(),
      ),
    );
  }
}
