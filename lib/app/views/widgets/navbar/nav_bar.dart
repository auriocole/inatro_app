// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_returning_null_for_void, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:inatro_app/app/views/colors/colors.dart';
import 'package:inatro_app/app/views/pages/home_page.dart';
import 'package:inatro_app/app/views/widgets/payment/metodo_pagamento_widget.dart';
import 'package:inatro_app/app/views/widgets/userData/historical_widget.dart';

class NavBar extends StatefulWidget {
  final Map<String, String> userData;
  NavBar({required this.userData});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> { 
  
  @override
  void dispose() {
    super.dispose();
  }
   
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(          
        children: [
          Container(
            height: 70,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10,),
                Icon(Icons.account_circle, color: secondary.shade600,),
                Text(
                  '${widget.userData['nome']}',
                  style: TextStyle(
                    color: secondary.shade400,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: secondary.shade200,
            width: 150,
            height: 0.2,
          ),
          SizedBox(height: 10),
          ListTile(
            minLeadingWidth: 10,
            leading: Icon(Icons.home_outlined, color: Color(0xFF2F2E3B)),
            title: const Text('Página Inicial', style: TextStyle(fontSize: 16),),
            onTap: () {
              Future.delayed(Duration(seconds: 1));
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
          ), 
          ListTile(
            minLeadingWidth: 10,
            leading: Icon(Icons.search_outlined, color: Color(0xFF2F2E3B)),
            title: const Text('Fazer Consulta', style: TextStyle(fontSize: 16),),
            onTap: () async{
              await Future.delayed(Duration(milliseconds: 200));
              Navigator.pop(context);
              FormasDePagamentoHelper.showFormasDePagamento(context);
            },
          ),
          ListTile(
            minLeadingWidth: 10,
            leading: Icon(Icons.history_outlined, color: Color(0xFF2F2E3B)),
            title: const Text('Ver Histórico', style: TextStyle(fontSize: 16),),
            onTap: () {
              Future.delayed(Duration(seconds: 1));
              Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => HistoricalWidget(),
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
          ),
          ListTile(
            minLeadingWidth: 10,
            leading: Icon(Icons.help_outline, color: Color(0xFF2F2E3B)),
            title: const Text('Ajuda', style: TextStyle(fontSize: 16),),
            onTap: () {},
          ),
          ListTile(
            minLeadingWidth: 10,
            leading: Icon(Icons.info_outline, color: Color(0xFF2F2E3B)),
            title: const Text('Sobre', style: TextStyle(fontSize: 16),),
            onTap: () {},
          )    
        ],
      ),
    );
  } 
}