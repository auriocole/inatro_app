import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inatro_app/app/views/colors/Colors.dart';
import 'package:inatro_app/app/views/pages/HomePage.dart';
import 'package:inatro_app/app/views/widgets/payment/PaymentMethod.dart';

class VehicleDetailsWidget extends StatefulWidget {
  final Map<String, dynamic> vehicleData;
  const VehicleDetailsWidget({super.key, required this.vehicleData});

  @override
  State<VehicleDetailsWidget> createState() => _VehicleDetailsWidgetState();
}

class _VehicleDetailsWidgetState extends State<VehicleDetailsWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'lib/app/assets/logo.png',
                  width: 140,
                  height: 100,
                ),
              ),
              const SizedBox(height: 1),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(30),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: secondary.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 4,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [                 
                    const SizedBox(height: 5),
                    Text(
                      'Detalhes do Veículo',
                      style: TextStyle(
                        color: secondary.shade400,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Matrícula:',
                          style: TextStyle(
                          color: secondary.shade400,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          ' ${widget.vehicleData['matricula']}',
                          style: TextStyle(
                          color: secondary.shade400,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          ),
                        ),                         
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          'Marca:',
                          style: TextStyle(
                          color: secondary.shade400,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          ' ${widget.vehicleData['marca']}',
                          style: TextStyle(
                          color: secondary.shade400,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          ),
                        ),  
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          'Modelo:',
                          style: TextStyle(
                          color: secondary.shade400,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          ' ${widget.vehicleData['modelo']}',
                          style: TextStyle(
                          color: secondary.shade400,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          ),
                        ),                          
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          'Ano:',
                          style: TextStyle(
                          color: secondary.shade400,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          ' ${widget.vehicleData['ano']}',
                          style: TextStyle(
                          color: secondary.shade400,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          ),
                        ),                          
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          'Cor:',
                          style: TextStyle(
                          color: secondary.shade400,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          ' ${widget.vehicleData['cor']}',
                          style: TextStyle(
                          color: secondary.shade400,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          ),
                        ),                          
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          'Proprietario:',
                          style: TextStyle(
                          color: secondary.shade400,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          ' ${widget.vehicleData['proprietario']}',
                          style: TextStyle(
                          color: secondary.shade400,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          ),
                        ),                          
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          'Estado da Matrícula:',
                          style: TextStyle(
                          color: secondary.shade400,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          ' ${widget.vehicleData['estado_matricula']}',
                          style: TextStyle(
                          color: widget.vehicleData['estado_matricula'] == 'Activo' ? Colors.green : Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          ),
                        ),                          
                      ],
                    ),
                    TextButton(
                      onPressed: () async {
                        Get.offAll(() => const HomePage());
                      },
                      child: const Text(
                        'Voltar',
                        style: TextStyle(
                          color: primary,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
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
                        onPressed: (){
                          PaymentMethod.showPaymentMethod(context);
                        },              
                        child: const Text(
                          "Consultar Novamente",
                          style: TextStyle(
                            fontSize: 15, 
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ),                     
                  ],
                ),
              ),              
            ],
          ),
        ),
      )
    );
  }
}
