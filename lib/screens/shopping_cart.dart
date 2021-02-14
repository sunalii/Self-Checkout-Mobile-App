import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfcheckoutapp/widgets/bottom_tabs.dart';
import 'package:selfcheckoutapp/widgets/custom_button.dart';
import '../constants.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {

  String qrCode = 'unknown';

  Future _scanQR() async{
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#1faa00', //HEX COLOR
          "Cancel", //CANCEL BUTTON TEXT
          true, //FLASH USE
          ScanMode.BARCODE //SCAN MODE --> QR, BARCODE, DEFAULT
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException catch (e){
      setState(() {
        qrCode = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart",
          style: Constants.boldHeadingAppBar,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.blue,
              child: Text(qrCode),
            ),
          ),
          ItemScanBtn(
            iconData: Icons.qr_code_rounded,
            onPressed: _scanQR,
          ),
          CartBottomTab(),
        ],
      ),
    );
  }
}
