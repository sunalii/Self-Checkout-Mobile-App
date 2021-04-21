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

class AuthUtil {
  static Future<User> getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    return user;
  }

  static Future<DocumentSnapshot> getCurrentUserFromFS(User user) async {
    try {
      if (user != null) {
        print("user id is ${user.uid}");
        return FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
//            .then((ds) {
//          print("got user from fs ${ds["email"]}");
//          return ds;
//        });
      } else {
        print("user is null");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
