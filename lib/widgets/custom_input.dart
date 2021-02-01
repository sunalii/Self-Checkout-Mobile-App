import 'package:flutter/material.dart';
import 'package:selfcheckoutapp/constants.dart';

//TEXT FIELD INPUT BOX
class CustomInput extends StatelessWidget {

  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPasswordField;

  const CustomInput({Key key, this.hintText, this.onChanged, this.onSubmitted, this.focusNode, this.textInputAction, this.isPasswordField}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool _isPasswordField = isPasswordField ?? false;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: Color(0xfff2f2f2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        obscureText: _isPasswordField,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText ?? "Hint Text...",
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 20.0
          )
        ),
        style: Constants.regularDarkText,
      )
    );
  }
}

/*
//REGISTER PHONE NUMBER TEXT FIELD INPUT BOX
class CustomInputRegNumber extends StatelessWidget {

  final String hintText;

  const CustomInputRegNumber({Key key, this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: Color(0xfff2f2f2),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: TextField(
          keyboardType: TextInputType.number,
          maxLength: 10,
          decoration: InputDecoration(
            counterText: '',
              border: InputBorder.none,
              hintText: hintText ?? "Hint Text...",
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 5.0
              )
          ),
          style: Constants.regularDarkText,
        )
    );
  }
}*/