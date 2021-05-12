import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//CUSTOM BUTTONS TO LOGIN AND REGISTER PAGES / WHITE - GREEN
class CustomBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;
  final bool isLoading;

  const CustomBtn(
      {Key key, this.text, this.onPressed, this.outlineBtn, this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outlineBtn ?? false;
    bool _isLoading = isLoading ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.transparent : Color(0xff1faa00),
          border: Border.all(
            color: Color(0xff1faa00),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 8.0,
        ),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                  text ?? "Text",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: _outlineBtn ? Color(0xff1faa00) : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//WHITE - BLUE
class CustomEditBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;
  final bool isLoading;

  const CustomEditBtn(
      {Key key, this.text, this.onPressed, this.outlineBtn, this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outlineBtn ?? false;
    bool _isLoading = isLoading ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60.0,
        width: 100.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.transparent : Colors.white,
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 8.0,
        ),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                  text ?? "Text",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: _outlineBtn ? Colors.white : Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
