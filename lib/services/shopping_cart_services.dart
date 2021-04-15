import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:selfcheckoutapp/models/item.dart';
import 'package:selfcheckoutapp/models/user.dart';

// class DatabaseServices {
//   final String userId;
//
//   DatabaseServices({this.userId});
//
//   final CollectionReference cartCollection =
//   FirebaseFirestore.instance.collection('Products');
//
//   Future updateUserData(int proQuantity, int proWeight, int proTotal) async {
//     return await cartCollection.doc(userId).set({
//       'productQuality': proQuantity,
//       'productWeight': proWeight,
//       'productTotal': proTotal,
//     });
//   }
// }

class DataBaseService {
  final String uid;

  DataBaseService({this.uid});

  // collection reference
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('items');

  Future updateUserData(String name, String price, int quantity) async {
    return await itemCollection.doc(uid).set({
      'item_name': name,
      'item_price': price,
      'quantity': quantity,
    });
  }

  // item list from snapshot
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Item(
        name: doc.data()['item_name'].toString(),
        price: doc.data()['item_price'].toString(),
        quantity: doc.data()['quantity'],
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['item_name'],
      price: snapshot.data()['item_price'],
      quantity: snapshot.data()['quantity'],
    );
  }

  // get items stream
  Stream<List<Item>> get items {
    return itemCollection.snapshots().map(_itemListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return itemCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
