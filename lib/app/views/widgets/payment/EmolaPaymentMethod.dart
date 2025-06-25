import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inatro_app/app/views/colors/Colors.dart';
import 'package:inatro_app/app/views/widgets/query/QueryWidget.dart';
import 'package:inatro_app/app/views/widgets/form/FormContainerPaymentWidget.dart';
import 'package:inatro_app/app/views/widgets/payment/PaymentMethod.dart';

import '../query/VehicleDetailsWidget.dart';

class EmolaPaymentMethod {
  static void showEmolaPaymentMethod(BuildContext context, String plate) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return EmolaPaymentMethodWidget(plate: plate);
      },
    );
  }
}

class EmolaPaymentMethodWidget extends StatefulWidget {
  final String plate;
  const EmolaPaymentMethodWidget({super.key, required this.plate});


  @override
  State<EmolaPaymentMethodWidget> createState() => _EmolaPaymentMethodWidgetState();
}

class _EmolaPaymentMethodWidgetState extends State<EmolaPaymentMethodWidget> {
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
                              onPressed: () async {
                                makeQuery(widget.plate);
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

  Future <void> makeQuery(String plate) async {
    setState(() {
      _isLoading = true;
    });

    try {
      QuerySnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance
          .collection('veiculo')
          .where('matricula', isEqualTo: plate)
          .get();

      if (documentSnapshot.docs.isNotEmpty) {
        Map<String, dynamic> vehicleData = documentSnapshot.docs[0].data();
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
    } catch (e) {
      print("Erro durante o consulta: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }
}