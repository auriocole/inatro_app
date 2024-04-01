// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously, prefer_final_fields, use_super_parameters

import 'package:flutter/material.dart';
import 'package:inatro_app/app/services/auth/login.dart';
import 'package:inatro_app/app/views/colors/colors.dart';
//import 'package:inatro_app/app/views/pages/home_page.dart';
import 'package:inatro_app/app/views/pages/signup_page.dart';
import 'package:inatro_app/app/views/widgets/form/form_container_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _identidadeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _identidadeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'lib/app/assets/logo.png',
                  width: 160,
                  height: 50,
                  ),
                Text(
                  "Login",
                  style: TextStyle(
                    color: secondary,
                    fontSize: 20,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 10,),
                FormContainerWidget(
                  controller: _identidadeController,
                  hintText: "Bilhete de Identidade",
                  isPasswordField: false,
                ),
                SizedBox(height: 10,),
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Senha",
                  isPasswordField: true,
                ),
                SizedBox(height: 10,),
                
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
                    onPressed: _isLoading ? null : () => 
                    LoginHelper.login(
                      context, 
                      _identidadeController, 
                      _passwordController, 
                      (bool isLoading){
                        setState(() {
                          _isLoading = isLoading;
                        });
                      }
                    ),              
                    child: _isLoading ? CircularProgressIndicator(backgroundColor: Colors.white, color: primary,)
                    :Text(
                      "Entrar",
                      style: TextStyle(
                        fontSize: 17, 
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Não tem uma conta?",
                    style: TextStyle(color: Color(0xFF15141C))),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => SignUpPage(),
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
                          transitionDuration: Duration(milliseconds: 700),  
                          ),
                          (route) => false,
                        );
                      },
                      child: Text("Criar Conta",
                      style: TextStyle(color: primary, fontWeight: FontWeight.w500),
                      ),
                    ), 
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
