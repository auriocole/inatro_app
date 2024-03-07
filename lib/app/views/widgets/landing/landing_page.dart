import 'package:flutter/material.dart';
import 'package:inatro_app/app/views/colors/colors.dart';
import 'package:inatro_app/app/views/widgets/landing/dialogs/queryInfo_dialog.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10,),
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
                Image.asset('lib/app/assets/carro.png', width: 150, height: 150,), 
                SizedBox(height: 5),
                Text(
                  'Consultas Rápidas',
                  style: TextStyle(
                    color: secondary.shade400,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    QueryInfoDialog.showQueryInfoDialog(context);
                  },
                  child: Text(
                    'Ver Mais',
                    style: TextStyle(
                      color: primary,
                    ),
                  ),
                ),                
              ],
            ),
          ),

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
                Image.asset('lib/app/assets/pagamento2.png', width: 150, height: 150,),
                SizedBox(height: 5),
                Text(
                  'Formas de Pagamento',
                  style: TextStyle(
                    color: secondary.shade400,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                  },
                  child: Text(
                    'Ver Mais',
                    style: TextStyle(
                      color: primary,
                    ),
                  ),
                ),                
              ],
            ),
          ),
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
                Image.asset('lib/app/assets/historico.png', width: 150, height: 150,),
                SizedBox(height: 5),
                Text(
                  'Acesso ao Histórico',
                  style: TextStyle(
                    color: secondary.shade400,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                TextButton(
                  onPressed: () {

                  },
                  child: Text(
                    'Ver Mais',
                    style: TextStyle(
                      color: primary,
                    ),
                  ),
                ),               
              ],
            ),
          ),
        ],
      ),
    );
  }
}