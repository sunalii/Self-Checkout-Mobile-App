import 'package:flutter/material.dart';
import 'package:selfcheckoutapp/widgets/bottom_tabs.dart';

class BillHistoryPage extends StatefulWidget {
  @override
  _BillHistoryPageState createState() => _BillHistoryPageState();
}

class _BillHistoryPageState extends State<BillHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill History"),
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
