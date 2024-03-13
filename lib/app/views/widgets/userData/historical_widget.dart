import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inatro_app/app/views/colors/colors.dart';
import 'package:inatro_app/app/views/pages/home_page.dart';

class Historical_Widget extends StatefulWidget {
  @override
  State<Historical_Widget> createState() => _Historical_WidgetState();
}

class _Historical_WidgetState extends State<Historical_Widget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Histórico',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('consulta').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = snapshot.data?.docs;
          User? user = FirebaseAuth.instance.currentUser;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: docs?.length,
                  itemBuilder: (context, index) {
                    if (docs?[index].data()['UID_consulta'] == user?.uid) {
                      return Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(docs?[index].data()['Matricula']),
                          subtitle: Text(docs?[index].data()['Data']),
                          trailing: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Ver",
                              style: TextStyle(color: primary),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  Future.delayed(Duration(seconds: 1));
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
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
                child: Text(
                  "Voltar",
                  style: TextStyle(color: primary)
                  ),
              ),
              SizedBox(height: 20)
            ],
          );
        },
      ),
    );
  }
}
