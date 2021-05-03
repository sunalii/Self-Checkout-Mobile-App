import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/screens/bill_history_display.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Cart History",
            style: Constants.boldHeadingAppBar,
          ),
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        body: Container(
          height: 85.0,
          width: double.infinity,
          child: Card(
            child: FutureBuilder<QuerySnapshot>(
                future: _firebaseServices.usersCartRef.doc(_firebaseServices.getUserId()).collection('Cart').orderBy('time', descending: true).get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error: ${snapshot.error}"),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.done) {

                    // return ListView.builder(
                    //   itemCount: snapshot.data.docs.length,
                    //   itemBuilder: (BuildContext context, index) {
                    //     return ListTile(
                    //       leading: Image.network("${snapshot.data[index]['image']}"),
                    //       title: Text("${documents.data()['name']}"),
                    //       trailing: Text("LKR ${documents.data()['price']}"),
                    //       subtitle: Text("Quantity: ${documents.data()['quantity']}\nWeight: ${documents.data()['weight']} g"),
                    //       isThreeLine: true,
                    //
                    //     );
                    //   }
                    // );
                  } else {
                    return Scaffold(
                      body: Container(
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
                      ),
                    );
                  }

                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
            ),
            elevation: 5.0,
          ),
        ));
  }
}
