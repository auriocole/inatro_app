
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inatro_app/app/views/colors/colors.dart';
import 'package:inatro_app/app/views/widgets/query/consulta_widget.dart';
import 'package:inatro_app/app/views/widgets/form/form_container_pagamento_widget.dart';
import 'package:inatro_app/app/views/widgets/payment/metodo_pagamento_widget.dart';

class PagamentoMpesaHelper {
  
  static void showPagamentoMpesa(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return PagamentoMpesaWidget();
      },
    );
  }
}
class PagamentoMpesaWidget extends StatefulWidget {

  @override
  State<PagamentoMpesaWidget> createState() => _PagamentoMpesaWidgetState();
}

class _PagamentoMpesaWidgetState extends State<PagamentoMpesaWidget> {

  TextEditingController _telefoneController = TextEditingController();

  @override
  void dispose() {
    _telefoneController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                          FormasDePagamentoHelper.showFormasDePagamento(context);
                        },                    
                        icon: Icon(Icons.arrow_back)
                        ),
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);                          
                        },                    
                        icon: Icon(Icons.close)
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Digite o número MPESA:",
                  style: TextStyle(
                      color: secondary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Container(
                        height: 95,
                        width: 95,
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: secondary.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          "lib/app/assets/mpesa-logo.png",
                          fit: BoxFit.cover,
                          ),
                      ),  
                      Container(  
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FormContainerPagamentoWidget(
                              controller: _telefoneController,
                              hintText: "84/85-xxx-xxxx",
                              isPasswordField: false,
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 200,
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
                                onPressed: () async{
                                  await Future.delayed(Duration(seconds: 1));
                                  Navigator.pop(context);
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => ConsultaWidget(),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        const begin = Offset(0.0, 0.0);
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
                                        "Pagar",
                                        style: TextStyle(
                                          fontSize: 16, 
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500
                                          ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 0,),
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
                SizedBox(height: 10),
              ],
            ),
          ),
        );
  }
}