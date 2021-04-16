import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/constants.dart';

class BillHistoryDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "April 21, 2021",
        style: Constants.boldHeadingAppBar
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        backgroundColor: Colors.blue,
        toolbarHeight: 80.0,
      ),
      body: Container(
        width: double.infinity,
        color: Colors.blue,
        child: Row(
          children: [
            Text("Date: April 21 2021\n"
                "Time: 16:58:23\n"
                "Products Count: 8\n"
                "Total: LKR 300.00",
            style: Constants.regularWhiteText,),
          ],
        ),
      ),
    );
  }
}
