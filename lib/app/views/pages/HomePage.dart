import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inatro_app/app/services/UserData/UserData.dart';
import 'package:inatro_app/app/views/colors/Colors.dart';
import 'package:inatro_app/app/views/pages/LoginPage.dart';
import 'package:inatro_app/app/views/widgets/landing/LandingPageWidget.dart';
import 'package:inatro_app/app/views/widgets/navbar/NavBar.dart';
import 'package:inatro_app/app/views/widgets/query/QueryWidget.dart';
import 'package:inatro_app/app/views/widgets/userData/ProfileWidget.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget currentPage = const LandingPageWidget();
  bool isFloatingButtonVisible = true;
  late Map<String, String> _userData;

 @override
 void initState() {
    super.initState();
    _userData = {};
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    Map<String, String> userData = await UserData.getUserData();
    setState(() {
      _userData = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          color: Colors.white,
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        backgroundColor: primary,
        elevation: 0,
        foregroundColor: secondary,
        actions: <Widget> [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () async { 
              Get.to(() => ProfileWidget(userData: _userData));
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    title: const Text(
                      "Deseja sair?",
                      style: TextStyle(
                          fontSize: 16
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
                        onPressed: () async {
                          FirebaseAuth.instance.signOut();
                          Get.offAll(() => const LoginPage());
                        },
                        child: const Text(
                          'Sair',
                          style: TextStyle(
                              color: Colors.red
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      drawer: NavBar(userData: _userData),
      body: currentPage,
      floatingActionButton: currentPage is LandingPageWidget
      ? FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: primary,
        child: const Icon(Icons.search, color: Colors.white),
        onPressed: () {
          Get.to(() => const Querywidget());
        }
      )
      : null,
    );
  }  
}