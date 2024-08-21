import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inatro_app/app/views/colors/Colors.dart';
import 'package:inatro_app/app/views/widgets/query/QueryWidget.dart';
import 'package:inatro_app/app/views/widgets/form/FormContainerPaymentWidget.dart';
import 'package:inatro_app/app/views/widgets/payment/PaymentMethod.dart';

class EmolaPaymentMethod {
  static void showEmolaPaymentMethod(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const EmolaPaymentMethodWidget();
      },
    );
  }
}

class EmolaPaymentMethodWidget extends StatefulWidget {
  const EmolaPaymentMethodWidget({super.key});


  @override
  State<EmolaPaymentMethodWidget> createState() => _EmolaPaymentMethodWidgetState();
}

class _EmolaPaymentMethodWidgetState extends State<EmolaPaymentMethodWidget> {
  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 400,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                    PaymentMethod.showPaymentMethod(context);
                  },                    
                  icon: const Icon(Icons.arrow_back)
                  ),
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },                    
                  icon: const Icon(Icons.close)
                  ),
              ],
            ),
            const SizedBox(height: 5),
            const Text(
              "Digite o número EMOLA:",
              style: TextStyle(
                  color: secondary,
                  fontSize: 15,
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
                  Container(
                    height: 95,
                    width: 95,
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: secondary.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "lib/app/assets/emola-logo.png",
                      fit: BoxFit.cover,
                      ),
                  ),  
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FormContainerPaymentWidget(
                        controller: phoneController,
                        hintText: "86/87-xxx-xxxx",
                        isPasswordField: false,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 200,
                        height: 45,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
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
                          onPressed: () async{
                            await Future.delayed(const Duration(seconds: 1));
                            Get.back();
                            Get.offAll(() => const Querywidget());
                          },              
                          child: const Text(
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
                  )
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
      ),
    );
  }
}