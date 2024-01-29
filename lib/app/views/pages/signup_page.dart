// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously, avoid_print, unused_local_variable, prefer_final_fields, dead_code
import 'package:flutter/material.dart';
import 'package:inatro_app/app/features/auth/signup.dart';
import 'package:inatro_app/app/views/colors/colors.dart';
import 'package:inatro_app/app/views/pages/login_page.dart';
import 'package:inatro_app/app/views/widgets/form/form_container_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  bool _isLoading = false;

  TextEditingController _identidadeController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();

  @override
  void dispose() {
    _identidadeController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/app/assets/logo.png',
                    width: 160,
                    height: 50,
                    ),
                  Text(
                    "Criar Nova Conta",
                    style: TextStyle(
                      color: secondary,
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  FormContainerWidget(
                    controller: _identidadeController,
                    hintText: "Bilhete de Identidade",
                    isPasswordField: false,
                  ),
                  SizedBox(height: 8,),
                  FormContainerWidget(
                    controller: _usernameController,
                    hintText: "Nome Completo",
                    isPasswordField: false,
                  ),
                  SizedBox(height: 10,),
                  FormContainerWidget(
                    controller: _emailController,
                    hintText: "E-mail",
                    isPasswordField: false,
                  ),
                  SizedBox(height: 10,),
                  FormContainerWidget(
                    controller: _passwordController,
                    hintText: "Senha",
                    isPasswordField: true,
                  ),
                  SizedBox(height: 10,),
                  FormContainerWidget(
                    controller: _telefoneController,
                    hintText: "Telefone (+258)",
                    isPasswordField: false,
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
                      SignUpHelper.signup(
                        context, 
                        _usernameController, 
                        _emailController, 
                        _identidadeController, 
                        _passwordController, 
                        _telefoneController, 
                        (bool isLoading){
                          setState(() {
                            _isLoading = isLoading;
                          });
                        }
                      ),              
                      child: _isLoading ? CircularProgressIndicator(backgroundColor: Colors.white, color: primary,)
                      :Text(
                        "Criar Conta",
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
                      Text("Já tem uma conta?",
                        style: TextStyle(
                          color: secondary.shade400,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
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
                            transitionDuration: Duration(milliseconds: 700),
                          ),
                          (route) => false,
                        );    
                      },
                        child: Text("Entrar", style: TextStyle(color: primary, fontWeight: FontWeight.w500),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  } 
}
