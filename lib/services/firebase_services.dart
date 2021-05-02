import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices{

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String getUserId() {
    return _firebaseAuth.currentUser.uid;
  }

  String getCurrentUserName() {
    return _firebaseAuth.currentUser.displayName;
  }

  String getCurrentEmail() {
    return _firebaseAuth.currentUser.email;
  }

  final CollectionReference productsRef = FirebaseFirestore
      .instance
      .collection('Products');

  final CollectionReference usersRef = FirebaseFirestore
      .instance
      .collection('Users'); // TO STORE USERS CART | User-->userId->Cart-->productId

  final CollectionReference usersPayRef = FirebaseFirestore
      .instance
      .collection("UsersPayCheck");
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:selfcheckoutapp/models/item.dart';
// import 'package:selfcheckoutapp/models/user.dart';
//
// // class DatabaseServices {
// //   final String userId;
// //
// //   DatabaseServices({this.userId});
// //
// //   final CollectionReference cartCollection =
// //   FirebaseFirestore.instance.collection('Products');
// //
// //   Future updateUserData(int proQuantity, int proWeight, int proTotal) async {
// //     return await cartCollection.doc(userId).set({
// //       'productQuality': proQuantity,
// //       'productWeight': proWeight,
// //       'productTotal': proTotal,
// //     });
// //   }
// // }
//
// // class DataBaseService {
// //   final String uid;
// //
// //   DataBaseService({this.uid});
// //
// //   // collection reference
// //   final CollectionReference itemCollection =
// //       FirebaseFirestore.instance.collection('items');
// //
// //   Future updateUserData(String name, String price, int quantity) async {
// //     return await itemCollection.doc(uid).set({
// //       'item_name': name,
// //       'item_price': price,
// //       'quantity': quantity,
// //     });
// //   }
// //
// //   // item list from snapshot
// //   List<Item> _itemListFromSnapshot(QuerySnapshot snapshot) {
// //     return snapshot.docs.map((doc) {
// //       return Item(
// //         name: doc.data()['item_name'].toString(),
// //         price: doc.data()['item_price'].toString(),
// //         quantity: doc.data()['quantity'],
// //       );
// //     }).toList();
// //   }
// //
// //   // userData from snapshot
// //   UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
// //     return UserData(
// //       uid: uid,
// //       name: snapshot.data()['item_name'],
// //       price: snapshot.data()['item_price'],
// //       quantity: snapshot.data()['quantity'],
// //     );
// //   }
// //
// //   // get items stream
// //   Stream<List<Item>> get items {
// //     return itemCollection.snapshots().map(_itemListFromSnapshot);
// //   }
// //
// //   // get user doc stream
// //   Stream<UserData> get userData {
// //     return itemCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
// //   }
// // }
//
// class CartItem {
//   final String id;
//   final String name;
//   final int quantity;
//   final double price;
//
//   CartItem(
//       {@required this.id,
//         @required this.name,
//         @required this.quantity,
//         @required this.price});
// }
//
// class Cart with ChangeNotifier {
//   Map<String, CartItem> _items = {};
//
//   Map<String, CartItem> get items {
//     return {..._items};
//   }
//
//   int get itemCount {
//     return _items.length;
//   }
//
//   void addItem(String pdtid, String name, double price) {
//     if (_items.containsKey(pdtid)) {
//       _items.update(
//           pdtid,
//               (existingCartItem) => CartItem(
//               id: DateTime.now().toString(),
//               name: existingCartItem.name,
//               quantity: existingCartItem.quantity + 1,
//               price: existingCartItem.price));
//     } else {
//       _items.putIfAbsent(
//           pdtid,
//               () => CartItem(
//             name: name,
//             id: DateTime.now().toString(),
//             quantity: 1,
//             price: price,
//           ));
//     }
//     notifyListeners();
//   }
//
//   void removeItem(String id) {
//     _items.remove(id);
//     notifyListeners();
//   }
//
//   void removeSingleItem(String id) {
//     if (!_items.containsKey(id)) {
//       return;
//     }
//     if (_items[id].quantity > 1) {
//       _items.update(
//           id,
//               (existingCartItem) => CartItem(
//               id: DateTime.now().toString(),
//               name: existingCartItem.name,
//               quantity: existingCartItem.quantity - 1,
//               price: existingCartItem.price));
//     }
//     notifyListeners();
//   }
//
//   double get totalAmount {
//     var total = 0.0;
//     _items.forEach((key, cartItem) {
//       total += cartItem.price * cartItem.quantity;
//     });
//     return total;
//   }
//
//   void clear() {
//     _items = {};
//     notifyListeners();
//   }
// }