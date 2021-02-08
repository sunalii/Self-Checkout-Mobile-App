import 'package:flutter/material.dart';
import 'package:selfcheckoutapp/widgets/bottom_tabs.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(),
          BottomTabs(
            selectedTab: 3,
          ),
        ],
      ),
    );
  }
}
