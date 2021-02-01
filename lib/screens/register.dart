import 'package:flutter/material.dart';
import 'package:selfcheckoutapp/widgets/custom_button.dart';
import 'package:selfcheckoutapp/widgets/custom_input.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  //Alert Dialog to display errors
  Future<void> _alertDialogBuilder() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text("Error"),
          content: Container(
            child: Text("An error has been occurred!"),
          ),
          actions: [
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }

  //Default Loading State
  bool _registerFromLoading = false;

  //Form Input Values
  String _registerName = "";
  String _registerEmail = "";
  String _registerPassword = "";
//  int _registerPhoneNumber = '' as int;

  //Focus Node for Input Fields
  FocusNode _inputFocusNodeName;
  FocusNode _inputFocusNodeEmail;
  FocusNode _inputFocusNodePassword;

  @override
  void initState() {
    _inputFocusNodeName = FocusNode();
    super.initState();

    _inputFocusNodeEmail = FocusNode();
    super.initState();

    _inputFocusNodePassword = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _inputFocusNodeName.dispose();
    super.dispose();

    _inputFocusNodeEmail.dispose();
    super.dispose();

    _inputFocusNodePassword.dispose();
    super.dispose();
  }

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
                  "Create A New Account",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  CustomInputRegister(
                    hintText: "Name...",
                    onChanged: (value){
                      _registerName = value;
                    },
                    onSubmitted: (value){
                      _inputFocusNodeName.requestFocus();
                    },
                  ),
                  CustomInputRegister(
                    hintText: "Email...",
                    onChanged: (value){
                      _registerEmail = value;
                    },
                    onSubmitted: (value){
                      _inputFocusNodeEmail.requestFocus();
                    },
                    focusNode: _inputFocusNodeName,
                  ),
                  CustomInputRegisterPass(
                    hintText: "Password...",
                    onChanged: (value){
                      _registerPassword = value;
                    },
                    onSubmitted: (value){
                      _inputFocusNodePassword.requestFocus();
                    },
                    focusNode: _inputFocusNodeEmail,
                  ),
                  CustomInputRegNumber(
                    hintText: "Add Phone Number...",
                  ),
                  CustomBtn(
                    text: "Create New Account",
                    onPressed: () {
                      //Navigator.pop(context);
                     // _alertDialogBuilder();
                      setState(() {
                        _registerFromLoading = true;
                      });
                    },
                    isLoading: _registerFromLoading,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 24.0,
                ),
                child: CustomBtn(
                  text: "Back to Login",
                  onPressed: () {
                    print("clicked");
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
