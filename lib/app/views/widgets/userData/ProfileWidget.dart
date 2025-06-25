import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inatro_app/app/services/UpdateUserData/UpdateUserData.dart';
import 'package:inatro_app/app/views/colors/Colors.dart';

class ProfileWidget extends StatefulWidget {
  final Map<String, String> userData;
  const ProfileWidget({super.key, required this.userData});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Dados do Utilizador',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: const BoxDecoration(
                  color: primary
                ),
                child: Column(
                  children: <Widget> [
                    const Image(
                      image: AssetImage('lib/app/assets/user-placeholder.png'),
                      width: 140,
                      height: 140
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [ 
                          TextButton(
                            child: Text('${widget.userData['nome']}', style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,)
                            ),
                            onPressed: () {
                              _showEditDialog("Nome", nameController, widget.userData['nome']!);
                            },
                          ),                        
                        ],
                      ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [                                                              
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            'BI: ',
                            style: TextStyle(
                            color: secondary.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${widget.userData['identidade']}',
                            style: TextStyle(
                            color: secondary.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            ),
                          ),                          
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Telefone: ',
                            style: TextStyle(
                            color: secondary.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${widget.userData['telefone']}',
                            style: TextStyle(
                            color: secondary.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 3),
                          IconButton(
                              icon: Icon(Icons.edit, color: primary.withOpacity(0.7),),
                              onPressed: () {
                                _showEditDialog("Telefone", nameController, widget.userData['telefone']!);
                              }
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Email: ',
                            style: TextStyle(
                            color: secondary.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${widget.userData['email']}',
                            style: TextStyle(
                            color: secondary.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 2),  
                        ],
                      ),
                    const SizedBox(height: 5),                     
                  ],
                ),
              ),              
            ],
          ),
        ),
      )
    );
  }

  Future<void> _showEditDialog(String fieldName, TextEditingController controller, String currentValue) async {
    controller.text = currentValue;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            "Editar $fieldName",
            style: const TextStyle(
              fontSize: 16
            ),
            ),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: controller.text),
            cursorColor: primary,
            style: const TextStyle(
              color: secondary,
              fontSize: 14.5,
              ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:const Text(
                'Cancelar',
                style: TextStyle(
                  color: primary
                  ),
                ),
            ),
            TextButton(
              onPressed: () {
                UpdateUserData.updateUserData(fieldName, controller.text);
                Get.back();
                setState(() {
                  widget.userData[fieldName.toLowerCase()] = controller.text;
                });
              },
              child: const Text(
                'Guardar',
                style: TextStyle(
                  color: primary
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}