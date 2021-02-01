import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:selfcheckoutapp/widgets/custom_button.dart';
import 'package:selfcheckoutapp/widgets/custom_input.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  //ALERT DIALOG TO DISPLAY ERRORS
  Future<void> _alertDialogBuilder() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
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

  //CREATE A NEW ACCOUNT
  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
      return e.message;
    }
    catch (e){
      return (e);
    }
  }



  //DEFAULT LOADING STATE
  bool _registerFromLoading = false;

  //FORM INPUT VALUES
  String _registerName = "";
  String _registerEmail = "";
  String _registerPassword = "";
//  int _registerPhoneNumber = '' as int;

  //FOCUS NODE FOR INPUT FIELDS
  FocusNode _inputFocusNodeName;
  FocusNode _inputFocusNodeEmail;
  FocusNode _inputFocusNodePassword;

  //FOCUS ON
  @override
  void initState() {
    _inputFocusNodeName = FocusNode();
    super.initState();

    _inputFocusNodeEmail = FocusNode();
    super.initState();

    _inputFocusNodePassword = FocusNode();
    super.initState();
  }

  //FOCUS OFF
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
                    onChanged: (value) {
                      _registerName = value;
                    },
                    onSubmitted: (value) {
                      _inputFocusNodeName.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInputRegister(
                    hintText: "Email...",
                    onChanged: (value) {
                      _registerEmail = value;
                    },
                    onSubmitted: (value) {
                      _inputFocusNodeEmail.requestFocus();
                    },
                    focusNode: _inputFocusNodeName,
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInputRegister(
                    hintText: "Password...",
                    isPasswordField: true,
                    onChanged: (value) {
                      _registerPassword = value;
                    },
                    onSubmitted: (value) {
                      _inputFocusNodePassword.requestFocus();
                    },
                    focusNode: _inputFocusNodeEmail,
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInputRegNumber(
                    hintText: "Add Phone Number...",
                  ),
                  CustomBtn(
                    text: "Create New Account",
                    onPressed: () {
                      m
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
