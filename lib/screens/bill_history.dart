import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/screens/bill_history_display.dart';

class BillHistoryPage extends StatefulWidget {
  @override
  _BillHistoryPageState createState() => _BillHistoryPageState();
}

class _BillHistoryPageState extends State<BillHistoryPage> {
  List billList = [];

  final CollectionReference _userRef = FirebaseFirestore
      .instance
      .collection('Users');

  User _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Bill History",
            style: Constants.boldHeadingAppBar,
          ),
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        body: Container(
          height: 85.0,
          width: double.infinity,
          child: Card(
            child: GestureDetector(
              child: StreamBuilder(
                  stream: _userRef.doc(_user.uid).collection('Cart').snapshots(),
                  builder: (context, snapshot) {
                    int _totalItems = 0;

                    if(snapshot.connectionState == ConnectionState.active){
                      List _documents = snapshot.data.docs;
                      _totalItems = _documents.length;
                    }

                    return ListTile(
                      leading:
                      Icon(Icons.shopping_cart_outlined, color: Color(0xff1faa00)),
                      trailing: Text(
                        "LKR 20000",
                        style: TextStyle(color: Color(0xffD50000)),
                      ),
                      title: Text("Date: April 21, 2021\nTime: 16:58:23"),
                      subtitle: Text("Item Count: $_totalItems" ?? "0" ),
                      isThreeLine: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BillHistoryDisplay()),
                        );
                      },
                      onLongPress: () {},
                    );
                  }
              ),
            ),
            elevation: 5.0,
          ),
        ));
  }
}
