import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
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

  void _submitForm() async {
    //SET THE FORM TO LOADING STATE
    setState(() {
      _registerFromLoading = true;
    });

    //RUN THE CREATE ACCOUNT METHOD
    String _createAccountFeedback = await _createAccount();
    if(_createAccountFeedback != null){
      _alertDialogBuilder(_createAccountFeedback);

      //SET THE FORM TO REGULAR STATE
      setState(() {
        _registerFromLoading = false;
      });
    }
    else{
      //STRING WAS NULL -> HOME PAGE
      Navigator.pop(context);
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
                  CustomInput(
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
                  CustomInput(
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
                  CustomBtn(
                    text: "Create New Account",
                    onPressed: () {
                      _submitForm();
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
