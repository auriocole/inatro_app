
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inatro_app/app/views/colors/Colors.dart';
import 'package:inatro_app/app/views/widgets/form/FormContainerPaymentWidget.dart';
import 'package:inatro_app/app/views/widgets/payment/PaymentMethod.dart';
import 'package:mpesa_sdk_mz/mpesa_sdk_mz.dart';
import 'package:http/http.dart' as http;
import '../query/VehicleDetailsWidget.dart';


class MpesaPaymentMethod {
  
  static void showMpesaPaymentMethod(BuildContext context, String plate) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MpesaPaymentMethodWidget(plate: plate);
      },
    );
  }
}
class MpesaPaymentMethodWidget extends StatefulWidget {
  final String plate;
  const MpesaPaymentMethodWidget({super.key, required this.plate});


  @override
  State<MpesaPaymentMethodWidget> createState() => _MpesaPaymentMethodWidgetState();
}

class _MpesaPaymentMethodWidgetState extends State<MpesaPaymentMethodWidget> {

  TextEditingController phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          SizedBox(
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
                          PaymentMethod.showPaymentMethod(context, widget.plate);
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
                          "lib/app/assets/mpesa-logo.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FormContainerPaymentWidget(
                            controller: phoneController,
                            hintText: "84/85-xxx-xxxx",
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
                              onPressed: () async {
                                String phoneNumber = phoneController.text;
                                if (phoneNumber.isEmpty) {
                                  Get.snackbar("Preencha o campo", "");
                                  throw "Preencha o campo";
                                }
                                else if (!RegExp(r'^(84|85)\d{7}$').hasMatch(phoneNumber)) {
                                  Get.snackbar("Número inválido", "");
                                  throw "Número inválido";
                                } else {
                                  makeQuery(widget.plate, phoneNumber);
                                }
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

          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5), // Fundo semi-transparente
                child: const Center(
                  child: CircularProgressIndicator(backgroundColor: Colors.white, color: primary),
                ),
              ),
            ),
        ],
      )
    );
  }

  Future <void> makeQuery(String plate, String phoneNumber) async {
    setState(() {
      _isLoading = true;
    });

    String token = MpesaConfig.getBearerToken(
      'e5tq9id7bnxz7yahggq3oghozumin2z8',
      'MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAmptSWqV7cGUUJJhUBxsMLonux24u+FoTlrb+4Kgc6092JIszmI1QUoMohaDDXSVueXx6IXwYGsjjWY32HGXj1iQhkALXfObJ4DqXn5h6E8y5/xQYNAyd5bpN5Z8r892B6toGzZQVB7qtebH4apDjmvTi5FGZVjVYxalyyQkj4uQbbRQjgCkubSi45Xl4CGtLqZztsKssWz3mcKncgTnq3DHGYYEYiKq0xIj100LGbnvNz20Sgqmw/cH+Bua4GJsWYLEqf/h/yiMgiBbxFxsnwZl0im5vXDlwKPw+QnO2fscDhxZFAwV06bgG0oEoWm9FnjMsfvwm0rUNYFlZ+TOtCEhmhtFp+Tsx9jPCuOd5h2emGdSKD8A6jtwhNa7oQ8RtLEEqwAn44orENa1ibOkxMiiiFpmmJkwgZPOG/zMCjXIrrhDWTDUOZaPx/lEQoInJoE2i43VN/HTGCCw8dKQAwg0jsEXau5ixD0GUothqvuX3B9taoeoFAIvUPEq35YulprMM7ThdKodSHvhnwKG82dCsodRwY428kg2xM/UjiTENog4B6zzZfPhMxFlOSFX4MnrqkAS+8Jamhy1GgoHkEMrsT5+/ofjCx0HjKbT5NuA2V/lmzgJLl3jIERadLzuTYnKGWxVJcGLkWXlEPYLbiaKzbJb2sYxt+Kt5OxQqC1MCAwEAAQ==',
    );

    String transactionReference = 'INATRAPP-MPESA-${DateTime.now().millisecondsSinceEpoch}';
    String serviceProvider = '171717';

    PaymentRequest payload = PaymentRequest(
      inputTransactionReference: transactionReference,
      inputCustomerMsisdn: phoneNumber,
      inputAmount: 250,
      inputThirdPartyReference: 'INATRAPP-TRANSATION-${DateTime.now().millisecondsSinceEpoch}',
      inputServiceProviderCode: serviceProvider,
    );
    String apiHost = 'api.sandbox.vm.co.mz';

    try {

      http.Response response = await MpesaTransaction.c2b(token, apiHost, payload);

      print(response.body);

      if(response.statusCode == 201) {
        // if is resource created!
        QuerySnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance
            .collection('veiculo')
            .where('matricula', isEqualTo: plate)
            .get();

        if (documentSnapshot.docs.isNotEmpty) {
          Map<String, dynamic> vehicleData = documentSnapshot.docs[0].data();
          await Future.delayed(const Duration(seconds: 2));
          Get.snackbar("Veiculo encontrado com sucesso", "");

          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
                .collection('usuario')
                .doc(user.uid)
                .get();

            String userUID = userSnapshot.data().toString();

            await FirebaseFirestore.instance.collection('consulta').add({
              "Data": DateTime.now().toString().replaceAll("T", " "),
              "Matricula": plate,
              "UID_consulta": userUID,
            });
          }
          Get.back();
          Get.offAll(() => VehicleDetailsWidget(vehicleData: vehicleData, plate: plate));
          setState(() {
            _isLoading = false;
          });

        } else {
          Get.back();
          Get.snackbar("Matrícula não encontrada!", "");
          setState(() {
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      print("Erro durante o consulta: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }
}