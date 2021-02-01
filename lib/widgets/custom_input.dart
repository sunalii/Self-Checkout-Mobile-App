import 'package:flutter/material.dart';
import 'package:selfcheckoutapp/constants.dart';

//Regular TextField Input Box
class CustomInput extends StatelessWidget {

  final String hintText;

  const CustomInput({Key key, this.hintText}) : super(key: key);

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

//Regular Password TextField Input Box
class CustomInputPassword extends StatelessWidget {

  final String hintText;

  const CustomInputPassword({Key key, this.hintText}) : super(key: key);

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
          obscureText: true,
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

//Register TextField Input Box
class CustomInputRegister extends StatelessWidget {

  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;

  const CustomInputRegister({Key key, this.hintText, this.onChanged, this.onSubmitted, this.focusNode, this.textInputAction}) : super(key: key);

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
          focusNode: focusNode,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          textInputAction: textInputAction,
          decoration: InputDecoration(
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
}

//Register Password TextField Input Box
class CustomInputRegisterPass extends StatelessWidget {

  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;

  const CustomInputRegisterPass({Key key, this.hintText, this.onChanged, this.onSubmitted, this.focusNode, this.textInputAction}) : super(key: key);

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
          focusNode: focusNode,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          textInputAction: textInputAction,
          obscureText: true,
          decoration: InputDecoration(
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
}

//Register Phone Number TextField Input Box
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
}