import 'package:flutter/material.dart';
import 'package:selfcheckoutapp/widgets/bottom_tabs.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping List"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(),
          BottomTabs(
            selectedTab: 1,
          ),
        ],
      ),
    );
  }
}
