import 'package:flutter/material.dart';
import 'package:selfcheckoutapp/widgets/custom_button.dart';
import 'package:selfcheckoutapp/widgets/custom_input.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                child: Text("Create A New Account",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,),
              ),
              Column(
                children: [
                  CustomInputRegister(
                    hintText: "Name...",
                  ),
                  CustomInputRegister(
                    hintText: "Email...",
                  ),
                  CustomInputRegisterPass(
                    hintText: "Password...",
                  ),
                  CustomInputRegNumber(
                    hintText: "Add Phone Number...",
                  ),
                  CustomBtn(
                    text: "Back to Login",
                    onPressed: (){
                      Navigator.pop(context);
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
                  onPressed: (){
                    print ("clicked");
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
