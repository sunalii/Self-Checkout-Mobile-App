import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String userId;

  DatabaseServices({this.userId});

  final CollectionReference cartCollection =
  FirebaseFirestore.instance.collection('Products');

  Future updateUserData(int proQuantity, int proWeight, int proTotal) async {
    return await cartCollection.doc(userId).set({
      'productQuality': proQuantity,
      'productWeight': proWeight,
      'productTotal': proTotal,
    });
  }
}

