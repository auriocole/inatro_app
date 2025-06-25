import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inatro_app/app/App.dart';
//import 'package:inatro_app/app/config/firebaseDataOptions.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDl9-kzLY9ypOfAd0pXaQKs7dt_T_DbuPs",
      appId: "1:949029319471:web:8737fc91452c81d36a67da",
      messagingSenderId: "949029319471",
      projectId: "teste-10b39",
      ),  
    );
  runApp(const App());
}
