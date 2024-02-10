import 'package:flutter/material.dart';
import 'package:inatro_app/app/views/colors/colors.dart';
import 'package:inatro_app/app/views/pages/home_page.dart';

class HistoricalWidget extends StatefulWidget {

  @override
  State<HistoricalWidget> createState() => _HistoricalWidgetState();
}

class _HistoricalWidgetState extends State<HistoricalWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 15),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Histórico de Consultas",
                  style: TextStyle(
                    color: secondary.shade500,
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                  ),
                  )
              ),
              TextButton(
                onPressed: () {
                  Future.delayed(Duration(milliseconds: 700));
                  Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 0.0);
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
                }, 
                child: Text("Voltar"))
            ],
          ),
        )
        ),
    );
  }
}