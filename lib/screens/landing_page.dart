import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:selfcheckoutapp/screens/loading.dart';
import 'package:selfcheckoutapp/screens/home.dart';
import 'package:selfcheckoutapp/screens/login.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }

        //CONNECTION INITIALIZED - FIREBASE APP IS RUNNING
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
            if (streamSnapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Error: ${streamSnapshot.error}"),
                ),
              );
            }

            //CONNECTION STATE ACTIVE - DO THE LOGIN
            if(streamSnapshot.connectionState == ConnectionState.active){

              //GET THE USER
              User _user = streamSnapshot.data;

              //IF THE USER IS NULL - NOT LOGGING IN
              if(_user == null){

                //USER NOT LOGGED IN - HEAD TO LOGIN PAGE
                return LoginPage();
              }else{

                //USER IS LOGGED IN - HEAD TO HOME PAGE
                return HomePage();
              }
            }

            //CHECKING THE AUTH STATE - LOADING
            return Scaffold(
              body: Center(
                child: Loading(),
              ),
            );
          },
          );
        }

        //CONNECTING TO FIREBASE - LOADING
        return Scaffold(
          body: Center(
            child: Text("Initialization App..."),
          ),
        );
      },
    );
  }
}
