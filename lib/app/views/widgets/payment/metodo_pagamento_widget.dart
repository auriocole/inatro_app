import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inatro_app/app/views/colors/colors.dart';
import 'package:inatro_app/app/views/widgets/payment/emola_widget.dart';
import 'package:inatro_app/app/views/widgets/payment/mpesa_widget.dart';

class FormasDePagamentoHelper {
  static void showFormasDePagamento(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FormasDePagamentoWidget();
      },
    );
  }
}

class FormasDePagamentoWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
          height: 350,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },                    
                icon: Icon(Icons.close)
                ),
              SizedBox(height: 5),
              Text(
                "Pretendo pagar via:",
                style: TextStyle(
                    color: secondary,
                    fontSize: 20,
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        PagamentoMpesaHelper.showPagamentoMpesa(context);
                        },
                      child: Container(
                        height: 120,
                        width: 120,
                        margin: EdgeInsets.all(20),
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
                        child: Image.asset("lib/app/assets/mpesa-logo.png"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        PagamentoEmolaHelper.showPagamentoEmola(context);
                      },
                      child: Container(
                        height: 120,
                        width: 120,
                        margin: EdgeInsets.all(20),
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
                        child: Image.asset("lib/app/assets/emola-logo.png"),
                      ),
                    ),  
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
        );
  }
}

