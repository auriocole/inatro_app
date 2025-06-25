// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously, avoid_print, unused_local_variable, prefer_final_fields, dead_code
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inatro_app/app/services/Authentication/SignUpService.dart';
import 'package:inatro_app/app/views/colors/Colors.dart';
import 'package:inatro_app/app/views/pages/LoginPage.dart';
import 'package:inatro_app/app/views/widgets/form/FormContainerWidget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _identityController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _identityController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
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
                                }
                            ),
                            SizedBox(height: 8,),
                            FormContainerWidget(
                                controller: _usernameController,
                                hintText: "Nome Completo",
                                isPasswordField: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'O nome é obrigatório.';
                                  }
                                  return null;
                                }
                            ),
                            SizedBox(height: 10,),
                            FormContainerWidget(
                                controller: _emailController,
                                hintText: "E-mail",
                                isPasswordField: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'O email é obrigatório.';
                                  }
                                  if (!value.isEmail){
                                    return 'Digite um email válido.';
                                  }
                                  return null;
                                }
                            ),
                            SizedBox(height: 10,),
                            FormContainerWidget(
                                controller: _passwordController,
                                hintText: "Senha",
                                isPasswordField: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'A senha é obrigatória.';
                                  }
                                  if (value.length < 6){
                                    return 'A senha deve ter pelo menos 6 caractéres.';
                                  }
                                  return null;
                                }
                            ),
                            SizedBox(height: 10,),
                            FormContainerWidget(
                                controller: _phoneController,
                                hintText: "Telefone (+258)",
                                isPasswordField: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'O número de telefone é obrigatório.';
                                  }
                                  if (!RegExp(r'^(82|83|84|85|86|87)\d{7}$').hasMatch(value)) {
                                    return "Digite um número de telefone válido!";
                                  }
                                  return null;
                                }
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
                                    SignUpService.signup(
                                        context,
                                        _usernameController,
                                        _emailController,
                                        _identityController,
                                        _passwordController,
                                        _phoneController,
                                            (bool isLoading){
                                          setState(() {
                                            _isLoading = isLoading;
                                          });
                                        }
                                    );
                                  }
                                },
                                child: Text(
                                  "Criar Conta",
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
                          Text("Já tem uma conta?",
                            style: TextStyle(
                              color: secondary.shade400,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.offAll(() => LoginPage());
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
