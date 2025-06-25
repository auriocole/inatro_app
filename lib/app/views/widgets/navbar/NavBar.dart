
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inatro_app/app/views/colors/Colors.dart';
import 'package:inatro_app/app/views/widgets/query/QueryWidget.dart';
import 'package:inatro_app/app/views/widgets/userData/HistoricalWidget.dart';

class NavBar extends StatefulWidget {
  final Map<String, String> userData;
  const NavBar({super.key, required this.userData});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> { 
  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 220,
      child: ListView(          
        children: [
          SizedBox(
            height: 70,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10,),
                Icon(Icons.account_circle, color: secondary.shade600,),
                Text(
                  '${widget.userData['nome']}',
                  style: TextStyle(
                    color: secondary.shade400,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: secondary.shade200,
            width: 150,
            height: 0.2,
          ),
          const SizedBox(height: 10),
          ListTile(
            minLeadingWidth: 10,
            leading: const Icon(Icons.home_outlined, color: Color(0xFF2F2E3B)),
            title: const Text('Página Inicial', style: TextStyle(fontSize: 16),),
            onTap: () {
              Get.back();
            },
          ), 
          ListTile(
            minLeadingWidth: 10,
            leading: const Icon(Icons.search_outlined, color: Color(0xFF2F2E3B)),
            title: const Text('Fazer Consulta', style: TextStyle(fontSize: 16),),
            onTap: () async{
              await Future.delayed(const Duration(milliseconds: 200));
              Get.back();
              Get.to(() => const Querywidget());
              //PaymentMethod.showPaymentMethod(context);
            },
          ),
          ListTile(
            minLeadingWidth: 10,
            leading: const Icon(Icons.history_outlined, color: Color(0xFF2F2E3B)),
            title: const Text('Ver Histórico', style: TextStyle(fontSize: 16),),
            onTap: () {
              Get.to(() => const HistoricalWidget());
            },
          ),
          ListTile(
            minLeadingWidth: 10,
            leading: const Icon(Icons.help_outline, color: Color(0xFF2F2E3B)),
            title: const Text('Ajuda', style: TextStyle(fontSize: 16),),
            onTap: () {},
          ),
          ListTile(
            minLeadingWidth: 10,
            leading: const Icon(Icons.info_outline, color: Color(0xFF2F2E3B)),
            title: const Text('Sobre', style: TextStyle(fontSize: 16),),
            onTap: () {},
          )    
        ],
      ),
    );
  } 
}