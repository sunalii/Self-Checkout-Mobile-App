import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';
import 'package:selfcheckoutapp/screens/bill_history_display.dart';

class BillHistoryPage extends StatefulWidget {
  @override
  _BillHistoryPageState createState() => _BillHistoryPageState();
}

class _BillHistoryPageState extends State<BillHistoryPage> {
  List billList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Bill History",
            style: Constants.boldHeadingAppBar,
          ),
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        body: Container(
          height: 85.0,
          width: double.infinity,
          child: Card(
            child: GestureDetector(
              child: ListTile(
                leading:
                    Icon(Icons.shopping_cart_outlined, color: Color(0xff1faa00)),
                trailing: Text(
                  "LKR 20000",
                  style: TextStyle(color: Color(0xffD50000)),
                ),
                title: Text("Date: April 21, 2021\nTime: 16:58:23"),
                subtitle: Text("Item Count: "),
                isThreeLine: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BillHistoryDisplay()),
                  );
                },
                onLongPress: () {},
              ),
            ),
            elevation: 5.0,
          ),
        ));
  }
}
