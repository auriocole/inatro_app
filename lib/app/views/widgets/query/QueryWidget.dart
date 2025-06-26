import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inatro_app/app/views/colors/Colors.dart';
import 'package:inatro_app/app/views/pages/HomePage.dart';
import 'package:inatro_app/app/views/widgets/form/FormContainerWidget.dart';
import 'package:inatro_app/app/views/widgets/payment/PaymentMethod.dart';
import 'package:inatro_app/app/views/widgets/query/VehicleDetailsWidget.dart';

class Querywidget extends StatefulWidget {
  const Querywidget({super.key});

  @override
  State<Querywidget> createState() => _QuerywidgetState();
}

class _QuerywidgetState extends State<Querywidget> {

  TextEditingController plateController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    plateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: primary,
        title: const Text(
          'Consulta de Matrícula',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator(backgroundColor: Colors.white, color: primary,)) :
      SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 450,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 0),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Identifique um veículo pela chapa de matrícula",
                      style: TextStyle(
                        color: secondary,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign:TextAlign.start
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: secondary.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 15,),
                        const Text(
                          "Insira a Chapa de Matrícula aqui",
                          style: TextStyle(
                            color: secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15,),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: FormContainerWidget(
                            controller: plateController,
                            hintText: "ABC-123-MC",
                            isPasswordField: false,
                          ),
                        ),
                        const SizedBox(height: 12,),
                        Container(
                          width: double.infinity,
                          height: 45,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
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
                            onPressed: () {
                              String plate = plateController.text;
                              if (plate.isEmpty) {
                                Get.snackbar("Preencha o campo", "");
                                throw "Preencha o campo";
                              }
                              else if (!RegExp(r'^[AM][A-Z]{2}-\d{3}-[A-Z]{2}$').hasMatch(plate)) {
                                Get.snackbar("Formato inválido", "");
                                throw "Formato inválido";
                              } else {
                                PaymentMethod.showPaymentMethod(context, plate);
                              }
                            },
                            child: _isLoading ? const CircularProgressIndicator(backgroundColor: Colors.white, color: primary,)
                            : const Text(
                              "Consultar",
                              style: TextStyle(
                                fontSize: 17, 
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
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
                        const SizedBox(height: 15,),
                      ],
                    ),
                  ),  
                ],          
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future <void> makeQuery() async {
    setState(() {
    _isLoading = true;
    });

    try {
      String plate = plateController.text;

      if (plate.isEmpty) {
        Get.snackbar("Preencha o campo", "");
        throw "Preencha o campo";
      }
      if (!RegExp(r'^[AM][A-Z]{2}-\d{3}-[A-Z]{2}$').hasMatch(plate)) {
        Get.snackbar("Formato de inválido", "");
        throw "Formato de inválido";
      }
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
          print(userUID);
          await FirebaseFirestore.instance.collection('consulta').add({
            "Data": DateTime.now().toString().replaceAll("T", " "),
            "Matricula": plate,
            "UID_consulta": userUID,
          });
        }

        Get.offAll(() => VehicleDetailsWidget(vehicleData: vehicleData, plate: plate));
        setState(() {
          _isLoading = false;
        });
        
      } else {
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