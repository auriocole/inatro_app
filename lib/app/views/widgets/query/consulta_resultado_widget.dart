import 'package:flutter/material.dart';
import 'package:inatro_app/app/views/colors/colors.dart';
import 'package:inatro_app/app/views/pages/home_page.dart';
import 'package:inatro_app/app/views/widgets/payment/metodo_pagamento_widget.dart';

class VeiculoDetailsWidget extends StatefulWidget {
  final Map<String, dynamic> veiculoData;
  VeiculoDetailsWidget({required this.veiculoData});

  @override
  State<VeiculoDetailsWidget> createState() => _VeiculoDetailsWidgetState();
}

class _VeiculoDetailsWidgetState extends State<VeiculoDetailsWidget> {
  TextEditingController _telefoneController = TextEditingController();

  @override
  void dispose() {
    _telefoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
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
                SizedBox(height: 1),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(30),
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
                  child: Column(
                    children: [                 
                      SizedBox(height: 5),
                      Text(
                        'Detalhes do Veículo',
                        style: TextStyle(
                          color: secondary.shade400,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 8),
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
                            ' ${widget.veiculoData['matricula']}',
                            style: TextStyle(
                            color: secondary.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            ),
                          ),                         
                        ],
                      ),
                      SizedBox(height: 2),
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
                            ' ${widget.veiculoData['marca']}',
                            style: TextStyle(
                            color: secondary.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            ),
                          ),  
                        ],
                      ),
                      SizedBox(height: 2),
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
                            ' ${widget.veiculoData['modelo']}',
                            style: TextStyle(
                            color: secondary.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            ),
                          ),                          
                        ],
                      ),
                      SizedBox(height: 2),
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
                            ' ${widget.veiculoData['ano']}',
                            style: TextStyle(
                            color: secondary.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            ),
                          ),                          
                        ],
                      ),
                      SizedBox(height: 2),
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
                            ' ${widget.veiculoData['cor']}',
                            style: TextStyle(
                            color: secondary.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            ),
                          ),                          
                        ],
                      ),
                      SizedBox(height: 2),
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
                            ' ${widget.veiculoData['proprietario']}',
                            style: TextStyle(
                            color: secondary.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            ),
                          ),                          
                        ],
                      ),
                      SizedBox(height: 2),
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
                            ' ${widget.veiculoData['estado_matricula']}',
                            style: TextStyle(
                            color: widget.veiculoData['estado_matricula'] == 'Activo' ? Colors.green : Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            ),
                          ),                          
                        ],
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(-1.0, 0.0);
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
                          'Voltar',
                          style: TextStyle(
                            color: primary,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
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
                          onPressed: (){
                            FormasDePagamentoHelper.showFormasDePagamento(context);
                          },              
                          child: Text(
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
        ),
      )
    );
  }
}
