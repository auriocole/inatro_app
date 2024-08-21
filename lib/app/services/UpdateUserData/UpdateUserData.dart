import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateUserData {
  static void updateUserData(String fieldName, String newValue) async {
    User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('usuario')
            .doc(user.uid)
            .get();
    
      await FirebaseFirestore.instance.collection('usuario').doc(userSnapshot.id).update({
        fieldName.toLowerCase(): newValue,
      });
    }
  }

}