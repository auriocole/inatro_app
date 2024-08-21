import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  static Future<Map<String, String>> getUserData() async {
    Map<String, String> userData = {};

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('usuario')
          .doc(user.uid)
          .get();

      if (userSnapshot.exists) {
          userData['nome'] = userSnapshot['nome'];
          userData['email'] = userSnapshot['email'];
          userData['identidade'] = userSnapshot['identidade'];
          userData['telefone'] = userSnapshot['telefone'];
      }
    }
    return userData;
  }
}