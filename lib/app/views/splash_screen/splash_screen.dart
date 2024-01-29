// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

Color cor = Color(0xFFF9F6F2);

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 3), (){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget.child!), (route) => false);
      }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'lib/app/assets/logo.png',
            width: 170,
            height: 170,
          ),
        ),
      ),
    );
  }
}