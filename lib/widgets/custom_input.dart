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
  final TextCapitalization textCapitalization;
  final TextInputType textInputType;
  final dynamic controller;

  const CustomInput(
      {Key key,
      this.hintText,
      this.onChanged,
      this.onSubmitted,
      this.focusNode,
      this.textInputAction,
      this.isPasswordField,
      this.controller,
      this.textCapitalization,
      this.textInputType})
      : super(key: key);

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
          controller: controller,
          obscureText: _isPasswordField,
          focusNode: focusNode,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          textCapitalization: textCapitalization,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText ?? "Hint Text...",
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0)),
          style: Constants.regularDarkText,
        ));
  }
}
