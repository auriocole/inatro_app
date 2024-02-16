import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inatro_app/app/views/colors/colors.dart';
import 'package:inatro_app/app/views/pages/home_page.dart';

class Historical_Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Histórico',
            style: TextStyle(
              color: secondary.shade600.withOpacity(0.99),
              fontWeight: FontWeight.w600,
              fontSize: 20
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
          return ListView.builder(
            itemCount: docs?.length,
            itemBuilder: (context, index) {
              // Verificando se o uid corresponde ao id-utilizador
              if (docs?[index].data()['UID_consulta'] == 'mPNZ3lbgfaZuGfjQtSXLZnHtmeJ2') {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondary.shade100.withOpacity(0.1),
                        width: 1.5
                      ),
                    )
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
                    // Aqui você pode adicionar mais campos que deseja exibir
                  ),
                );
              } else {
                // Se o uid não corresponder, retorna um widget vazio
                return SizedBox();
              }              
            },
          );
        },
      ),
    bottomNavigationBar: TextButton(
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
    );
  }
}
