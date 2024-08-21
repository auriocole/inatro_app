import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inatro_app/app/App.dart';
import 'package:inatro_app/app/config/firebaseDataOptions.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: FirebaseDataOptions.apiKey,
      appId: FirebaseDataOptions.appId,
      messagingSenderId: FirebaseDataOptions.messagingSenderId,
      projectId: FirebaseDataOptions.projectId,
      ),  
    );
  runApp(const App());
}
