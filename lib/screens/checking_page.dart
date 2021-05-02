import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/services/firebase_services.dart';
import 'package:selfcheckoutapp/widgets/custom_button.dart';

class CheckingPage extends StatefulWidget {
  @override
  _CheckingPageState createState() => _CheckingPageState();
}

class _CheckingPageState extends State<CheckingPage> {

  FirebaseServices _firebaseServices = FirebaseServices();
   //final CollectionReference _userRef = FirebaseFirestore.instance.collection('UsersPayCheck');

  @override
  Widget build(BuildContext context) {
    //int totalWeight;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weight Checker",
          style: Constants.boldHeadingAppBar,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      body: Container(
        padding: EdgeInsets.only(
          bottom: 50.0,
        ),
        width: double.infinity,
        child: FutureBuilder<QuerySnapshot>(
          future: _firebaseServices.usersPayRef.get(),
          builder: (context, snapshot) {
            if(snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Error: ${snapshot.error}"),
                ),
              );
            }

            if(snapshot.connectionState == ConnectionState.done) {
              return ListView(
                children: snapshot.data.docs.map((documents) {
                  return Container(
                    color: Colors.pink,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Total Weight:   ${documents.data()['totalWeight']} Grams", style: Constants.boldHeading,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Total Price:   LKR ${documents.data()['totalPrice']}0", style: Constants.boldHeading,),
                        ),
                        Divider(),
                        CustomBtn(
                          text: "Check for Weight",
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text("hi"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );

            }

            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

        ),


      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 20.0,
          right: 8.0,
        ),
        child: Container(
          height: 60.0,
          width: 60.0,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.qr_code_rounded),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
