import 'package:flutter/material.dart';
import 'package:selfcheckoutapp/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Login Page has been created",
            style: constants.regularHeading,
          ),
        ),
      ),
    );
  }
}
