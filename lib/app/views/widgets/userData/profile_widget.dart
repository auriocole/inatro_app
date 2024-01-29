// ignore_for_file: unused_field, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:inatro_app/app/views/colors/colors.dart';
import 'package:inatro_app/app/views/pages/home_page.dart';

class ProfileWidget extends StatefulWidget {
  final Map<String, String> userData;
  ProfileWidget({required this.userData});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(30),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: secondary.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [                 
                      SizedBox(height: 5),
                      Text(
                        'Dados do Utilizador',
                        style: TextStyle(
                          color: secondary.shade400,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 10),  
                        Row(
                          children: [
                            Text(
                              'Nome: ',
                              style: TextStyle(
                              color: secondary.shade400,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 3), 
                            Text(
                              '${widget.userData['nome']}',
                              style: TextStyle(
                              color: secondary.shade400,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              ),
                            ),                         
                          ],
                        ),                       
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'BI: ',
                              style: TextStyle(
                              color: secondary.shade400,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 3),
                            Text(
                              '${widget.userData['identidade']}',
                              style: TextStyle(
                              color: secondary.shade400,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              ),
                            ),                          
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Text(
                              'Telefone: ',
                              style: TextStyle(
                              color: secondary.shade400,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 3),
                            Text(
                              '${widget.userData['telefone']}',
                              style: TextStyle(
                              color: secondary.shade400,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              ),
                            ),                          
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'Email: ',
                              style: TextStyle(
                              color: secondary.shade400,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 3),
                            Text(
                              '${widget.userData['email']}',
                              style: TextStyle(
                              color: secondary.shade400,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              ),
                            ),  
                          ],
                        ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
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
                        },
                        child: Text(
                          'Voltar',
                          style: TextStyle(
                            color: primary,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 45,
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(primary),
                          ),
                          onPressed: (){},              
                          child: Text(
                            "Actualizar dados",
                            style: TextStyle(
                              fontSize: 15, 
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),                     
                    ],
                  ),
                ),              
              ],
            ),
          ),
        ),
      )
    );
  }
}
