import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// class FirebaseServices {
//   FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//   String getUserId() {
//     return _firebaseAuth.currentUser.uid;
//   }
//
//   final CollectionReference productsRef =
//       FirebaseFirestore.instance.collection("Products");
//
//   final CollectionReference usersRef =
//       FirebaseFirestore.instance.collection("Users");
// }

Future<void> userSetup(String displayName) async {
  CollectionReference users =
      FirebaseFirestore.instance.collection('UserDetails');
  FirebaseAuth auth = FirebaseAuth.instance;

  String uid = auth.currentUser.uid.toString();
  String displayName = auth.currentUser.displayName.toString();

  users.add({'displayName': displayName, 'uid': uid});
  return;
}

