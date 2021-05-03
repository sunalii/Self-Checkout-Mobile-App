import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/services/firebase_services.dart';

class BillHistoryPage extends StatefulWidget {
  @override
  _BillHistoryPageState createState() => _BillHistoryPageState();
}

class _BillHistoryPageState extends State<BillHistoryPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  List billList = [];

  // final CollectionReference _userRef = FirebaseFirestore
  //     .instance
  //     .collection('Users').doc(_user.uid).collection("Cart");
  //
  // User _user = FirebaseAuth.instance.currentUser;

  void _deleteCart() async {
    _firebaseServices.usersCartRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .snapshots()
        .forEach((element) {
      for (QueryDocumentSnapshot snapshot in element.docs) {
        snapshot.reference
            .delete(); //first time -- add > delete //second time -- add and deleting at the same time
      }
      //_goBack();
    });
    //return _goBack();
  }

  Future<bool> _popUpMenu() async {
    return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Delete Cart'),
                content: Text('Are you sure you want to delete the cart?'),
                actions: [
                  TextButton(
                    child: Text(
                      "No",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  TextButton(
                    child: Text(
                      "Yes",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      _deleteCart();
                      Navigator.of(context).pop(true);
                      setState(() {
                        emptyBodyBuild();
                      });
                    },
                  ),
                ],
              );
            }) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart History",
          style: Constants.boldHeadingAppBar,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: _popUpMenu,
              child: Icon(Icons.more_vert_rounded),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            width: double.infinity,
            child: FutureBuilder<QuerySnapshot>(
                future: _firebaseServices.usersCartRef
                    .doc(_firebaseServices.getUserId())
                    .collection('Cart')
                    .orderBy('time', descending: true)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error: ${snapshot.error}"),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData != null) {
                      return ListView(
                        children: snapshot.data.docs.map((documents) {
                          return ListTile(
                            leading:
                                Image.network("${documents.data()['image']}"),
                            title: Text("${documents.data()['name']}"),
                            trailing: Text("LKR ${documents.data()['price']}"),
                            subtitle: Text(
                                "Quantity: ${documents.data()['quantity']}\nWeight: ${documents.data()['weight']} g"),
                            isThreeLine: true,
                          );
                        }).toList(),
                      );
                    } else {
                      emptyBodyBuild();
                    }
                  }
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  Container emptyBodyBuild() {
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Icon(
              Icons.remove_shopping_cart_outlined,
              size: 50.0,
              color: Colors.black26,
            ),
            Text(
              "No history to show!",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
