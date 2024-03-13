import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inatro_app/app/views/colors/colors.dart';
import 'package:inatro_app/app/views/pages/home_page.dart';

class HistoricalWidget extends StatefulWidget {
  const HistoricalWidget({super.key});

  @override
  State<HistoricalWidget> createState() => _HistoricalWidgedtState();
}

class _HistoricalWidgedtState extends State<HistoricalWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Text(
                'Histórico',
                style: TextStyle(
                  color: secondary.shade600.withOpacity(0.99),
                  fontWeight: FontWeight.w600,
                  fontSize: 20
                ),
              ),
              SizedBox(height: 5),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('consulta').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final docs = snapshot.data?.docs;
                  return ListView.builder(
                    itemCount: docs?.length,
                    itemBuilder: (context, index) {
                      if (docs?[index].data()['UID_consulta'] == 'NMPaZU3Pn9fDuJiRtNNkaMK2AwE3') {
                        return Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: secondary.withOpacity(0.1),
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
                              )
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }              
                    },
                  );
                },
              ),
              SizedBox(height: 5),
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
              child:Text("Voltar")
              )
            ],
          ),
        ),
      ),
    );
  }
}