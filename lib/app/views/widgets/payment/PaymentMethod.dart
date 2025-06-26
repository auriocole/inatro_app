import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inatro_app/app/views/colors/Colors.dart';
import 'package:inatro_app/app/views/widgets/payment/EmolaPaymentMethod.dart';
import 'package:inatro_app/app/views/widgets/payment/MpesaPaymentMethod.dart';

class PaymentMethod {
  static void showPaymentMethod(BuildContext context, String plate) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return PaymentMethodWidget(plate: plate);
      },
    );
  }
}

class PaymentMethodWidget extends StatelessWidget {
  final String plate;
  const PaymentMethodWidget({super.key, required this.plate});

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
                icon: const Icon(Icons.close)
                ),
              const SizedBox(height: 5),
              const Text(
                "Deseja pagar com:",
                style: TextStyle(
                    color: secondary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
              ),
              Container(
                height: 150,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 10,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        MpesaPaymentMethod.showMpesaPaymentMethod(context, plate);
                        },
                      child: Container(
                        height: 120,
                        width: 120,
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: secondary.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Image.asset("lib/app/assets/mpesa-logo.png"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        EmolaPaymentMethod.showEmolaPaymentMethod(context, plate);
                      },
                      child: Container(
                        height: 120,
                        width: 120,
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: secondary.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Image.asset("lib/app/assets/emola-logo.png"),
                      ),
                    ),  
                  ],
                ),
              ),
              const SizedBox(height: 0,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: secondary.shade400,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      const TextSpan(
                        text: "Ao continuar você está de acordo com o nosso ",
                      ),
                      TextSpan(
                        text: "termo de uso",
                          style: const TextStyle(
                            color: primary,
                            decoration: TextDecoration.underline,
                          ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            
                          },
                      ),
                      const TextSpan(
                        text: " e ",
                      ),
                      TextSpan(
                        text: "política de privacidade",
                        style: const TextStyle(
                          color: primary,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            
                          },
                      ),
                      const TextSpan(
                        text: ".",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
  }
}

