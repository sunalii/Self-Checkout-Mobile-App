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

  Future<QuerySnapshot> _getData() async {
    return _firebaseServices.usersCartHistoryRef
        .doc(_firebaseServices.getUserId())
        .collection('Cart')
        .orderBy('time', descending: true)
        .get();
  }

  void _deleteCart() async {
    _getData().then((snapshot) {
      setState(() {
        for (QueryDocumentSnapshot snapshot in snapshot.docs) {
          snapshot.reference.delete();
        }
      });
    });
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
                      _getData();
                      Navigator.of(context).pop(true);
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
                future: _getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error: ${snapshot.error}"),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data != null) {
                      return ListView(
                        children: snapshot.data.docs.map((documents) {
                          return ListTile(
                            leading: Image.network("${documents['image']}"),
                            title: Text("${documents['name']}"),
                            trailing: Text("LKR ${documents['price']}0"),
                            subtitle: Text(
                                "Quantity: ${documents['quantity']}\nWeight: ${documents['weight']} kg"),
                            isThreeLine: true,
                          );
                        }).toList(),
                      );
                    } else
                      emptyBodyBuild();
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
