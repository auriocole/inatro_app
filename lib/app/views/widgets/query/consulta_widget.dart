import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inatro_app/app/views/colors/colors.dart';
import 'package:inatro_app/app/views/widgets/form/form_container_widget.dart';
import 'package:inatro_app/app/views/widgets/query/consulta_resultado_page.dart';

class ConsultaWidget extends StatefulWidget {
  const ConsultaWidget({super.key});

  @override
  State<ConsultaWidget> createState() => _ConsultaWidgetState();
}

class _ConsultaWidgetState extends State<ConsultaWidget> {

  TextEditingController _matriculaController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _matriculaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 450,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 0),
                      Container(
                        child: Text(
                          "Consultar Matrícula pela placa e pague parcelado em até 12x",
                          style: TextStyle(
                            color: secondary,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign:TextAlign.start
                        ),
                      ),
                      Container(
                        child: Text(
                          "Descubra todos os débitos do seu veículo sem pagar nada por isso e resolva parcelando tudo em até 12x!",
                          style: TextStyle(
                            color: secondary.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
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
                            SizedBox(height: 15,),
                            Container(
                              child: Text(
                                "Insira a Chapa de Matrícula aqui",
                                style: TextStyle(
                                  color: secondary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 15,),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: FormContainerWidget(
                                controller: _matriculaController,
                                hintText: "ABC-123-MC",
                                isPasswordField: false,
                              ),
                            ),
                            SizedBox(height: 10,),        
                            Container(
                              width: double.infinity,
                              height: 45,
                              margin: EdgeInsets.symmetric(horizontal: 15),
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
                                onPressed: _isLoading ? null : _Consultar,     
                                child: _isLoading ? CircularProgressIndicator(backgroundColor: Colors.white, color: primary,)
                                : Text(
                                  "Consultar",
                                  style: TextStyle(
                                    fontSize: 17, 
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 18),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: secondary.shade400,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Ao continuar você está de acordo com o nosso ",
                                    ),
                                    TextSpan(
                                      text: "termo de uso",
                                      style: TextStyle(
                                        color: primary,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          
                                        },
                                    ),
                                    TextSpan(
                                      text: " e ",
                                    ),
                                    TextSpan(
                                      text: "política de privacidade",
                                      style: TextStyle(
                                        color: primary,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          
                                        },
                                    ),
                                    TextSpan(
                                      text: ".",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),
                          ],
                        ),
                      ),  
                    ],          
                  ),
                ),
              ),
            ),
        ),
      ),
    );
  }

  Future <void> _Consultar() async {
    setState(() {
    _isLoading = true;
    });

    try {
      String matricula = _matriculaController.text;

      // Validações dos campos
      if (matricula.isEmpty) {
        throw "Preencha o campo";
      }
      // Validações do formato da matricula
      if (!RegExp(r'^[AM][A-Z]{2}-\d{3}-[A-Z]{2}$').hasMatch(matricula)) {
        throw "Formato de inválido";
      }

      // Consultar Firestore para obter o ID do veiculo com base na matricula
      QuerySnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance
          .collection('veiculo')
          .where('matricula', isEqualTo: matricula)
          .get();

      if (documentSnapshot.docs.isNotEmpty) {
        // chamando as informacoes do veiculo
        Map<String, dynamic> veiculoData = documentSnapshot.docs[0].data();
        await Future.delayed(Duration(seconds: 2));
        //Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => VeiculoDetailsWidget(veiculoData: veiculoData)),(Route) => false);
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => VeiculoDetailsWidget(veiculoData: veiculoData,),
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
        print("Veiculo encontrado com sucesso");
        setState(() {
          _isLoading = false;
        });
        
      } else {
        // Usuário não encontrado
        print('Veiculo não encontrado.');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      // Tratamento de exceção
      print("Erro durante o consulta: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

}