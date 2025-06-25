// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously, prefer_final_fields, use_super_parameters

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inatro_app/app/services/Authentication/LoginService.dart';
import 'package:inatro_app/app/views/colors/Colors.dart';
import 'package:inatro_app/app/views/pages/SignUpPage.dart';
import 'package:inatro_app/app/views/widgets/form/FormContainerWidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _identityController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;


  @override
  void dispose() {
    _identityController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Center(
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
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            FormContainerWidget(
                              controller: _identityController,
                              hintText: "Bilhete de Identidade",
                              isPasswordField: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'O BI é obrigatório.';
                                }
                                if (!RegExp(r'^\d{12}[A-Z]$').hasMatch(value)) {
                                  return 'Digite um BI válido.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10,),
                            FormContainerWidget(
                              controller: _passwordController,
                              hintText: "Senha",
                              isPasswordField: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'O senha é obrigatória.';
                                }
                                if (value.length < 6) {
                                  return 'A senha deve ter pelo menos 6 caractéres.';
                                }
                                return null;
                              },
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
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  backgroundColor: WidgetStateProperty.all(primary),
                                ),
                                onPressed: _isLoading ? null : () async {
                                  if (_formKey.currentState!.validate()) {
                                    LoginService.login(
                                        context,
                                        _identityController,
                                        _passwordController,
                                            (bool isLoading){
                                          setState(() {
                                            _isLoading = isLoading;
                                          });
                                        }
                                    );
                                  }
                                },
                                child: Text(
                                  "Entrar",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Não tem uma conta?",
                              style: TextStyle(color: Color(0xFF15141C))),
                          TextButton(
                            onPressed: () {
                              Get.offAll(() => SignUpPage());
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
            if (_isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.5), // Fundo semi-transparente
                  child: Center(
                    child: CircularProgressIndicator(backgroundColor: Colors.white, color: primary),
                  ),
                ),
              ),
          ],
        )
      )
    );
  }
}
