// ignore_for_file: unused_field, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:inatro_app/app/services/update_userData/update_useData.dart';
import 'package:inatro_app/app/views/colors/colors.dart';
import 'package:inatro_app/app/views/pages/home_page.dart';

class ProfileWidget extends StatefulWidget {
  final Map<String, String> userData;
  ProfileWidget({required this.userData});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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
                        color: secondary.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 8,
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
                            SizedBox(width: 2), 
                            IconButton(
                              icon: Icon(Icons.edit, color: primary.withOpacity(0.7)),
                              onPressed: () {
                                _showEditDialog("Nome", nomeController, widget.userData['nome']!);
                              }
                            ),                        
                          ],
                        ),                       
                        SizedBox(height: 3),
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
                            SizedBox(width: 2), 
                            IconButton(
                              icon: Icon(Icons.edit, color: primary.withOpacity(0.7),),
                              onPressed: () {
                                _showEditDialog("Telefone", nomeController, widget.userData['telefone']!);
                              }
                            )                          
                          ],
                        ),
                        SizedBox(height: 3),
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
                            SizedBox(width: 2),  
                          ],
                        ),
                      SizedBox(height: 5),
                      TextButton(
                        onPressed: () async {
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
                          transitionDuration: Duration(milliseconds: 500),  
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

  Future<void> _showEditDialog(String fieldName, TextEditingController controller, String currentValue) async {
    controller.text = currentValue;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            "Editar $fieldName",
            style: TextStyle(
              fontSize: 16
            ),
            ),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: controller.text),
            cursorColor: primary,
            style: TextStyle(
              color: secondary,
              fontSize: 14.5,
              ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: TextStyle(
                  color: primary
                  ),
                ),
            ),
            TextButton(
              onPressed: () {
                update_userData.updateUserData(fieldName, controller.text);
                Navigator.of(context).pop();
                setState(() {
                  widget.userData[fieldName.toLowerCase()] = controller.text;
                });
              },
              child: Text(
                'Guardar',
                style: TextStyle(
                  color: primary
                  ),
                ),
            ),
          ],
        );
      },
    );
  }
}