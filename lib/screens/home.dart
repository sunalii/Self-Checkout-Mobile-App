import 'package:flutter/material.dart';
import 'package:selfcheckoutapp/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Home Page",
            style: Constants.regularHeading,
          ),
        ),
      ),
    );
  }
}
