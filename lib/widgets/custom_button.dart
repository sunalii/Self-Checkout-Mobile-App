import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {

  final String text;
  final Function onPressed;
  final bool outlineBtn;

  const CustomBtn({Key key, this.text, this.onPressed, this.outlineBtn}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool _outlineBtn = outlineBtn ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.transparent : Color(0XFF1faa00),
          border: Border.all(
            color: Color(0XFF1faa00),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 8.0,
        ),
        child: Text(text ?? "Text",
        style: TextStyle(
          fontSize: 16.0,
          color: _outlineBtn ? Color(0XFF1faa00) : Colors.white,
          fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
