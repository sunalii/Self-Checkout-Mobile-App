import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selfcheckoutapp/constants.dart';

//BOTTOM NAVIGATION BAR BUTTON - INCLUDED IN BottomTabs CLASS
class BottomTabBtn extends StatelessWidget {
  final IconData iconData; //CUSTOM ICON
  final String icon;
  final bool selected;
  final Function onPressed;

  const BottomTabBtn(
      {Key key, this.icon, this.selected, this.iconData, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //CHECKING WHETHER THE TAB IS SELECTED
    bool _selected = selected ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 28.0, horizontal: 16.0),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: _selected
                        ? Theme.of(context).accentColor
                        : Colors.transparent,
                    width: 2.0))),
        child: Icon(
          iconData ?? Icons.home_rounded,
          color: _selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}

//HOME NAVIGATION TABS
class HomeNavigateTabs extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Function onPressed;

  const HomeNavigateTabs({Key key, this.text, this.iconData, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                  color: Colors.white,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.08),
                  //     spreadRadius: 1.0,
                  //     blurRadius: 30.0,
                  //   ),
                  // ],
                ),
                child: Icon(
                  iconData ?? Icons.home_rounded,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(left: 30.0, right: 10.0),
                child: Text(
                  text ?? "Text",
                  textAlign: TextAlign.left,
                  style: Constants.regularHeading,
                ),
              ),
            ),
          ],
        ),
        //CONTAINER CONTINUED
        height: 60.0,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 0.2,
          ),
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              spreadRadius: 1.0,
              blurRadius: 20.0,
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
      ),
    );
  }
}

class CartBottomTabBtn extends StatelessWidget {
  final Function onPressed;

  const CartBottomTabBtn({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60.0,
        width: 150.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xffD50000),
          border: Border.all(
            color: Color(0xffD50000),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 30.0,
        ),
        child: Text(
          "Proceed",
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

Widget cartBottomTabTotal(double total) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 24.0,
      vertical: 30.0,
    ),
    child: Column(
      children: [
        Text(
          "Total",
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "LKR ${total.toString()}0",
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
