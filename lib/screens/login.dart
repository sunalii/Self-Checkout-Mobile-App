import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/screens/register.dart';
import 'package:selfcheckoutapp/widgets/custom_button.dart';
import 'package:selfcheckoutapp/widgets/custom_input.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 24.0,
                ),
                child: Text(
                  "Welcome Shopper!\nLogin to your account",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: "Email...",
                  ),
                  CustomInput(
                    hintText: "Password...",
                    isPasswordField: true,
                  ),
                  CustomBtn(
                    text: "Login",
                    onPressed: () {
                      print("logged in");
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 24.0,
                ),
                child: CustomBtn(
                  text: "Create New Account",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()
                        )
                    );
                  },
                  outlineBtn: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
