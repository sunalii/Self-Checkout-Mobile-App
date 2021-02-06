import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home',
        style: Constants.boldHeadingAppBar,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
        ),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: (){
            FirebaseAuth.instance.signOut();
          },
        ),
      ),
      body: ListView(
        children: [
        ],
      )
    );
  }
}
