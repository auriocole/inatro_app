import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inatro_app/app/views/colors/Colors.dart';
import 'package:inatro_app/app/views/pages/LoginPage.dart';
import 'package:inatro_app/app/views/SplashScreen/SplashScreen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inatro App',
      theme: ThemeData(
        primarySwatch: primary,
        fontFamily: 'Montserrat'
      ),
      home: const SplashScreen(
        child: LoginPage(),
      ),
    );
  }
}