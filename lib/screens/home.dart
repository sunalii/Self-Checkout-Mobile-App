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
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 50.0,
                  bottom: 120.0,
                  left: 50.0,
                  right: 30.0
                ),
                child: Container(
                  height: 150.0,
                  width: 150.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 50.0,
                    bottom: 120.0,
                    left: 50.0,
                    right: 20.0
                ),
                child: Container(
                  height: 150.0,
                  width: 150.0,
                  color: Colors.black,
                ),

              ),
            ],
          ),
        ],
      ),
    );
  }
}
